SET SERVEROUTPUT ON;

SELECT product_id, quantity_on_hand FROM Inventory WHERE product_id = 202;

DECLARE
  v_new_order_id  Sales_Orders.so_id%TYPE;
BEGIN

  INSERT INTO Sales_Orders (customer_name, status)
  VALUES ('Anitha', 'Processing')
  RETURNING so_id INTO v_new_order_id;
  INSERT INTO Sales_Order_Items (so_id, product_id, quantity, sale_price)
  VALUES (v_new_order_id, 202, 5, 24.50);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Successfully processed sale for order ID: ' || v_new_order_id);
END;
/
SELECT product_id, quantity_on_hand FROM Inventory WHERE product_id = 202;
