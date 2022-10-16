import random
from datetime import datetime
import urllib.request
import json

# https://en.wikipedia.org/api/rest_v1/#/Feed/onThisDay
url = "https://en.wikipedia.org/api/rest_v1/feed/onthisday/selected/{month:02}/{day:02}"
dt = datetime.now()
url = url.format(month=dt.month, day=dt.day)

with urllib.request.urlopen(url) as response:
    data = json.loads(response.read())

i = random.randint(0,len(data["selected"]) - 1)
article = data['selected'][i]
s = "On this day in {}, {}".format(article['year'], article['text'])

print(s)
