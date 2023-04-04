# Author: Abu Huraira
# Email: a.huraira@innopolis.university

from pymongo import MongoClient

client = MongoClient("mongodb://hostname:27017")
client = MongoClient("mongodb://localhost") # will connect to localhost and default port 27017
db = client['test']
collection = db['restaurants']

def delete_brooklyn_restaurant():
    collection.delete_one({"borough": "Brooklyn"})

def delete_thai_cuisine():
    collection.delete_many({"cuisine": "Thai"})

delete_brooklyn_restaurant()
delete_thai_cuisine()