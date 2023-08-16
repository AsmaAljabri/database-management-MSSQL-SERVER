--TRIGGER SYNTAX
CREATE OR ALTER TRIGGER customer_city_trigg ON Customer
FOR UPDATE --[INSERT , DELETE, OR UPDATE]
AS 
BEGIN
	DECLARE @OLD_CITY NVARCHAR(40);
	DECLARE @NEW_CITY NVARCHAR(40);

	SELECT @OLD_CITY = City FROM deleted;
	SELECT @NEW_CITY = City FROM inserted;

	IF @OLD_CITY  = @NEW_CITY 
	BEGIN
		PRINT 'the new city is same as the old one so cannot be updated ';
		ROLLBACK;
	END;

END;


select * from Customer;
update Customer set City = 'UK' where Id= 1 ;

