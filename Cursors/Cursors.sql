1]Write a cursor to iterate through all records in the Customers table and print each customer firstname and last_name.
	Declare @first_name varchar(max),@last_name varchar(max);
	Declare CustomerCursor cursor for
	select first_name,last_name from Customers;
	open CustomerCursor
	Fetch next from CustomerCursor into @first_name,@last_name
	while(@@FETCH_STATUS=0)
	begin
	select @first_name,@last_name
	fetch next from CustomerCursor into @first_name,@last_name
	end
	close CustomerCursor

2] Write a cursor that loops through each customer in the Customers table. If their address contains "Street", update it to "St.".
	Declare @customer_id int;
	Declare @new_address varchar(max);
	Set @new_address='St';
	Declare addresscursor1 cursor for select customer_id from Customers where address like '%Street%';
	open addresscursor1
	fetch next from addresscursor1 into @customer_id
	while(@@FETCH_STATUS=0)
	begin
	update Customers set address=@new_address where customer_id=@customer_id
	fetch next from addresscursor1 into @customer_id
	end


