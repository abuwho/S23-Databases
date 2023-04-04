# Author: Abu Huraira
# Email: a.huraira@innopolis.university

from pymongo import MongoClient

client = MongoClient("mongodb://hostname:27017")
client = MongoClient("mongodb://localhost") # will connect to localhost and default port 27017
db = client['test']
collection = db['restaurants']


# Get number of objects returned by a query
def get_count(res):
    count = 0
    for _ in res:
        count += 1
    return count

# Query all Irish cuisines
def get_irish_cuisines():
    query = {"cuisine": "Irish"}
    return collection.find(query)

# Query all Irish and Russian cuisines
def get_irish_russian_cuisines():
    query = {"$or": [{"cuisine": "Irish"}, {"cuisine": "Russian"}]}
    return collection.find(query)

# Find a restaurant with the following address: Prospect Park West 284, 11215
def find_restaurant_by_address(address, building, zipcode):
    query = {"address.street": address, "address.zipcode": zipcode, "address.building": building}
    return collection.find(query)


res = get_irish_cuisines()
print("Irish cuisines:", res)
print("Number of Irish cuisines:", get_count(res))

res = get_irish_russian_cuisines()
print("Irish or Russian cuisines:", res)
print("Number of Irish or Russian cuisines:", get_count(res))

res = find_restaurant_by_address('Prospect Park West', '284', '11215')
print("Find restaurant at Prospect Park West 284, 11215", res)
print("Number of restaurants at Prospect Park West 284, 11215", get_count(res))
