CREATE OR REPLACE PROCEDURE add_new_product (
    p_product_name  IN  Products.product_name%TYPE,
    p_description   IN  Products.description%TYPE,
    p_unit_price    IN  Products.unit_price%TYPE,
    p_reorder_level IN  Products.reorder_level%TYPE,
    p_supplier_id   IN  Products.supplier_id%TYPE
)
AS
    v_product_id    Products.product_id%TYPE;
BEGIN
    SELECT NVL(MAX(product_id), 200) + 1 INTO v_product_id FROM Products;
    INSERT INTO Products (
        product_id,
        product_name,
        description,
        unit_price,
        reorder_level,
        supplier_id
    )
    VALUES (
        v_product_id,
        p_product_name,
        p_description,
        p_unit_price,
        p_reorder_level,
        p_supplier_id
    );

    DBMS_OUTPUT.PUT_LINE('Successfully added new product: ' || p_product_name || ' with ID ' || v_product_id);
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding product: ' || SQLERRM);
        ROLLBACK;
END add_new_product;
/
