from sqlalchemy.orm import Session
from sqlalchemy import text
import models, schemas
import datetime
import bcrypt
from customs import tuple_to_dict, generate_id




async def get_user_by_username(db: Session, username: str):
    sql = text(f"SELECT * FROM users WHERE username = :username;")
    result = db.execute(sql,{"username":{username}}).fetchone()
    return await tuple_to_dict(result,"user") if result else None
async def get_user_by_email(db: Session, email: str):
    sql = text(f"SELECT * FROM users WHERE email = :email;")
    result = db.execute(sql,{"email":{email}}).fetchone()
    return await tuple_to_dict(result,"user") if result else None
async def get_user(db: Session, user_id: str):
    sql = text(f"SELECT * FROM users WHERE id = '{user_id}';")
    result = db.execute(sql).fetchone()
    return await tuple_to_dict(result,"user") if result else {"error":"error creating the user"}

async def create_user(db: Session, user: schemas.UserCreate):
    user_id = await generate_id(20)
    sql = text(f"""
        INSERT INTO users (id,username, email, password_hash)
        VALUES (:user_id, :username, :email, :password_hash);
    """)
    db.execute(sql,{
        "user_id": user_id,
        "username": user.username,
        "email": user.email,
        "password_hash": user.password
    })
    db.commit()
    return await get_user_by_username(db, user.username)
async def delete_user(user,db:Session) :
    sql = text(f"DELETE FROM users WHERE id = :id and username = :username")
    db.execute(sql,{"id":user["id"],"username":user["username"]})
    db.commit()
    return "deleted"

async def change_profile_pic(user,image_url:str,db:Session):
    sql = text("SELECT * FROM users WHERE id = :id and username = :username")
    result = db.execute(sql,{"id":user["id"],"username":user["username"]}).fetchone()
    db.commit()
    if result is None:
        return "not_found"

    sql = text(f"UPDATE users SET profile_pic = :image_url WHERE id = :id and username = :username;")
    db.execute(sql,{"id":user["id"],"username":user["username"],"image_url":f"/{image_url}"})
    db.commit()
    return "updated"


async def get_product(db: Session, product_id:str) :
    sql = text("SELECT * FROM products WHERE id = :id")
    result = db.execute(sql, {"id": product_id}).fetchone()
    return await tuple_to_dict(result,"product") if result else None

async def create_product(db: Session, product):
    # Generate an ID for the product
    product_id = await generate_id(14)
    sql = text(f"""
        INSERT INTO products (id, name, description, image, price, stock)
        VALUES ('{product_id}', '{product["name"]}', '{product["description"]}', '{product["image"]}', '{product["price"]}', '{product["stock"]}');
    """)
    db.execute(sql)
    db.commit()
    return await get_product(db, product_id)

async def get_all_products(db:Session):
    sql = text("SELECT * FROM products")
    result = db.execute(sql)
    if not result:
        return None
    arr = [await tuple_to_dict(col,"product") for col in result]
    return arr

async def search_product(db:Session,name:str):
    search_value = name.lower()
    sql = text("""
        SELECT (id, name, description, image, categorie, price, stock, stars_count, stars_sum, stars, created_at) FROM products
        WHERE LOWER(name) LIKE :search_input_value OR LOWER(description) LIKE :search_input_value;
    """)
    result = db.execute(sql, {"search_input_value": f"%{search_value}%"}).fetchall()
    if not result:
        return None
    arr = [await tuple_to_dict(col,"product") for col in result]
    return arr

async def get_product(db:Session,product_id:str,request,templates):
    sql = text(f"SELECT * FROM products where id = '{product_id}';")
    result = db.execute(sql).fetchone()
    return templates.TemplateResponse("product.html", {"request": request, "product": await tuple_to_dict(result,"product")}) if result else templates.TemplateResponse("product_error.html", {"request": request})