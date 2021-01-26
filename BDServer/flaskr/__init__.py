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
    @app.route('/hello/<username>')
    def hello(username=""):
        return 'Hello World' + username
    
    from . import db
    db.init_app(app) # setting up the connection with database

    from . import api
    app.register_blueprint(api.APIblueprint) # setting up the connection with the api bluprint

    return app
