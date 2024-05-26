from database import Base, engine
from sqlalchemy import Column, Integer, DECIMAL, String, Date, Text, TIMESTAMP, func, ForeignKey
from sqlalchemy.orm import relationship


class User(Base):
    __tablename__ = "users"
    id = Column(String(255), primary_key=True)
    username = Column(String(50), nullable=False, unique=True)
    email = Column(String(100), nullable=False, unique=True)
    profile_pic = Column(String(255),nullable=False,unique=True)
    password_hash = Column(String(255), nullable=False)
    type = Column(String(5),server_default="user", nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp(), nullable=False)

    cart_items = relationship("CartItem", back_populates="user", cascade="all, delete-orphan")


class Product(Base):
    __tablename__ = "products"
    id = Column(String(255), primary_key=True)
    name = Column(String(255), nullable=False, unique=True)
    description = Column(Text, nullable=False)
    image = Column(String(255), nullable=False, unique=True)
    categorie = Column(String(255), nullable=False)
    price = Column(String(20), nullable=False)
    stock = Column(Integer, nullable=False)
    stars_count = Column(Integer,nullable=False)
    stars_sum = Column(DECIMAL(10,2),nullable=False)
    stars = Column(DECIMAL(2, 1),server_default="0.00", nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())

    cart_items = relationship("CartItem", back_populates="product", cascade="all, delete-orphan")



class CartItem(Base):
    __tablename__ = 'cart_items'
    id = Column(String(255), primary_key=True)
    user_id = Column(String(255), ForeignKey('users.id'), nullable=False)
    product_id = Column(String(255), ForeignKey('products.id'), nullable=False)
    quantity = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())

    user = relationship("User", back_populates="cart_items", cascade="all, delete-orphan")
    product = relationship("Product", back_populates="cart_items", cascade="all, delete-orphan")


Base.metadata.create_all(engine)
