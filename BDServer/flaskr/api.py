from flask import Blueprint, request, abort
from .db import get_db
from .jwt import get_userJWT
from .util import getUserRecCalories, getUserAge
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
    cursor = db.execute("SELECT userID FROM Users WHERE " % para)
    dictData = [row[0] for row in cursor.fetchall()]
    userID = int(dictData[0])
    return userID

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
        # Get user id from database
        cursor = db.execute("SELECT userID FROM Users WHERE userName==\"%s\"" % user['userName'])
        dictData = [row[0] for row in cursor.fetchall()]
        # Get the corresponding JWT for user
        JWT = get_userJWT(int(dictData[0]))
        # Get user recommend calories
        recCalories = getUserRecCalories(int(user['userWeight']),int(user['userHeight']),int(getUserAge(user['userBirthday'])),user['userGender'])
        # Update calories and jwt to database
        db.commit()
        db.execute('''UPDATE Users SET JWT=\"%s\", userCalories=%i WHERE userName=\"%s\"''' % (JWT, recCalories, user['userName']))
        db.commit()
        # Return JWT
        return JWT

@user.route('/login', method=('GET','POST'))
def user_login():
    """
    JSON Requirement
    userEmail   Email of the user
    password    Password input
    """
    if request.method == 'POST':
        user = request.json
        sql = '''SELECT userPassword FROM Users WHERE userEmail=\"%s\"''' % (user['userEmail'])
        db = get_db()
        cursor = db.execute(sql)
        dictData = [row[0] for row in cursor.fetchall()]
        db_userPassword = dictData[0]
        input_userPassword = user['password']
        return "Test"



# - Records
@record.route('addRecord', methods=('GET','POST'))
def test():
     return "hello"
