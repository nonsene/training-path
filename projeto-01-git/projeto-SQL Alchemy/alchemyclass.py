from sqlalchemy import Column, String, Integer, Date

from orm import Base

class User(Base):

    __tablename__ = 'Users'

    id = Column(Integer, primary_key=True)
    username = Column(String)
    repositoryname = Column(String)
    date = Column(Date)

    def __init__(self, username, repositoryname, date):
        self.username = username
        self.date = date
        self.repositoryname = repositoryname
