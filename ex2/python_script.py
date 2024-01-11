'''
this script is to generate the .csv file and print the output in terminal. 
'''
import pandas as pd
from utils import fetch_users, predict_gender
import argparse
# Create the parser
parser = argparse.ArgumentParser(description='This script is to create dataframe.csv of 20 people with gender prediction and the results.')
# Add arguments with default values
parser.add_argument('--size', type=int, default=20, help='An size argument with a default value of 20')
# Parse the arguments
args = parser.parse_args()
# request https://randomuser.me/api/?results=20
users = fetch_users(args.size)
# loop user in users
for user in users:
    # request https://api.genderize.io/?name=user['first_name']
    predicted_gender, probability = predict_gender(user['first_name'])
    # assign to the user by predicted_gender at user['gender (predict)'] column
    user['gender (predict)'] = predicted_gender
    # assign to the user by probability at user['probability'] column
    user['probability'] = probability
    # assign the comparation between user['gender (actual)'] and predicted_gender to user['same_gender'] column
    user['same_gender'] = 'true' if user['gender (actual)'] == predicted_gender else 'false'
# convert to DataFrame and print
df = pd.DataFrame(users)
# save the dataframe
df.to_csv('dataframe.csv', index=False)
print(df[['first_name', 'last_name', 'gender (actual)', 'gender (predict)', 'probability', 'same_gender']])
