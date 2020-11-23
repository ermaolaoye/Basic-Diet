import os
import pandas
import numpy
from scipy.sparse import csr_matrix
from sqlalchemy import create_engine
from sklearn.neighbors import NearestNeighbors

# Read Data From Database
engine = create_engine('sqlite:///bddb.db')

dfFoods = pandas.read_sql_table(
    table_name = "Foods",
    con = engine,
    columns = ['foodID', 'foodName'],
    coerce_float = False
    )

dfRatings = pandas.read_sql_table(
    table_name = "Ratings",
    con = engine,
    columns = ['userID','foodID','rating'],
    coerce_float = False
)

# Making an m * n array, with m is the number of foods and n is the number of users
# The value is the rating that user gave to the food
dfFoodFeatures = dfRatings.pivot(
    index = 'foodID',
    columns = 'userID',
    values = 'rating'
).fillna(0) # The food that user didn't rate will be set an 0 value

# Converting the array to a matrix
matFoodFeatures = csr_matrix(dfFoodFeatures.values)

# K-Neighbours, using cosine as metric with brute-force search algorithm
modelKnn = NearestNeighbors(metric='cosine', algorithm='brute', n_neighbors=20, n_jobs=-1)

# Recommendation Method
def makeRecommendation(self, food, nRecommendations):