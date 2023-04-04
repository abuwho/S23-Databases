# Author: Abu Huraira
# Email: a.huraira@innopolis.university


from pymongo import MongoClient

client = MongoClient("mongodb://hostname:27017")
client = MongoClient("mongodb://localhost") # will connect to localhost and default port 27017
db = client['test']
collection = db['restaurants']

def insert_restaurant():
    new_restaurant = {
        "address": {
            "building": "126",
            "coord": [-73.9557413, 40.7720266],
            "street": "Sportivnaya",
            "zipcode": "420500"
        },
        "borough": "Innopolis",
        "cuisine": "Serbian",
        "grades": [
            {
                "date": {"$date": 1681267200000},
                "grade": "A",
                "score": 11
            }
        ],
        "name": "The Best Restaurant",
        "restaurant_id": "41712354"
    }
    db.restaurants.insert_one(new_restaurant)


def find_restaurant_by_address(address):
    query = {"address.street": address}
    return collection.find(query)

