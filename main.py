# fastapi :
from fastapi import FastAPI, Depends, status
from fastapi.params import Form, File, Security,Cookie,Body
from fastapi.datastructures import UploadFile
from fastapi.requests import Request
from fastapi.exceptions import HTTPException
from fastapi.responses import HTMLResponse,RedirectResponse,StreamingResponse
# security :
from fastapi.middleware.cors import CORSMiddleware
# authentication :
from fastapi.security import OAuth2PasswordRequestForm
from customs import AuthHandler
from customs import Token,TokenData
# rendering adn static files:
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
# file management :
import shutil
from customs import generate_file_name
# session:
from itsdangerous import URLSafeTimedSerializer
#captcha:
from customs import generate_captcha_text,create_captcha_image
# db:
from sqlalchemy.orm import Session
import models, schemas, crud
from database import session, engine
# debugging :
from icecream import ic
# supplements:
from typing import List
from pydantic import EmailStr

captcha_text = ""
AUTHSECRET = "480ZD6D4k06IJ4h56zeD8f4e8fzef8rg45g45rg45erqgGF4E5f45seEG54ze89"

models.Base.metadata.create_all(bind=engine)

def get_db():
    db = session()
    try:
        yield db
    finally:
        db.close()



app = FastAPI()
# session middleware
serializer = URLSafeTimedSerializer("SECRET_KEY")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



auth_handler = AuthHandler(AUTHSECRET)

# Mount "files/" directory with staticfiles
app.mount('/files/', StaticFiles(directory="files/"), name='static')

# shoose the directory for jinja2 templating
templates = Jinja2Templates(directory='templates/')



# authentication :
@app.post("/token",response_model=Token,status_code=status.HTTP_200_OK)
async def login_for_access_token(db:Session=Depends(get_db),formdata:OAuth2PasswordRequestForm = Depends()):
    user = await authenticate_user(formdata.username,formdata.password,db)
    if user is None:
        raise HTTPException(status.HTTP_400_BAD_REQUEST,"Incorect username and/or password")
    access_token = await auth_handler.encode_token(user["id"],user["username"])
    return {"access_token":access_token,"token_type":"bearer"}

async def authenticate_user(username:str,password:str, db:Session = Depends(get_db)):
    if ("@" in username) and ("." in username):
        # Provided input is an email,trying to find user by email :
        user = await crud.get_user_by_email(db,username)
    else :
        # Provided input is a username, trying to find user by username :
        user = await crud.get_user_by_username(db,username)
    password_verified = await auth_handler.verify_password(password,user["password_hash"])
    if (user is None) or (not password_verified):
        raise HTTPException(status.HTTP_401_UNAUTHORIZED,"Invalid username and/or password")
    access_token = await auth_handler.encode_token(user["id"],user["username"])
    user.pop("password_hash")
    user["access_token"] = access_token
    user["token_type"] = "bearer"
    return user



# Route to create a user
@app.post("/api/register", response_model=schemas.User,status_code=status.HTTP_200_OK)
async def signup(captcha_token: str = Body(...),username:str=Body(...), password:str=Body(...),email:EmailStr=Body(...), captcha: str = Body(...), db: Session = Depends(get_db)):
    try:
        captcha_text = serializer.loads(captcha_token, max_age=300)
        ic(captcha_text)
    except:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Invalid or expired CAPTCHA token !!")
    if captcha != captcha_text:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Invalid CAPTCHA !!")
    auth_details = schemas.UserCreate(username=username,email=email,password=password)
    user = await crud.get_user_by_username(db, username)
    if user is not None:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, detail="Username already registered !!")
    password_hash = await auth_handler.get_password_hash(password)
    auth_details.password = password_hash
    user_created = await crud.create_user(db, auth_details)
    await authenticate_user(username,password,db)
    access_token = await auth_handler.encode_token(user_created["id"],username)
    return {"access_token":access_token,"token_type":"bearer"}
# Route to login :
@app.post("/api/login",status_code=status.HTTP_200_OK)
async def login(captcha_token: str = Body(...),username:str=Body(...), password:str=Body(...), captcha: str = Body(...),db: Session = Depends(get_db)):
    try:
        captcha_text = serializer.loads(captcha_token, max_age=300)
        ic(captcha_text)
    except:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Invalid or expired CAPTCHA token !!")
    if captcha != captcha_text:
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Invalid CAPTCHA !!")
    return await authenticate_user(username,password,db)

@app.delete("/api/delete_user",status_code=status.HTTP_200_OK)
async def delete_user (db: Session = Depends(get_db),access_token:str= Security(auth_handler.oauth_scheme)):
    user = await auth_handler.decode_token(access_token)
    msg = await crud.delete_user(user,db)
    if msg != "deleted":
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="User not deleted !!")
    return {"detail":"User deleted successfully !!"}




# profile pic: 
@app.post("/api/change_profile_pic",status_code=status.HTTP_200_OK)
async def change_profile_pic(request: Request,profile_pic: UploadFile = File(...),db: Session = Depends(get_db),access_token:str= Security(auth_handler.oauth_scheme)):
    if (profile_pic.filename.split(".")[-1].lower() not in ["png","jpg","jpeg"]) or (profile_pic.content_type not in ["image/png","image/jpg","image/jpeg"]):
        raise HTTPException(status.HTTP_415_UNSUPPORTED_MEDIA_TYPE, detail="File type not supported only png,jpg and jpeg")
    image_url = f"files/profile_images/{await generate_file_name(profile_pic.filename)}"
    user = await auth_handler.decode_token(access_token)
    msg = await crud.change_profile_pic(user,image_url,db)
    if msg == "not_found":
        raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="Profile pic not changed")
    with open(image_url, "wb") as buffer:
        shutil.copyfileobj(profile_pic.file, buffer)
    return {"msg":"Profile pic changed successfully"}



@app.get("/captcha")
async def get_captcha():
    captcha_text = generate_captcha_text()
    captcha_token = serializer.dumps(captcha_text)
    ic(captcha_text)
    buf = create_captcha_image(captcha_text)
    return StreamingResponse(buf, media_type="image/png", headers={"X-Captcha-Token": captcha_token})




# Route to get a user by ID
@app.get("/api/get_user/id/{user_id}", response_model=schemas.User,status_code=status.HTTP_200_OK)
async def get_user(user_id: str, db: Session = Depends(get_db),formdata: OAuth2PasswordRequestForm = Depends(auth_handler.oauth_scheme)):
    db_user = await crud.get_user(db, user_id)
    if db_user is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="User not found !")
    return db_user
# Route to get a user by username
@app.get("/api/get_user/{username}", response_model=schemas.User,status_code=status.HTTP_200_OK)
async def get_user(user_name: str, db: Session = Depends(get_db),formdata: OAuth2PasswordRequestForm = Depends(auth_handler.oauth_scheme)):
    db_user = await crud.get_user_by_username(db, user_name)
    if db_user is None:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail="User not found !")
    return db_user



# Route to create a product
@app.post("/api/product", response_model=schemas.Product)
async def create_product(name: str = Form(...), description: str = Form(...), categorie: str = Form(...), price: float = Form(...), stock: int = Form(...), image: UploadFile = File(...), db: Session = Depends(get_db),formdata: OAuth2PasswordRequestForm = Depends(auth_handler.oauth_scheme)):
    image_url = f"files/search_images/{await generate_file_name(image.filename)}"
    product = {
        "name": str(name),
        "description": description,
        "image": "/"+image_url,
        "price": price,
        "stock": stock,
        "categorie":categorie
    }
    with open(image_url, "wb") as buffer:
        shutil.copyfileobj(image.file, buffer)
    await crud.create_product(db, product)
    return {"msg":"Product created successfully"}
# Route to get all product
@app.get("/api/products", response_model=List[schemas.Product])
async def get_all_products(db: Session = Depends(get_db)):
    return await crud.get_all_products(db)
# Route to get a product by id
@app.get("/api/product/{id}", response_class=HTMLResponse)
async def get_product(id: str ,request: Request,db: Session = Depends(get_db)):
    return await crud.get_product(db,id,request,templates)



# routing :

# Protected Route :
@app.get("/dashboard", response_class=HTMLResponse)
async def home(request: Request,db: Session = Depends(get_db),access_token:str = Cookie(None)):
    if access_token is None:
        return templates.TemplateResponse("dashboard_login.html", {"request": request}, status_code=status.HTTP_401_UNAUTHORIZED)
    decoded_token = await auth_handler.decode_token(access_token)
    user = await crud.get_user(db, decoded_token["id"])
    if user["type"] == "user":
        return templates.TemplateResponse("dashboard_admin.html", {"request": request}, status_code=status.HTTP_401_UNAUTHORIZED)
    return templates.TemplateResponse("dashboard.html", {"request": request})
@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})
@app.get("/{url:path}", response_class=HTMLResponse)
async def home(request: Request, url: str):
    # if the url ends with .html, the url will be redirected
    if url.endswith("index") :
        return RedirectResponse("/")
    if url.endswith(".html"):
        url = url[:-5]
        return RedirectResponse(f"/{url}")
    try :
        return templates.TemplateResponse(f"{url}.html", {"request": request})
    except:
        return templates.TemplateResponse("404.html", {"request": request}, status_code=status.HTTP_404_NOT_FOUND)
# running the web app:
if __name__ == '__main__':
    import uvicorn
    uvicorn.run('main:app', host='0.0.0.0', port=80, reload=True)