CREATE USER shop;
ALTER USER shop SET PASSWORD 12345678
CREATE DATABASE shop_development;
GRANT ALL PRIVILEGES ON DATABASE shop TO shop;