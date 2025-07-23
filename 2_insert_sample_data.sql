-- Insert a couple of suppliers
INSERT INTO Suppliers (supplier_id, supplier_name, email) VALUES (101, 'Global Electronics', 'contact@globalelectronics.com');
INSERT INTO Suppliers (supplier_id, supplier_name, email) VALUES (102, 'Office Supply Co.', 'sales@officesupplyco.com');

-- Insert some products from those suppliers
INSERT INTO Products (product_id, product_name, unit_price, reorder_level, supplier_id) VALUES (201, '24-inch 4K Monitor', 299.99, 10, 101);
INSERT INTO Products (product_id, product_name, unit_price, reorder_level, supplier_id) VALUES (202, 'Wireless Mouse', 24.50, 25, 101);
INSERT INTO Products (product_id, product_name, unit_price, reorder_level, supplier_id) VALUES (203, 'A4 Printer Paper (500 Sheets)', 5.99, 50, 102);

-- Insert a warehouse location
INSERT INTO Warehouses (warehouse_id, warehouse_name, location) VALUES (501, 'Main Distribution Center', 'Chennai, TN');

-- Set the initial stock levels for our products in the warehouse
-- Note: We need a unique ID for each inventory entry. We can use a sequence for this later, but for now we'll just use numbers.
INSERT INTO Inventory (inventory_id, product_id, warehouse_id, quantity_on_hand) VALUES (1, 201, 501, 30);
INSERT INTO Inventory (inventory_id, product_id, warehouse_id, quantity_on_hand) VALUES (2, 202, 501, 150);
INSERT INTO Inventory (inventory_id, product_id, warehouse_id, quantity_on_hand) VALUES (3, 203, 501, 200);

-- Commit the changes to the database
COMMIT;