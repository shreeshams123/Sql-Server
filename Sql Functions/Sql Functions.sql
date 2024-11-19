1] Write a scalar function GetUserCollaborations that takes a user ID and returns the total number of notes they are collaborating on.
	create function GetUserCollaborationsValues(@UserId int) returns int as
	Begin
	return(
	select  count(Collaborators.UserId) from Collaborators where Collaborators.UserId=@UserId
)
	End
	select FunDoDb.dbo.GetUserCollaborations(1) as getCollaborators;
	
	
2] Write a scalar function IsArchived that takes a note ID and returns 1 if the note is archived, otherwise 0.
	create function IsNoteArchived(@NoteId int) returns int as 
	begin
	Declare @isArchiveTrue as int;
	Select @isArchiveTrue= 
	case when Notes.IsArchive=1 then 1
	else 0
	end
	from Notes where Notes.Id=@NoteId
	return @isArchiveTrue
	end
	select Notes.Id,FunDoDb.dbo.IsNoteArchived(Notes.Id) from Notes where Notes.Id=1

3] Write a scalar function GetLabelName that takes a label ID and returns the label name.
	create function GetLabelName(@Id int) returns varchar(max) as begin return (
	select Labels.Name from Labels where Labels.Id=@Id
	)
	end
	select FunDoDb.dbo.getlabelName(1) as labelname

4] Write an inline TVF GetNotesByUser that takes a user ID and returns all notes they own or collaborate on, along with their titles and descriptions.
	create function getNotesByUser(@Userid int) returns Table as return(
	select Notes.Title,Notes.Description from Notes left join  Collaborators on Notes.Id=Collaborators.NoteId where Notes.UserId=@Userid or Collaborators.UserId=@UserId
	)
	select * from FunDoDb.dbo.getNotesByUser(1)

5] Write an inline TVF GetCollaboratorsForNote that takes a note ID and returns all user names collaborating on that note.
	Alter function GetCollaboratorsForNote(@Noteid int) returns table as return(select Users.name from Users inner join Collaborators on Users.Id=Collaborators.UserId where Collaborators.NoteId=@Noteid);
	select * from GetCollaboratorsForNote(3)

