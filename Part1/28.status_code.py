#!/usr/bin/env python3
import requests
url = "https://www.fastcampus.co.kr"
try:
  response = requests.get(url)
  if response.status_code == 200:
     print("Success to retrieve index.html. Status Code: ",response.status_code)
  else:
     print("Failed to retrieve index.html. Status code: ",response.status_code)
except requests.exceptions.RequestException as e:
     print(f"Error: {e}")
