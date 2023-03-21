CREATE FUNCTION retrieveAddresses()
RETURNS TABLE (address_id INT, address TEXT, city_id INT)
AS $$
BEGIN
    RETURN QUERY SELECT address_id, address, city_id FROM address
        WHERE address LIKE '%11%' AND city_id BETWEEN 400 AND 600;
END;
$$ LANGUAGE PLPGSQL;
