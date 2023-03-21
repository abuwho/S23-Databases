CREATE FUNCTION retrieveCustomers(start INT, end INT)
RETURNS TABLE (customer_id INT, first_name VARCHAR(45), last_name VARCHAR(45), address_id INT)
AS $$
BEGIN
    IF start < 0 OR end > 600 THEN
        RAISE EXCEPTION 'Invalid start or end parameter';
    END IF;
    RETURN QUERY SELECT customer_id, first_name, last_name, address_id FROM customer
        ORDER BY address_id
        OFFSET start LIMIT (end-start+1);
END;
$$ LANGUAGE PLPGSQL;

-- Example to retrieve the customers starting from the 10th customer and ending with the 40th customer, ordered by their "address_id". 
SELECT * FROM retrieveCustomers(10, 40);