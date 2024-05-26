from sqlalchemy import text
from database import session,Session
import json



# Function to generate random values and add to each dictionary
def send_to_db(db: Session, data):
    for item in data:
        sql = text("""
INSERT INTO products(id, name, description, categorie, image, price, stock, stars_count, stars_sum, stars)
VALUES (:id, :name, :description, :categorie, :image, :price, :stock, :stars_count, :stars_sum, :stars)
""")
        db.execute(sql, item)
        db.commit()



db = session()

# Load JSON data
with open('products.json', 'r') as file:
    data = json.load(file)

send_to_db(db,data)

