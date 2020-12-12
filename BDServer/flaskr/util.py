from datetime import datetime
def getUserRecCalories(weight, height, age, gender):
    """
    Parameter:
    weight  A integer value of user's weight
    height  A integer value of user's height
    age     A integer value of user's age
    gender  A string value contains user's genders
    """
    recCal = 0
    # The Harris-Benedict Equation
    if gender == 'Male':
        recCal = int(66.5 + 13.8 * weight + 5.0 * height - 6.8 * age) 
    if gender == 'Female':
        recCal = int(655.1 + 9.6 * weight + 1.9 * height - 4.7 * age)
    return recCal

def getUserAge(birthdate):
    """
    Parameter:
    birthdate   string value in format of yyyy-mm-dd
    """
    age = 0
    userBirthdate = datetime.strptime(birthdate,'%Y-%m-%d') # String to datetime obj
    currentDate = datetime.now()
    age = int((currentDate - userBirthdate).days / 3655) # Divided by 365.25 because of the leak years.
    return age 
