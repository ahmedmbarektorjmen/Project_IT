from pydantic import BaseModel,EmailStr
from typing import Optional



# users :
class UserBase(BaseModel):
    username: str
    email: EmailStr
class UserCreate(UserBase):
    password: str
class User(UserBase):
    id: str
    profile_pic: str
    type: str
    created_at: str
class UserLogin(BaseModel):
    username:str
    password:str


# products :
class Product(BaseModel):
    id: int
    name: str
    description: str
    image: str
    categorie:str
    price: str
    stock: int
    stars_count:int
    stars_sum:float
    stars: float
    created_at: str