import pandas,sqlite3 # Import pandas and sqlite3

# Create foods dataframe from the foodDataSet.csv
foods = pandas.read_csv('foodDataSet.csv', usecols=[0,2,4,5,6,7,8,9,10,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29])

# sqlite3 config
conn = sqlite3.connect('bddb.db')
c = conn.cursor()

# Fetched the data into the bddb.db database by creating a table called Foods
foods.to_sql('Foods', conn, if_exists='append',index= False)