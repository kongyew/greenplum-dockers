from sqlalchemy.engine.url import URL
from sqlalchemy import create_engine
from sqlalchemy import inspect

postgres_db = {'drivername': 'postgres',
               'username': 'gpadmin',
               'password': 'pivotal',
               'host': 'gpdbsne',
               'port': 5432}
print URL(**postgres_db)

# postgresql+psycopg2://user:password@host:port/dbname[?key=value&key=value...]
#postgresql+psycopg2://

engine = create_engine(URL(**postgres_db))

inspector = inspect(engine)

# Get table information
print inspector.get_table_names()

# Get column information
# print inspector.get_columns('EX1')
