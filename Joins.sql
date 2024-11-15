1.Retrieve all records associated with a specific user.
select * from Notes inner join Users on Users.Id=Notes.UserId;