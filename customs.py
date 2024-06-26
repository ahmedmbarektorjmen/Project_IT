from fastapi import Security,HTTPException,status
from fastapi.security import OAuth2PasswordBearer
from passlib.context import CryptContext
from jose import jwt, ExpiredSignatureError, JWTError
from pydantic import BaseModel
import random
import string
from datetime import timedelta,datetime
from captcha.image import ImageCaptcha
import io
# user validation:
import re

async def generate_id(n):
    return str(random.randint(10**n, 10**(n+1)-1))

async def generate_file_name(filename:str):
    extension = filename.split(".")[-1]
    length = random.randint(20,50)
    ch = ""
    for i in range(length):
        ch = ch + random.choice(string.ascii_letters+string.digits)
    return f"{ch}.{extension}"


async def tuple_to_dict(atuple,type):
    if type == "user":
        keys = ['id', 'username', 'email', 'profile_pic','password_hash',"type","created_at"]
    elif type == "product":
        keys = ['id', 'name', 'description', 'image',"categorie","price","stock","stars_count","stars_sum","stars","created_at"]
    arr = dict(zip(keys, atuple))
    arr["created_at"] = str(arr["created_at"])
    return arr

# user validation:
def validate_username(username):
    username_regex = re.compile(r'^[a-zA-Z0-9_.-]{3,30}$')
    return username_regex.match(username) is not None

def validate_email(email):
    email_regex = re.compile(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
    return email_regex.match(email) is not None
# the user authentication :
class Token(BaseModel):
    access_token: str
    token_type: str
class TokenData(BaseModel):
    id: str | None = None
    username: str | None = None

class AuthHandler:
    def __init__ (self,AUTHSECRET):
        self.AUTHSECRET = AUTHSECRET
    oauth_scheme =  OAuth2PasswordBearer("/token")
    pwd_context = CryptContext(["bcrypt"],deprecated="auto")

    async def get_password_hash(self,password):
        return self.pwd_context.hash(password)
    async def verify_password(self,plain_password,hashed_password):
        return self.pwd_context.verify(plain_password,hashed_password)
    async def encode_token(self,user_id,username):
        payload = {
            "exp": datetime.now() + timedelta(90),
            "iat": datetime.now(),
            "sub1": user_id,
            "sub2": username
        }
        return jwt.encode(payload,self.AUTHSECRET,"HS256")
    async def decode_token(self,token):
        try :
            payload = jwt.decode(token,self.AUTHSECRET,"HS256")
            return {"id":payload.get("sub1"),"username":payload.get("sub2")}
        except ExpiredSignatureError:
            raise HTTPException(status.HTTP_401_UNAUTHORIZED,"Token has expired !!",{"WWW-Authenticate":"Bearer"})
        except JWTError:
            raise HTTPException(status.HTTP_401_UNAUTHORIZED,"Invalid Token !!",{"WWW-Authenticate":"Bearer"})
    # get current user with extracting the token from the authorization header in the request
    async def get_current_user(self,token:str= Security(oauth_scheme)):
        return self.decode_token(token)


def generate_captcha_text(length=8):
    return ''.join(random.choices(string.ascii_uppercase+string.digits, k=length))

def create_captcha_image(text):
    image = ImageCaptcha(width=300, height=100, fonts=None, font_sizes=(42,))
    data = image.generate(text)
    return io.BytesIO(data.read())
