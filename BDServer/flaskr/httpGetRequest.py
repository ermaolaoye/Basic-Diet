import requests

# Send get request
myRequest = requests.get("http://127.0.0.1:5000/api/Food/list/不存在的食物")
print(myRequest.text)
