import requests
import json

with open('./testUser.json', 'r') as f:
    data = json.load(f)
print(data)
r = requests.post("http://127.0.0.1:5000/api/User/addUser", json=data)

print(r.text)
