1] Create a View to List All Customers with Their Total Order Value:
	create view CustomerView as select Customers.first_name,Customers.last_name,sum(Orders.total_amount)as total_amount from Customers left join Orders on Customers.customer_id=Orders.customer_id group by Customers.first_name,Customers.last_name
	select * from CustomerView

2] Create a view that shows order_id, order_date, total_amount, and the full_name (concatenation of first_name and last_name) from the Customers table for each order.
	create view OrderView as select Orders.order_id,Orders.total_amount,concat(Customers.first_name,' ',Customers.last_name) as CustomerName from Orders inner join Customers on Customers.customer_id=Orders.customer_id
	select * from OrderView

3] Write a view that shows each customer’s customer_id, first_name, last_name, and the total total_amount of all orders they have placed (summed across all their orders).
   Create an index on the view to optimize query performance when you need to frequently retrieve this aggregated data.
   Alter view dbo.IndexView with schemabinding as select Customers.customer_id,Customers.first_name,Customers.last_name,sum(Orders.total_amount) as total_amount,COUNT_BIG(*) AS order_count from dbo.Customers inner join dbo.Orders on Customers.customer_id=Orders.customer_id group by Customers.first_name,Customers.last_name,Customers.customer_id
   create unique clustered index Newindex on dbo.IndexView(customer_id)
   select * from IndexView

