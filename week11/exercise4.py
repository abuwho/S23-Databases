# Author: Abu Huraira
# Email: a.huraira@innopolis.university

from pymongo import MongoClient

client = MongoClient("mongodb://hostname:27017")
client = MongoClient("mongodb://localhost") # will connect to localhost and default port 27017
db = client['test']
collection = db['restaurants']


def add_or_delete_grades_on_ppw():
    cursor = collection.find({'address.street': 'Prospect Park West'})
    for restaurant in cursor:
        a_grades = [grade for grade in restaurant['grades'] if grade['grade'] == 'A']
        if len(a_grades) > 1:
            collection.delete_one({'_id': restaurant['_id']})
        else:
            new_grade = {'date': {'$date': 1651219200000}, 'grade': 'A', 'score': 12}
            collection.update_one({'_id': restaurant['_id']}, {'$push': {'grades': new_grade}})

