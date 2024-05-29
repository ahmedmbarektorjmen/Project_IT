from sqlalchemy.orm import sessionmaker,Session
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base


USER = "root"
PASS = ""
HOST = "127.0.0.1"
DB_Name = "ShoppyTN"

engine = create_engine(f"mysql+pymysql://{USER}:{PASS}@{HOST}/{DB_Name}")
session = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
