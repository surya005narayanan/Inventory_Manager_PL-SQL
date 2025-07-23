-- ========= Basic Entities =========

CREATE TABLE Suppliers (
    supplier_id   NUMBER(10)      PRIMARY KEY,
    supplier_name VARCHAR2(255)   NOT NULL,
    contact_person VARCHAR2(255),
    email         VARCHAR2(255)   UNIQUE,
    phone         VARCHAR2(20)
);

CREATE TABLE Products (
    product_id    NUMBER(10)      PRIMARY KEY,
    product_name  VARCHAR2(255)   NOT NULL,
    description   VARCHAR2(1000),
    unit_price    NUMBER(10, 2)   NOT NULL CHECK (unit_price > 0),
    reorder_level NUMBER(10)      DEFAULT 10,
    supplier_id   NUMBER(10),
    CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Warehouses (
    warehouse_id   NUMBER(10)      PRIMARY KEY,
    warehouse_name VARCHAR2(255)   NOT NULL,
    location      VARCHAR2(500)
);

-- ========= Linking Table for Stock =========

CREATE TABLE Inventory (
    inventory_id      NUMBER(10)      PRIMARY KEY,
    product_id        NUMBER(10)      NOT NULL,
    warehouse_id      NUMBER(10)      NOT NULL,
    quantity_on_hand  NUMBER(10)      NOT NULL CHECK (quantity_on_hand >= 0),
    CONSTRAINT fk_inv_product FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT fk_inv_warehouse FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    CONSTRAINT uq_product_warehouse UNIQUE (product_id, warehouse_id)
);

-- ========= Transactional Tables (Purchases) =========

CREATE TABLE Purchase_Orders (
    po_id         NUMBER(10)      PRIMARY KEY,
    supplier_id   NUMBER(10)      NOT NULL,
    order_date    DATE            DEFAULT SYSDATE,
    status        VARCHAR2(50)    DEFAULT 'Pending',
    CONSTRAINT fk_po_supplier FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Purchase_Order_Items (
    po_item_id    NUMBER(10)      PRIMARY KEY,
    po_id         NUMBER(10)      NOT NULL,
    product_id    NUMBER(10)      NOT NULL,
    quantity      NUMBER(10)      NOT NULL CHECK (quantity > 0),
    unit_cost     NUMBER(10, 2)   NOT NULL,
    CONSTRAINT fk_poi_po FOREIGN KEY (po_id) REFERENCES Purchase_Orders(po_id),
    CONSTRAINT fk_poi_product FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ========= Transactional Tables (Sales) =========

CREATE TABLE Sales_Orders (
    so_id         NUMBER(10)      PRIMARY KEY,
    customer_name VARCHAR2(255)   NOT NULL,
    order_date    DATE            DEFAULT SYSDATE,
    status        VARCHAR2(50)    DEFAULT 'Processing'
);

CREATE TABLE Sales_Order_Items (
    so_item_id    NUMBER(10)      PRIMARY KEY,
    so_id         NUMBER(10)      NOT NULL,
    product_id    NUMBER(10)      NOT NULL,
    quantity      NUMBER(10)      NOT NULL CHECK (quantity > 0),
    sale_price    NUMBER(10, 2)   NOT NULL,
    CONSTRAINT fk_soi_so FOREIGN KEY (so_id) REFERENCES Sales_Orders(so_id),
    CONSTRAINT fk_soi_product FOREIGN KEY (product_id) REFERENCES Products(product_id)
);