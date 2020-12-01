from flask import Blueprint
from . import food_api
from .db import get_db

class NestedBlueprint(object):
    def __init__(self, blueprint, prefix):
        super(NestedBlueprint, self).__init__()
        self.blueprint = blueprint
        self.prefix = '/' + prefix

    def route(self, rule, **options):
        rule = self.prefix + rule
        return self.blueprint.route(rule, **options)
        self.record(deferred)

bp = Blueprint('api', __name__, url_prefix='/api') # Setting up for the blueprint
food = NestedBlueprint(bp, 'Food')

@food.route('')
def test():
    return 'hello'

@food.route('/description/<int:food_id>', methods=('GET', 'POST'))
def get_food_description(food_id=1):
    db = get_db()
    error = None
    data = db.execute('SELECT foodNameCHN, calories, carbohydrate, fat, protein, cholesterol FROM Foods WHERE foodID = %i' % food_id)
    return '.'