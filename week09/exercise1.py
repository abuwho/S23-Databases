import psycopg2
from geopy.geocoders import Nominatim

conn = psycopg2.connect(database="dvdrental", user="postgres", password="whitmore", host="localhost", port="5432")

cur = conn.cursor()
cur.execute("SELECT * FROM retrieveAddresses()")

geolocator = Nominatim(user_agent="geoapiExercises")

for row in cur:
    location = geolocator.geocode(row[1])
    if location is None:
        latitude = 0
        longitude = 0
    else:
        latitude = location.latitude
        longitude = location.longitude
    cur.execute("UPDATE address SET latitude = %s, longitude = %s WHERE address_id = %s", (latitude, longitude, row[0]))
    conn.commit()

cur.close()
conn.close()
