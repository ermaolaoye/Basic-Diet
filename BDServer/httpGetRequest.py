import requests

# Send get request
r = requests.get("http://127.0.0.1:5000/api/Food/description/10000000000")

print(r.text)
