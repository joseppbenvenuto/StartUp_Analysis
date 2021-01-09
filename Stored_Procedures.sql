
# Select columns and create new table sp
DROP PROCEDURE IF EXISTS spChooseCol;
DELIMITER $$
CREATE PROCEDURE spChooseCol(IN p_old_table VARCHAR(25), IN p_new_table VARCHAR(25), IN p_precision VARCHAR(25))
BEGIN

	SET @SQL1 = CONCAT('DROP TABLE IF EXISTS ', p_new_table, ';'); 
    
    PREPARE stmt1 FROM @SQL1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @p_precision = p_precision;

    SET @SQL2 = CONCAT('CREATE TABLE ', p_new_table, ' AS SELECT ', (SELECT GROUP_CONCAT(CONCAT("`", COLUMN_NAME, "`")) FROM
	INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = p_old_table AND FIND_IN_SET(ORDINAL_POSITION, @p_precision)), 
    ' FROM ', p_old_table, ';');
    
	PREPARE stmt2 FROM @SQL2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;

END
$$ DELIMITER ;

CALL spChooseCol('financials', 'financials1', '1,2,3');










