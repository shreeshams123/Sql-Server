1] Write a stored procedure that allows a user to create a new note by providing the title, content
	Alter procedure CreateNote(@title varchar(max),@description varchar(max),@userId int) as
	Begin
	insert into Notes(UserId,title,Description) values(@userId,@title,@description);
	End
	exec CreateNote @title="Ado.net",@description="xyz",@userid=1

2] Write a stored procedure that updates the title and content of an existing note based on the note ID.
	Create proc UpdateNote(@title varchar(max),@desc varchar(max),@id int) as
	begin
	update Notes set Title=@title,Description=@desc where Notes.Id=@id
	end
	exec UpdateNote @title='new note',@desc='ahs sggs',@id=1

3] Add a collaborator to a note
	Alter proc AddCollaborator(@NoteId int,@UserId int) as
	begin
	insert into Collaborators values(@UserId,@NoteId)
	end
	exec AddCollaborator 2,9

4] Get the most popular notes (with the highest number of collaborators)
	create proc GetPopularNote as
	begin
	select Notes.Title from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId group by Notes.Title having count(Collaborators.UserId)=(select max(collabcount) from (select count(Collaborators.UserId) as collabcount from Collaborators group by Collaborators.NoteId)as subquery)
	end
	exec GetPopularNote

5] Get all notes with their collaborators and labels
	Alter proc GetAllNotes as 
	begin
	select Notes.Title,Users.Name,Labels.Name from Notes left join Collaborators on Notes.Id=Collaborators.NoteId left join Users on Users.Id=Collaborators.UserId left join NoteLabels on Notes.Id=NoteLabels.NoteId left join Labels on Labels.Id=NoteLabels.LabelId
	end
	exec GetAllNotes