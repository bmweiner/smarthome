import requests
import json

# url = "https://gbfs.capitalbikeshare.com/gbfs/en/station_information.json"
url = "https://gbfs.capitalbikeshare.com/gbfs/en/station_status.json"


clauses =[
    {
        "station_id":"0824791a-1f3f-11e7-bf6b-3863bb334450",
        "name":"15th & P St NW",
        "alias":"Whole Foods",
    },
    {
        "station_id":"08247a21-1f3f-11e7-bf6b-3863bb334450",
        "name":"14th St & Rhode Island Ave NW",
        "alias":"Jinya",
    },
    {
        "station_id":"a7b98322-bdbb-421e-b2e4-1bb42ef9d01f",
        "name":"14th & Q St NW",
        "alias":"Etto",
    },
    {
        "station_id":"0824799f-1f3f-11e7-bf6b-3863bb334450",
        "name":"14th & R St NW",
        "alias":"Red Light",
    }
]

response = requests.get(url)
data = json.loads(response.content)

stations = data.get("data", {}).get("stations")
output = {}

for station in stations:
    for i, clause in enumerate(clauses):
        if station.get("station_id") == clause.get("station_id"):
            clause['bikes'] = station.get("num_bikes_available")
            output[i+1] = clause

print(json.dumps(output))
