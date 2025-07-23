CREATE OR REPLACE TRIGGER trg_update_inventory_on_sale
AFTER INSERT ON Sales_Order_Items -- This is the event: after an item is inserted into a sale
FOR EACH ROW -- This makes the trigger run for every single item sold
DECLARE
    v_current_stock NUMBER;
BEGIN
    -- Step 1: Check the current stock for the product that was just sold.
    SELECT quantity_on_hand INTO v_current_stock
    FROM Inventory
    WHERE product_id = :new.product_id; -- ':new' refers to the row that was just inserted

    -- Step 2: Check if there is enough stock to fulfill the order.
    IF v_current_stock < :new.quantity THEN
        -- If not enough stock, raise an error to cancel the transaction.
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for product ID ' || :new.product_id || '. Sale cancelled.');
    ELSE
        -- Step 3: If there is enough stock, update the inventory level.
        UPDATE Inventory
        SET quantity_on_hand = quantity_on_hand - :new.quantity -- Subtract the sold quantity
        WHERE product_id = :new.product_id;

        -- Optional: Log a message that the trigger fired successfully.
        DBMS_OUTPUT.PUT_LINE('Trigger Fired: Stock for product ' || :new.product_id || ' updated.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- This error happens if the product doesn't exist in the inventory table at all.
        RAISE_APPLICATION_ERROR(-20002, 'Product ID ' || :new.product_id || ' not found in inventory.');
END;
/