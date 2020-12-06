# Iteration Stage 1

# Food Database

I downloaded an food nutrition information data set from a research center.

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled.png)

The dataset is stored in .xlsx form, and it includes some column that is not essential to my app. The first thing I do, is to write a python code to decode this dataset and fetch all of its essential data to my food database which is created by using the code in the design stage.

I use the pandas data analysis module to create an dataframe from the csv dataset file.

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%201.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%201.png)

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%202.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%202.png)

I select the essential part of data by using the usecol parameter in the read_csv method.

The data is then fetched into the database.

# Flask web-service framework

## Project Layout

这里应该有个图片

## Application Setup

I create an application factory function for creating the Flask instance. Configuration, registration and other setup the application needs will happen inside this application factory function, the application will be returned at the end.

By using the following command in the terminal, I create the flaskr folder within the application, and the [init.py](http://init.py) file to let python treat this directory as packages.

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%203.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%203.png)

The [init.py](http://init.py) file create the application factory as the create_app function.

```python
import os
from flask import Flask

def create_app(test_config=None):
    '''
    Parameters:
    test_config     The overrides default configuration file.
    '''
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True) # __name__ is the name of the current Python module.
    app.config.from_mapping( # set the default configuration that app will use
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'bddb.db'),
    )

    if test_config is None:
        # When there's no parameter passed to test_config, load the instance config
        app.config.from_pyfile('config.py', silent=True)
    else:
        # Load the test config if passed in
        app.config.from_mapping(test_config)

    # Ensuring the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello
    @app.route('/hello')
    def hello():
        return 'Hello World'
    
    return app
```

Then, I made a test run of this application by using these commands in the terminal.

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%204.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%204.png)

By visiting [http://127.0.0.1:5000/hello](http://127.0.0.1:5000/hello) in my browser, I see the hello page that I create in the application folder which claims this flask app is running correctly.

![Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%205.png](Iteration%20Stage%201%2020727bd6b5a944bc984f4b75111e9f6c/Untitled%205.png)

## Database connection setup

I created an [db.py](http://db.py) file in the flaskr folder that describes how the app communicate with the database.

```python
import sqlite3
from flask import current_app, g # g is a namespace object that can store data during an application context.

def get_db():
    if 'db' not in g: # if the object g does not have database, then create a new connection with it
        g.db = sqlite3.connect(
            current_app.config['DATABASE'], # the path of database is assigned in the __init__.py file
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row # this tells the connection to return rows behave like dicts. Allows accesssing the columns by name
    
    return g.db

def close_db(e=None): # This function is ressponsible for closing the connection when the request is done.
    db = g.pop('db', None)

    if db is not None:
        db.close()

def init_app(app): # setting up the connection with the app
    app.teardown_appcontext(close_db) # This tells the application to close the connection after returning the response
```

The [db.py](http://db.py) module is then imported into [init.py](http://init.py) file, by adding the following code before the return statement.

```python
def create_app(test_config=None):
	......
	from . import db
    db.init_app(app) # setting up the connection with database
	
	return app
```

## Blueprint for API

A view function is the code that respond to request to the application. A Blueprint in flask is a way to organize a group of related views and other codes.

For all my apis, I created a blueprint called api.

Firstly, I create the [api.py](http://api.py) file in the flaskr folder.

```python
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
```

NOT FINISHED
