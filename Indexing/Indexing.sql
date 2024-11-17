
Clustered Index :
It determines the order of records in the table. 
A table can have only one clustered index.
If there are no clustered index then the primary key column will be clustered index by default.

Non Clustered Index:
The index will be stored in seperate table with row address for every record.
A table can have multiple non clustered index.

Unique is used with the indexes to specify that the values in the index should be unique.


1] Write a query to create an index on the Email column of the Users table to speed up queries that search for users by email.
	create nonclustered index EmailIndex on Users(Email);
2] Write a query to create a unique index on the Username column of the Users table to prevent duplicate usernames.
	create unique nonclustered index UserNameIndex on Users(Name)