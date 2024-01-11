import requests
from googletrans import Translator
def fetch_users(size=20):
    '''
    document url: https://randomuser.me/documentation
    - Random User Generator allows you to fetch up to 5,000 generated users in one request using the results parameter.
    This function is to request to the api using a result parameter depends on the size variable
    Input: size (Default is 20)
    Output: users (there are users[first_name], users[last_name],and users[gender] column)
    '''
    users = []
    resp = requests.get(f"https://randomuser.me/api/?results={size}")
    data = resp.json()
    for user in data['results']:
        users.append({
            "first_name": user['name']['first'],
            "last_name": user['name']['last'],
            "gender (actual)": user['gender']
        })
    return users
def predict_gender(first_name):
    '''
    document url: https://genderize.io
    request the statistical probability of a name being male or female
    - The API is free to use for up to 100 requests/day
    This function is to request to the api using a single first name as the name parameter.
    The response includes a gender, probability, and a count.
    But it will return only gender and probability
    Input: first_name (String)
    Output: data['gender'], data['probability']
    '''
    resp = requests.get(f"https://api.genderize.io/?name={first_name}")
    data = resp.json()
    return data['gender'], data['probability']