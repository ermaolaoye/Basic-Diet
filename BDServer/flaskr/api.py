from flask import Blueprint, request
from .db import get_db
from .jwt import get_userJWT
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
record = NestedBlueprint(bp, 'Record') # Apis about records

def query2Json(sql, para):
    """
    Parameters:
    sql         The sql statement
    para        The parameter for the sql statement
    """
    db = get_db()
    cursor = db.execute(sql % para)
    dictData = [dict(row) for row in cursor.fetchall()]
    return json.dumps(dictData)

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
    json = query2Json(sql=sql, para=para)
    return json

@food.route('/list/<string:user_input>', methods=('GET','POST'))
def get_list_food(user_input):
    """
    Parameter:
    user_input  The user input of the name of food they're looking for
    """
    sql = """SELECT foodNameCHN FROM Foods WHERE foodNameCHN LIKE '%s'"""
    para = "%" + user_input + "%"
    json = query2Json(sql=sql, para=para)
    return json

# - Users
@user.route('/addUser', methods=('GET','POST'))
def user_register():
    if request.method == 'POST':
        data = request.get_json()
        data_j = json.loads(data)