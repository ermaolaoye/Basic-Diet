import requests
import json

# Reading the json file
with open('./testFood.json', 'r') as f:
    data = json.load(f)
print(data)

# Sending the HTTP Post Request
r = requests.post("http://127.0.0.1:5000/api/Food/add", json=data)

print(r.text)
