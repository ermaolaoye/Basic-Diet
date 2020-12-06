import sqlite3
conn = sqlite3.connect("bddb.db")
cursor = conn.cursor()

userInput = "馒头"
rows = cursor.execute("SELECT foodNameCHN FROM Foods WHERE foodNameCHN LIKE %s" % userInput)
for row in rows:
    print(row)