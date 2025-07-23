-- A script to allow simple usernames in modern Oracle
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- Create your project user with a password
CREATE USER inventory_mgr IDENTIFIED BY "Surgaleo@619";

-- Give the user permissions to connect and build
GRANT CONNECT, RESOURCE TO inventory_mgr;