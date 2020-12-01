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

def init_db():
    db = get_db()

def init_app(app):
    app.teardown_appcontext(close_db) # This tells the application to close the connection after returning the response