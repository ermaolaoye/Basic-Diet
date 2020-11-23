# Design

The design of the whole app has being split to two part:

- The Client Side
- The Server Side

The server side is responsible for storing the database in a web server, providing external api to access and update the data stored in the database to the client side.

The client side provides graphical user interface to the user depending on the data received from the server side. Also enable user to interact and update new data to the server.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Basic_Diet.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Basic_Diet.png)

# Client Side

## The MVVM(Model, View, ViewModel) Design

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled.png)

The MVVM is the design pattern that I chose to follow, because it is the official design pattern recommended for SwiftUI developer by Apple.

- **Model** holds the application data. Also is responsible for communicating with the server side.
- **View** is the structure, layout, and appearance of what a user sees on the screen. It communicate with the methods in the ViewModel to present information.
- **ViewModel** is a communication layer between the Model and the View. It takes in the data stored in the Model, encapsulates them, and then expose its method to the View.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%201.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%201.png)

### Hierarchy Graph

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%202.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%202.png)

### Model

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%203.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%203.png)

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%204.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%204.png)

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%205.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%205.png)

Models stores detailed information. All of the model have a method called update(), which uses HTTP requests to perform the function of getting or setting data from the server side.

The password stored in the user model and in the server's database are hashed values with 256-bits digest and SHA-2 algorithm using apple's CryptoKit.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%206.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%206.png)

In the server, when the app is trying to validate user's password, it only validate its corresponding hashed value.

Models are responsible for decoding the json file received from the server, and fetched the data to corresponding model. The view will automatically get updated when model changes.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%207.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%207.png)

The model is also responsible for syncing the data with Apple's HealthKit.

**Link to the success criteria:**

- A synchronised data connection between Apple's Health app.

### User Account System

Every time the app start, it automatically starts to detect whether user login information is correct or not. If the user login information is updated in the server, the app might ask user to re-login in the client side.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%208.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%208.png)

More details about the login system are discussed in the server side.

## View

### Client UI Interface Design

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%209.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%209.png)

UI Design for the whole app

### Main View

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2010.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2010.png)

The main view contains a circle chart that shows how many calories the user can still consume. The add record button will leads to a pop up menu, which user can select which type of record to add.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2011.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2011.png)

Pop up menu

There's also a barcode scanner at the top right of the page.

**Link to the success criteria:**

- User can add record of their food, and the record will effect all the nutrition data in the main menu.
- A barcode scanner that can lead users directly to the detailed view of the food they had scanned.

Users can swipe up from the main menu to enter the **profile view**

### Health Detailed View

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2012.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2012.png)

This view have a graph that visualized user's health data like calories and other nutritions. 

User can select to view their information by YEAR, MONTH, WEEK or DAY from the top of the screen.

This UI have flexible window design, users can customize what windows they would like to see, and the order of the windows.

- **Nutrition Window** tells user their daily consumption information, with message and recommending article to inform user what the data means. User can click this window to check more details in a new pop up menu.
- **Exercise Window** tells user their daily exercise record, with graphs to visualize the data for better understanding.
- **Consumption Window** tells user what food they had consume, with message and recommending article to suggest user whether the food is good or bad for their health.
- **Information Window** tells user's personal information with visualized graphs, like the change of their weight.
- **Ranking Window** provides a ranking chart that have all user's friends consumption and exercise data.

**Link to the success criteria:**

- Main menu provides basic visualized information about user's health data,
- User can click the basic health data in the main menu to check more detailed information in the sub menu.
- A history menu which provides user's diet history in a calendar view.
- A ranking view of users and their friends

Users can tap the search bar from the top of the main view, or pressing add meal record button in the pop up add record menu to enter the search view.

### Search View

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2013.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2013.png)

Users will first see the search view that contains recommending and trending foods.

Recommending foods are the foods selected by the algorithm based on user's consumption preference and user's health data.

Trending foods are the popular foods in user's city or country.

After inputting the name of the food in the search bar, users will see a search content view with selection of foods that have the similar name. User can also tap the sorting by option, to choose the order of displaying the data.

**Link to the success criteria:**

- A search menu that user can choose the food they had eat.
- A pop-up window that will recommend user with selection of healthy meals that they might like depends on what they had taken in before.

User can tap the food, and then they can enter the info view.

### Info View

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2014.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2014.png)

At the top of all the window, is the name of the food with a image of the food at the left. Also there's a colored circle below the name, tells whether the food is recommended or not.

- Red(Not Recommending): The food might contains too much carbonhydrate or fats that user might not need.
- Yellow(Normal Food): The food does not contains too much carbonhydrate or fats, but it also not containing too much nutrition.
- Green(Relatively Healthy): The food contains relatively high nutrition ingredients.

The info view also uses the flexible window design.

- **Calories Window** tells user the total calories the food contains, with a graph below that tells whether is the calories high in that type of food.
- **Nutrition Window** tells user the nutrition the food contains, with red, yellow, green to inform user whether is the number of nutrition have positive or negative effect to their body.
    - This method is also used by the UK government.
- **Recipe Window** tells user the recipe for cooking that food.

User can click the add to record button at the bottom of the page to add this food to their record.

**Link to the success criteria:**

- A detailed view of the food where user can enter through the search menu that shows detailed information about the food's nutrition.

If user press the plus button at the right bottom of the search view, user can add their own food to the record.

### Add food view

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2015.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2015.png)

This is basically the same as the food description menu, however, user can enter the data of their food by themselves.

User can also create this food information by inputing all the raw material that is required to make this food. And an nutrition calculator will calculate an estimated nutrition data for this food.

**Link to the success criteria:**

- A nutrition calculator which user can input raw materials of the meal and get estimated nutrition information of the meal.

If user swipe down in the main view, the volume estimater will pop up.

### Volume Estimater

Volume estimater is a utility tool that enable user to use their phone's camera to estimate the volume of the container.(This function is limited to the iPhones/iPads which have the LiDAR sensor)

**Link to the success criteria:**

- A volume estimater that uses the phone's camera to estimate the volume of container.

# Server Side

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2016.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2016.png)

The server will held data in the database and expose APIs to the client. The client side can use APIs to get json file and then will analysis the json file to update the models.

## Database

I decided to use SQLite as my database in my server, because it is free and fulfill all my need. Each table has been designed based on the model in the client side.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Database_Design-7.jpg](Design%20ca1b99aa58fb473ab136d065f52fec11/Database_Design-7.jpg)

SQL Code for creating this database:

```sql
CREATE TABLE "Users" (
	"userID"	INTEGER NOT NULL,
	"userName" TEXT NOT NULL,
	"userEmail"	TEXT NOT NULL,
	"userWeight"	REAL NOT NULL,
	"userHeight"	REAL NOT NULL,
	"userCalories" REAL,
	"userPassword"	TEXT NOT NULL,
	"imageID"	INTEGER,
	"userAuthority"	TEXT NOT NULL DEFAULT 'citizen',
	"JWT" TEXT,
	FOREIGN KEY("imageID") REFERENCES "Images"("imageID"),
	PRIMARY KEY("userID" AUTOINCREMENT)
);
CREATE TABLE "Foods" (
	"foodID"	INTEGER NOT NULL,
	"foodName"	TEXT NOT NULL,
	"barcode"	INTEGER,
	"ingredients"	TEXT,
	"calories"	REAL NOT NULL,
	"carbonhydrate"	REAL,
	"fat"	REAL,
	"protein"	REAL,
	"sodium"	REAL,
	"saturatedFat"	REAL,
	"transFat"	REAL,
	"cholesterol"	REAL,
	"sugar"	REAL,
	"dietaryFiber"	REAL,
	"vitaminA"	REAL,
	"carotene"	REAL,
	"vitaminD"	REAL,
	"vitaminE"	REAL,
	"vitaminK"	REAL,
	"vitaminB1"	REAL,
	"vitaminB2"	REAL,
	"vitaminB6"	REAL,
	"vitaminB12"	REAL,
	"vitaminC"	REAL,
	"niacin"	REAL,
	"folicAcid"	REAL,
	"phosphorus"	REAL,
	"potassium"	REAL,
	"magnesium"	REAL,
	"calcium"	REAL,
	"iron"	REAL,
	"zinc"	REAL,
	"iodine"	REAL,
	"selenium"	REAL,
	"cooper"	REAL,
	"fluorine"	REAL,
	"manganese"	REAL,
	"imageID"	INTEGER,
	FOREIGN KEY("imageID") REFERENCES "Images"("imageID"),
	PRIMARY KEY("foodID" AUTOINCREMENT)
);
CREATE TABLE "Records" (
	"recordID"	INTEGER NOT NULL,
	"userID"	INTEGER NOT NULL,
	"foodID"	INTEGER NOT NULL,
	"date"	TEXT NOT NULL,
	"quantity"	REAL NOT NULL,
	"unit"	TEXT NOT NULL,
	FOREIGN KEY("userID") REFERENCES "Users"("userID"),
	FOREIGN KEY("foodID") REFERENCES "Foods"("foodID"),
	PRIMARY KEY("recordID" AUTOINCREMENT)
);
CREATE TABLE "Images" (
	"imageID"	INTEGER NOT NULL,
	"image"	BLOB NOT NULL,
	PRIMARY KEY("imageID" AUTOINCREMENT)
);
CREATE TABLE "Ratings" (
	"userID"	INTEGER NOT NULL,
	"foodID"	INTEGER NOT NULL,
	"rating"	INTEGER NOT NULL,
	FOREIGN KEY("userID") REFERENCES "Users"("userID"),
	FOREIGN KEY("foodID") REFERENCES "Foods"("foodID")
);
CREATE TABLE "Requests" (
	"requestID"	INTEGER NOT NULL,
	"userID"	INTEGER NOT NULL,
	"content"	TEXT NOT NULL,
	"sqlCode"	TEXT,
	FOREIGN KEY("userID") REFERENCES "Users"("userID"),
	PRIMARY KEY("requestID" AUTOINCREMENT)
);
```

User's Recommended health take-in data will be assigned automatically by the system based on their gender and age by following the recommended amount of nutrition taken-in by citizens proposal provided by the Chinese government.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2017.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2017.png)

There daily maximum calories consumption will be calculated based on the REE-formula provided by Harris-Benedict.

REE is the Resting Energy Expenditure

**The Harris-Benedict Equation:**

- Female: 655.1+9.6W+1.9S-4.7A
- Male: 66.5+13.8W+5.0S-6.8A
- W is weight, S is height, A is age

Some variable's value are limited to follow some specific rules, in other words regular expressions.

- **Regular Expressions:**
    - userName:(/^[\u4E00-\u9FA5A-Za-z\s]+(·[\u4E00-\u9FA5A-Za-z]+)*$/;)
    - userEmail:(^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$)

I will use python code to limit the input from these regular expression by using the built-in package re.

Pseudocode for validating input:

```python
IMPORT re
FUNCTION validateInput(regExp, inputValue):
		validateValue = re.findall(regExp, inputValue)
		IF validateValue == inputValue:
				RETURN TRUE
		ELSE:
				RETURN FALSE
```

## Recommendation Algorithm

I decided to use a item-based collaborative filtering algorithm to make an recommender system.

Collaborative filtering builds a model from users' past behaviors of an items and the similar decision made by other users like what items they had already consumed, and their numerical ratings to those items. This model is then used to predict items that user may have interest in.

The recommending system has being split to three steps:

- Collect Data
- Find similar items
- Provide recommendation

**Collect Data**:

- The data we need to collect are the users' behaviours, mainly the ratings of them towards each food.
- The ratings raw value are between 0 and 5.

**Find similar items:**

- The similarity between items are calculated based on k-nearest neighbors algorithm, which is an non-parametric lazy learning method proposed by Thomas Cover.
- KNN uses a database that data points are separated into several clusters, and can calculate the "distance" between one food and every other food in the database, it then rank the distances and return the top K nearest neighbor foods as the most similar food recommendations.

**Provide Recommendation**

- Based on the nearest neighbors, the app then use users' current health data, for example the number of vitamin that user needs to take in or the maximum number of calories consumption within one day, to provide a recommendation.

As the algorithm can only be achieved when it get gain enough user data, the recommending algorithm is planned to be implemented after the first development and testing stage.

**Initial thought for the algorithm**

Firstly the program read foods table and ratings table from the database, and create dataframe for each data.

```python
import pandas
from sqlalchemy import create_engine

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
```

Then create an m * n array, with m is the number of foods and n is the number of users.

The value in each column is the rating that user gave to the food.

```python
# Making an m * n 2D array, with m is the number of foods and n is the number of users
# The value is the rating that user gave to the food
dfFoodFeatures = dfRatings.pivot(
    index = 'foodID',
    columns = 'userID',
    values = 'rating'
).fillna(0) # The food that user didn't rate will be set an 0 value
```

Then convert the array to a matrix.

```python
from scipy.sparse import csr_matrix
# Converting the array to a matrix
matFoodFeatures = csr_matrix(dfFoodFeatures.values)
```

Using the sklearn library to create an KNN model.

```python
from sklearn.neighbors import NearestNeighbors
# K-Neighbours, using cosine as metric with brute-force search algorithm
modelKnn = NearestNeighbors(metric='cosine', algorithm='brute', n_neighbors=20, n_jobs=-1)
```

The algorithm will then output a list of food that is recommended based on its knn model.

## User Account System

The app's user account system are built by using JWT(Json Web Token).

The first time that user register their account, the server will generate a JWT with a secret and send back to the user's devices. The client side's app will permanently store the JWT data on the local storage.

![Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2018.png](Design%20ca1b99aa58fb473ab136d065f52fec11/Untitled%2018.png)

Everytime when the client try to communicate with the server side in the future, the JWT will be sent to check which user're sending the request.

The JWT is made up of three parts, the Header, the Payload and the Signature.

**Header**

The header of this JWT contains two message: the type of the token, which is JWT, and the signing algorithm being used, here is HMAC SHA256

```json
{
	"typ": "JWT",
	"alg": "HS256"
}
```

This will then be encoded with base64 algorithm which will get:

```python
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
```

**Payload**

The payload contains the claims which is the statements about an entity and additional data.

The program will store two data in the payload, one is userID another one is iat(issued at), which is the time that this JWT is signed and provided. The iat will be stored as Unix timestamp. Everytime the user update their password, a new JWT will be sent to their client, which means a new iat will be included.

```json
{
	"userID": 1,
	"iat": 1601485261
}
```

This will then be encoded with base64 algorithm which will get:

```python
eyJ1c2VySUQiOjEsImlhdCI6MTYwMTQ4NTI2MX0
```

**Signature**

The signature will take the encoded header and the encoded payload with a secret that only stored in the server side, then put them into the algiorithm specified in the header to create a encrypted signature.

 Pseudocode for generating the signature:

```python
encodedString = BASE64(header) + '.' + BASE64(payload)
secret = '1234567890'
signature = HMACSHA256(encodedString, secret = secret)
```

By putting all the contents together, the program will get the final JWT that can be sent to user.

- eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOjEsImlhdCI6MTYwMTQ4NTI2MX0.-7xQJhMzYIat5rGpZO6Ioc33ZPwy5QggT8MZPaoMPeE

Everytime when user update their personal profile in the server, a new jwt with a new issued time will be generated to user. When the local JWT does not match with the JWT stored in the database, the user will be required to re-login. For instance, when user change their password in another devices, other device would require to re-login.

More details about JWT user verification are discussed in the API design part below.

## API Design

The Web Service API is designed based on the REpresentational State Transfer architecture style.

The client side can communicate with the database stored in the server through these APIs.

[API](https://www.notion.so/9c9952360d30410d8bbf81a434b7bdaf)

I choose to use Flask as my web framework.

get type API pseudocode:

```python
@app.route('api/______/<_____id>', methods=['GET'])
FUNCTION get____(______id):
		data = cursor.execute('''SELECT _____ _____ ____ FROM TABLE _____ WHERE ___id = %i''' % (___id))
		cursor.commit()
		cursor.close()
		RETURN jsonify(data)
```

If the user inputs a string instead of a certain id, the sql statement will use LIKE instead of equal.

```sql
SELECT ___ FROM TABLE ____ WHERE ____ LIKE ____
```

For the API that involves changing the table value constraint by the regular expression, for example the userName, the code will use the validateInput method stated above to check whether the input is valid.

Users are being given authority level:

- Citizen: Normal users who does not have the authority to manipulate database.
- Manager: users who are given the authority to manipulate the database through API, but all of their action needs to be verified by me.
- Mayor: Top authority level users which are able to manipulate the database through API freely.

get user authority level pseudocode:

```python
FUNCTION getAuthorityLevel(userID):
		authorityLevel = cursor.execute('''SELECT userAuthority FROM Users WHERE userID = %i''', (userID))
		cursor.commit()
		cursor.close()
		RETURN authorityLevel
```

Every request will contain user's JWT for verification. 

The verification method pseudocode:

```python
secret = "1234567890"
FUNCTION jwtVerification(JWT):
		localJWT = JWT
		GLOBAL secret
		decodeJSON = localJWT.HMACSHA256DECODE(localJWT, secret)
		userID = decodedJSON.userID
		serverJWT = cursor.execute('''SELECT JWT FROM Users WHERE userID = %i''', (userID))
		IF serverJWT == localJWT:
				RETURN TRUE
		ELSE:
				RETURN FALSE
```

add type API pseudocode:

```python
@app.route('api/______/______', methods=['POST'])
@login_required
FUNCTION add____():
		IF NOT request.json OR NOT '_____' IN request.json:
				abort(400) # 400 Bad Request
		_____ = {
					'____': _____,
					......
		}
		sqlCode = '''INSERT INTO ______ (____,____,____) VALUES(%__, %___, %___)''' % (___.___, ___.____)
		# JWT Verification
		IF jwtVerification(JWT = JWT) == FALSE:
				abort(401) # 401 Unauthorized
		IF validateInput(____, ____) == FALSE: #Validate User Input
				abort(400)
		# Validate User authority Level
		IF getAuthorityLevel(userID) == 'mayor':
				cursor.execute(sqlCode)
				cursor.commit()
				cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'manager':
				cursor.execute('''INSERT INTO REQUESTS(userID, content, status, sqlCode) VALUES(%i, %s, %s, %s)''' % (____.userID, 'Add ____', 'NULL', sqlCode))
				cursor.commit()
				cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'citizen':
				abort(403) # 403 Forbidden
```

delete type API pseudocode:

```python
@app.route('api/______/______', methods=['POST'])
@login_required
FUNCTION delete____():
		IF NOT request.json OR NOT '_____' IN request.json:
				abort(400) # 400 Bad Request
		_____ = {
					'____': _____,
					......
		}
		# JWT Verification
		IF jwtVerification(JWT = JWT) == FALSE:
				abort(401) # 401 Unauthorized
		sqlCode = '''DELETE FROM ____ WHERE %___ = %___''', (___,___)
		# Validate User authority Level
		IF getAuthorityLevel(userID) == 'mayor':
			cursor.execute(sqlCode)
			cursor.commit()
			cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'manager':
			cursor.execute('''INSERT INTO REQUESTS(userID, content, status, sqlCode) VALUES(%i, %s, %s, %s)''' % (____.userID, 'Delete ____', 'NULL', sqlCode))
			cursor.commit()
			cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'citizen':
			abort(403) # 403 Forbidden
```

update type api pseudocode:

```python
@app.route('api/______/______', methods=['POST'])
@login_required
FUNCTION update____():
		IF NOT request.json OR NOT '_____' IN request.json:
				abort(400) # 400 Bad Request
		_____ = {
					'____': _____,
					......
		}
		# JWT Verification
		IF jwtVerification(JWT = JWT) == FALSE:
				abort(401) # 401 Unauthorized
		IF validateInput(____, ____) == FALSE: #Validate User Input
				abort(400)
		sqlCode = '''UPDATE _____ set %___ = %___''', (___,___)
		IF getAuthorityLevel(userID) == 'mayor':
			cursor.execute(sqlCode)
			cursor.commit()
			cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'manager':
			cursor.execute('''INSERT INTO REQUESTS(userID, content, status, sqlCode) VALUES(%i, %s, %s, %s)''' % (____.userID, 'Update ____', 'NULL', sqlCode))
			cursor.commit()
			cursor.close()
		ELSE IF getAuthorityLevel(userID) == 'citizen':
			abort(403) # 403 Forbidden
```

# Utilities

## Nutrition Calculator

## Volume Estimater

# Test Plan

I will use iterative development to complete this application. This means that I will break down the whole app into smaller solvable problems that are already been explained in the design part, and then I will solve them through an iterative process This will enable me to make sure that the application will successfully work when it all comes together at the end.

Firstly, I will finish the server side development, and test each of the APIs to check whether their outputs, the json files and the changes in database, are matching with my expectation.

[GET type APIs Test](https://www.notion.so/2dc958a9e2cd425fb556d8f4dace73a4)

- Test 01 uses normal data
- Test 02 uses erroneous data

[GET List of Foods API test](https://www.notion.so/e364ead23ec34ebe922aa881ef538f5f)