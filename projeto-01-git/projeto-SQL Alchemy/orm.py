import urllib

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from urllib import parse

params = urllib.parse.quote_plus(
    'Driver={ODBC Driver 17 for SQL Server};' +
    'Server=tcp:gabrielsene.database.windows.net,1433;' +
    'Database=sqlalchemy;' +
    'Uid=cloudadmin;' +
    'Pwd=GabrielPires96*;'
   )

conn_str = 'mssql+pyodbc:///?odbc_connect=' + params
engine = create_engine(conn_str)


Session = sessionmaker(bind=engine)

Base = declarative_base()
