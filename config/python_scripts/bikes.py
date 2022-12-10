import requests
import json

url = "https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Transportation_WebMercator/MapServer/5/query"

docks = {
    '15th & P St NW':{
        'rank': 1,
        'alias': 'Whole Foods',
    },
    '14th & Rhode Island Ave NW':{
        'rank': 2,
        'alias': 'Jinya',
    },
    '14th & Q St NW':{
        'rank': 3,
        'alias': 'Etto',
    },
    '14th & R St NW':{
        'rank': 4,
        'alias': 'Red Light',
    },
}

where = ' '.join(["NAME='{}' OR".format(s) for s in docks.keys()])[:-3]

params = {
    "where":where,
    "returnGeometry":"false",
    "outFields":"NAME,NUM_BIKES_AVAILABLE",
    "f":"json",
}

response = requests.get(url, params)
data = json.loads(response.content)['features']

# print alias / bikes
for row in data:
    key = row['attributes']['NAME']
    docks[key]['bikes'] = int(row['attributes']['NUM_BIKES_AVAILABLE'])

data = {v['rank'] : v for k,v in docks.items()}
print(json.dumps(data))
