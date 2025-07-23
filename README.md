Oracle PL/SQL Inventory & Supply Chain Management System 📦
![WhatsApp Image 2025-07-23 at 08 19 51_722fed3c](https://github.com/user-attachments/assets/e2c220a4-28c2-4c8a-8e0d-a9eaa5efc230)

A comprehensive backend system that simulates the core logic of an inventory and supply chain management engine. This project is built entirely using Oracle SQL and PL/SQL, showcasing advanced database programming techniques including procedures, functions, triggers, and robust transaction handling.

Key Features ✨
Product Catalog Management: Add, update, and manage product information.

Multi-Warehouse Inventory Tracking: Keeps track of stock levels for each product in specific warehouses.

Sales Order Processing: Simulates a customer purchasing items from the inventory.

Purchase Order Simulation: Logic for restocking inventory from suppliers.

Automated Stock Updates: Triggers automatically decrease stock on a sale and can be configured to handle returns or shipments.

Data Integrity: Enforces business rules using constraints and exception handling (e.g., preventing stock from falling below zero).

Transaction Management: Ensures all operations are ACID-compliant using COMMIT and ROLLBACK for data consistency.

Technology Stack 🛠️

Database: Oracle Database (e.g., 21c Express Edition)
Language: PL/SQL, SQL
Client/IDE: Oracle SQL Developer or VS Code with Oracle Developer Tools

Database Schema (ER Diagram) 🗺️

The database is designed with a normalized structure to ensure data integrity and scalability. It includes tables for products, suppliers, warehouses, inventory levels, and transaction records.

A detailed breakdown of all tables, attributes, and keys can be found in the 1_create_schema.sql file.

Getting Started 🚀
Follow these steps to get the database schema and all its logic set up on your local Oracle instance.

Prerequisites

An active Oracle Database instance (like XE)
An Oracle client like SQL Developer or VS Code

Installation Steps
Clone the repository:

Bash

git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
Create the Project User:

Connect to your database as a user with admin privileges (like SYSTEM).

Run the script 0_admin_setup.sql to create the inventory_mgr user and grant the necessary permissions.

Connect as the Project User:

Disconnect from the admin user.

Create a new connection for the inventory_mgr user.

Run the SQL Scripts:

Execute the following .sql files in this specific order:

1_create_schema.sql - Builds all the tables and relationships.

2_insert_sample_data.sql - Populates the database with initial data.

3_procedures_and_functions.sql - Compiles the stored procedures.

4_triggers.sql - Compiles the triggers.

The database is now fully set up and ready for use.

Usage & Examples 👨‍💻
All business logic is executed through PL/SQL procedures. Here are a few examples.

Add a new product:
SQL

-- Connect as inventory_mgr and run:
SET SERVEROUTPUT ON;

BEGIN
  add_new_product(
    p_product_name  => 'Gaming Headset',
    p_description   => '7.1 Surround Sound RGB Headset',
    p_unit_price    => 89.99,
    p_reorder_level => 15,
    p_supplier_id   => 101
  );
END;
/
Simulate a customer sale:
This script will process a sale and automatically trigger an inventory update.

SQL

-- Connect as inventory_mgr and run:
SET SERVEROUTPUT ON;

-- Check stock BEFORE the sale
SELECT product_id, quantity_on_hand FROM Inventory WHERE product_id = 202;

DECLARE
  v_new_order_id  Sales_Orders.so_id%TYPE;
BEGIN
  -- Create the main sales order
  INSERT INTO Sales_Orders (customer_name) VALUES ('Ravi Kumar')
  RETURNING so_id INTO v_new_order_id;

  -- Add an item to the order (this fires the trigger)
  INSERT INTO Sales_Order_Items (so_id, product_id, quantity, sale_price)
  VALUES (v_new_order_id, 202, 5, 24.50);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Sale processed for order ID: ' || v_new_order_id);
END;
/

-- Check stock AFTER the sale to verify the trigger worked
SELECT product_id, quantity_on_hand FROM Inventory WHERE product_id = 202;
Skills Showcased 🧠
This project demonstrates a strong understanding of relational database design and advanced backend logic, including:

Advanced PL/SQL Development: Writing clean, modular, and maintainable code.

Complex Database Schema Design: Normalization, relationships, and data integrity.

Stored Procedures & Functions: Encapsulating business logic in reusable units.

Triggers for Automation: Creating triggers to enforce business rules and automate tasks.

Transaction Management: Ensuring data consistency with COMMIT, ROLLBACK, and ACID principles.

Robust Error Handling: Using EXCEPTION blocks to manage and report errors gracefully.

Author ✍️
M Surya Narayanan - www.linkedin.com/in/surya-narayanan005
