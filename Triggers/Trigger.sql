Triggers are invoked when a certain event occurs.
-It can occur after a event or instead of an event.
-So we make use of after insert or instead of insert

1] Create a Trigger to Log Insertions:
   Write a trigger that logs every insert operation on the Orders table into a OrderLogs table. The log should include the order_id, customer_id, order_date, and order_status.
	create table OrderLogs(order_id int primary key,customer_id int,order_date date,order_status varchar(10));
	CREATE TRIGGER orderTrigger ON Orders AFTER INSERt AS
BEGIN
    INSERT INTO OrderLogs (order_id, customer_id, order_date, order_status)
    SELECT order_id, customer_id, CAST(order_date AS DATE), order_status
    FROM inserted;
END;

2] Write a trigger that automatically updates the created_at timestamp whenever a new Customer record is inserted or updated.
	Alter trigger updatecustomer on Customers after insert as
	begin
	Update Customers set created_at=GETDATE() where customer_id in(select customer_id from inserted)
	end
	insert into Customers(first_name,last_name,email,phone,address)values('dc','dsx','jmkkk','37483094','dcsdfc')
	EXEC sp_help 'Customers';
	select * from Customers
