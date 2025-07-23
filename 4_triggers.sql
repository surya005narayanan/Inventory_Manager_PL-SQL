CREATE OR REPLACE TRIGGER trg_update_inventory_on_sale
AFTER INSERT ON Sales_Order_Items 
FOR EACH ROW 
DECLARE
    v_current_stock NUMBER;
BEGIN
    
    SELECT quantity_on_hand INTO v_current_stock
    FROM Inventory
    WHERE product_id = :new.product_id; 

    IF v_current_stock < :new.quantity THEN
        
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ID ' || :new.product_id || '. Sale cancelled.');
    ELSE
        
        UPDATE Inventory
        SET quantity_on_hand = quantity_on_hand - :new.quantity 
        WHERE product_id = :new.product_id;
        DBMS_OUTPUT.PUT_LINE('Trigger Fired: Stock for product ' || :new.product_id || ' updated.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product ID ' || :new.product_id || ' not found in inventory.');
END;
/
