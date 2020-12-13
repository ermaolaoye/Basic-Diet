from flask import Blueprint, request, abort
from .db import get_db
from .jwt import get_userJWT
from .util import getUserRecCalories, getUserAge
from datetime import datetime
import json

class NestedBlueprint(object): # Object for creating nested blueprint
    def __init__(self, blueprint, prefix):
        super(NestedBlueprint, self).__init__()
        self.blueprint = blueprint
        self.prefix = '/' + prefix

    def route(self, rule, **options):
        rule = self.prefix + rule
        return self.blueprint.route(rule, **options)

bp = Blueprint('api', __name__, url_prefix='/api') # Setting up for the api blueprint
food = NestedBlueprint(bp, 'Food') # APIs about foods
user = NestedBlueprint(bp, 'User') # APIs about users
record = NestedBlueprint(bp, 'Record') # APIs about records

def query2Json(sql, para, abort400=False):
    """
    Parameters:
    sql         The sql statement
    para        The parameter for the sql statement
    abort400    A boolean variable, if cannot find the corresponding item then abort HTTP 400 error.
    """
    db = get_db()
    cursor = db.execute(sql % para)
    dictData = [dict(row) for row in cursor.fetchall()]
    if abort400 == True:
        if not dictData: # Empty dictionary evaluate to False in python
            abort(400)
    return json.dumps(dictData)

def getUserID(para):
    """
    Parameters:
    para        Parameter for filtering the userID
                Parameter needs to contain \" when utilizing string data
    """
    db = get_db()
    cursor = db.execute("SELECT userID FROM Users WHERE %s" % para)
    dictData = [row[0] for row in cursor.fetchall()]
    userID = int(dictData[0])
    return userID

def JWTverification(JWT, userID):
    """
    Parameters:
    JWT         JWT input from the frontend
    userID      ID of the user for verificating its JWT
    """
    # Find the JWT stored in the server corresponding with the input
    sql = '''SELECT JWT FROM Users WHERE userID=%i''' % userID
    db = get_db()
    cursor = db.execute(sql)
    dictData = [row[0] for row in cursor.fetchall()]
    db_JWT = str(dictData[0])
    # Equal to frontend input then return True
    if db_JWT == JWT:
        return True
    else:
        return False

# - Foods
@food.route('/description/<int:food_id>', methods=('GET', 'POST'))
def get_food_description(food_id=1):
    """
    Parameter:
    food_id     The id of the description of the food that client is looking for
    """
    sql = """SELECT foodNameCHN, calories, carbohydrate, fat, protein, cholesterol 
    FROM Foods WHERE foodID = %i"""
    para = food_id
    json = query2Json(sql=sql, para=para, abort400=True)
    return json

@food.route('/list/<string:user_input>', methods=('GET','POST'))
def get_list_food(user_input):
    """
    Parameter:
    user_input  The user input of the name of food they're looking for
    """
    sql = """SELECT foodNameCHN FROM Foods WHERE foodNameCHN LIKE '%s'"""
    para = "%" + user_input + "%"
    json = query2Json(sql=sql, para=para, abort400=True)
    return json

# - Users
@user.route('/addUser', methods=('GET','POST'))
def user_register():
    """
    JSON Requirement
    userName    A string value that contains user name
    userGender  A string value that tells user gender
    password    A string value that contains SHA2 hashed value of password
    userEmail   A string value that contains user email
    userWeight  A integer value of the user's weight
    userBirthdayA string value of user's birthday
    """
    if request.method == 'POST':
        user = request.json
        # Insert the user information to database
        sql = '''INSERT INTO Users(userName, userGender, userEmail, userWeight, userHeight, userPassword, userBirthday) VALUES(\"%s\", \"%s\", \"%s\", %i, %i,\"%s\", \"%s\")''' % (user['userName'], user['userGender'], user['userEmail'], user['userWeight'], user['userHeight'],user['password'], user['userBirthday'])
        db = get_db()
        db.execute(sql)
        db.commit()
        # Get the corresponding JWT for user
        para = "userEmail == \"%s\"" % user['userEmail']
        JWT = get_userJWT(getUserID(para = para))
        # Get user recommend calories
        recCalories = getUserRecCalories(int(user['userWeight']),int(user['userHeight']),int(getUserAge(user['userBirthday'])),user['userGender'])
        # Update calories and jwt to database
        db.commit()
        db.execute('''UPDATE Users SET JWT=\"%s\", userCalories=%i WHERE userEmail=\"%s\"''' % (JWT, recCalories, user['userEmail']))
        db.commit()
        # Return JWT
        return JWT

@user.route('/login', methods=('GET','POST'))
def user_login():
    """
    JSON Requirement
    userEmail   Email of the user
    password    Password input
    """
    if request.method == 'POST':
        user = request.json
        # GET the password's hashed value that stored in the database
        sql = '''SELECT userPassword FROM Users WHERE userEmail=\"%s\"''' % (user['userEmail'])
        db = get_db()
        cursor = db.execute(sql)
        dictData = [row[0] for row in cursor.fetchall()]
        db_userPassword = str(dictData[0])
        input_userPassword = str(user['password'])
        # When input password is the same as the password stored in the database
        if db_userPassword == input_userPassword:
            # Get corresponding userID and update user's JWT
            para = "userEmail == \"%s\"" % user['userEmail']
            JWT = get_userJWT(getUserID(para = para))
            db.commit()
            db.execute('''UPDATE Users SET JWT=\"%s\" WHERE userEmail=\"%s\"''' % (JWT, user['userEmail']))
            db.commit()
            # Return the new JWT
            return JWT 
        # Return error message when input is incorrect
        else:
            return "WrongInput"

@user.route('/description', methods=('GET','POST'))
def get_user_description():
    """
    JSON Requirement
    userJWT     JWT stored in the frontend
    userID      The ID of the user
    """
    if request.method == 'POST':
        user = request.json
        # JWT Verification
        if not JWTverification(JWT = str(user['userJWT']), userID = int(user['userID'])):
            abort(401)
        sql = '''SELECT userName, userEmail ,userWeight ,userHeight ,userCalories ,userBirthday ,userGender FROM Users WHERE userID = %i'''
        para = int(user['userID'])
        json = query2Json(sql=sql, para=para, abort400=False)
        return json
# - Records
@record.route('/addRecord', methods=('GET','POST'))
def record_register():
    """
    JSON Requirement
    userID      ID of the user
    userJWT     JWT stored in the frontend
    foodID      ID of the food
    quantity    Quantity of consumption
    unit        string value of unit
    """
    if request.method == 'POST':
        record = request.json
        # JWT Verification
        if not JWTverification(JWT=str(record['userJWT']), userID=int(record['userID'])):
            abort(401)
        # Get current time
        currentTime = datetime.now()
        str_currentTime = currentTime.strftime("%d/%m/%Y %H:%M:%S")
        # Insert the data into the database
        sql = '''INSERT INTO Records(userID, foodID, date, quantity, unit) VALUES(%i, %i, \"%s\", %f, \"%s\")''' % (record['userID'], record['foodID'], str_currentTime, record['quantity'], record['unit'])
        # Return Succeed
        db = get_db()
        db.execute(sql)
        db.commit()
        # Return Succeed
        return 'succeed'
