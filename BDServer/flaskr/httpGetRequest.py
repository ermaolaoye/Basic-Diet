import requests

# Send get request
r = requests.get("http://127.0.0.1:5000/api/Food/list/super-delecious-noodles")
print(r.text)
