1] Retrieve all records associated with a specific user.
   select * from Notes inner join Users on Users.Id=Notes.UserId;
2] Find all labels associated with a specific note.
	select Labels.Name,Notes.Title from Labels inner join NoteLabels on Labels.Id=NoteLabels.LabelId inner join Notes on NoteLabels.NoteId=Notes.Id
3] List all users who are collaborating on a specific note.
	select Users.Name from Users inner join Collaborators on Users.Id=Collaborators.UserId where NoteId=8
4] Find the user who owns a specific note.
	select Users.Name from Users inner join Notes on Users.Id=Notes.UserId where Notes.Id=8
5] List all notes that have no collaborators
	select * from Notes left join Collaborators on Notes.Id=Collaborators.NoteId where Collaborators.NoteId is null
6] Count the number of notes each user has created
	select count(Notes.Id),UserId from Notes inner join Users on Notes.UserId=Users.Id group by UserId
7] Find all notes shared between two specific users.
	select distinct Notes.Id from Notes inner join Collaborators c1 on Notes.Id=c1.NoteId inner join Collaborators c2 on Notes.Id=c2.NoteId where c1.UserId=1003 and c2.UserId=1006
8] Count the total collaborators for each note.
	select count(Collaborators.NoteId),NoteId from Collaborators group by NoteId
9] Retrieve all notes that are archived along with their labels.
	select Notes.Title,Labels.name from Notes inner join NoteLabels on Notes.Id=NoteLabels.NoteId inner join Labels on NoteLabels.LabelId=Labels.Id where IsArchive=1
10] Find all collaborators for each note, including their user details.
	select Users.*,Notes.Id from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId inner join Users on Collaborators.UserId=Users.Id
11] Find all labels and the notes they are associated with.
	select Labels.Name ,Notes.Id from Labels inner join NoteLabels on Labels.Id=NoteLabels.LabelId inner join Notes on NoteLabels.NoteId=Notes.Id
12] Retrieve all users who are collaborators on notes owned by a specific user.
	select Collaborators.UserId from Collaborators inner join Notes on Collaborators.NoteId=Notes.Id where Notes.UserId=2 
13] List all notes that have at least one label assigned to them.
	select Notes.* from Notes inner join NoteLabels on Notes.Id=NoteLabels.NoteId
14] Find notes that are shared (have collaborators) and their corresponding owners.
	select distinct Notes.*,Users.Name from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId inner join Users on Users.Id=Notes.UserId
15] Retrieve all notes along with their labels and collaborators.
	select Notes.*,Users.Name,Labels.Name from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId inner join Users on Collaborators.UserId=Users.Id inner join NoteLabels on Notes.Id=NoteLabels.NoteId inner join Labels on Labels.Id=NoteLabels.LabelId
16] Count the total number of notes each label is associated with.
	select count(NoteLabels.LabelId),Labels.Name from NoteLabels inner join Labels on NoteLabels.LabelId=Labels.Id group by Labels.Name
17] Retrieve all labels that are associated with notes flagged as archived.
	select Labels.Name from Labels inner join NoteLabels on Labels.Id=NoteLabels.LabelId inner join Notes on Notes.Id=NoteLabels.NoteId where Notes.IsArchive=1
18] List all users and the notes they are collaborating on.
	select Users.*,Notes.Title from Users left join Collaborators on Collaborators.UserId=Users.Id left join Notes on Collaborators.NoteId=Notes.Id
19] Retrieve all labels that are not associated with any notes.
	select Labels.Name from Labels left join NoteLabels on Labels.Id=NoteLabels.LabelId where NoteLabels.NoteId is null
20] List all notes along with the names of their collaborators, if any.
	select Notes.*,Users.Name from Notes left join Collaborators on Collaborators.NoteId=Notes.Id inner join Users on Users.Id=Collaborators.UserId
21] Retrieve all notes and their associated labels for a specific collaborator.
	select Notes.*,Labels.Name from Collaborators inner join Notes on Collaborators.NoteId=Notes.Id inner join NoteLabels on Notes.Id=NoteLabels.NoteId inner join Labels on Labels.Id=NoteLabels.LabelId where Collaborators.UserId=1003
22] Find the notes that are only shared with one collaborator.
	select Collaborators.NoteId from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId group by Collaborators.NoteId having count(Collaborators.UserId)=1
23] Retrieve all users who are not collaborating on any notes.
	select Users.* from Users left join Collaborators on Users.Id=Collaborators.UserId where Collaborators.UserId is null
24] Find all pairs of collaborators who are working on the same notes.
	select distinct c1.UserId , c2.UserId from Collaborators c1 inner join Collaborators c2 on c1.NoteId=c2.NoteId where c1.UserId<c2.UserId
25] List all notes where a specific user (e.g., UserId = 1003) is collaborating, along with their ownername
	select Notes.*,Users.Name from Users inner join Notes on Users.Id=Notes.UserId inner join Collaborators on Notes.Id=Collaborators.NoteId where Collaborators.UserId=2
26] Find the users who are collaborating with the most notes.
	select Collaborators.UserId from Users inner join Collaborators on Users.Id=Collaborators.UserId group by Collaborators.UserId having count(Collaborators.UserId)=(Select max(collabcount) from(select count(Collaborators.UserId) as collabcount from Collaborators group by Collaborators.UserId)as subquery)
27] List all labels that are associated with more than 5 notes.
	select Labels.Name from NoteLabels inner join Labels on NoteLabels.LabelId=Labels.Id group by Labels.Name having count(NoteLabels.NoteId)>5
28] Retrieve all notes that do not have any labels.
	Select Notes.* from Notes left join NoteLabels on Notes.Id=NoteLabels.NoteId where NoteLabels.LabelId is null
29] Find the labels that are associated with the same set of notes as a given label 
	select Labels.Name from Labels inner join NoteLabels on Labels.Id=NoteLabels.LabelId where NoteLabels.NoteId=3
30] List all notes shared by exactly two collaborators.
	select Notes.Id,Notes.Title from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId group by Notes.Id,Notes.Title having count(Collaborators.UserId)=2
31] Find users who collaborate only on notes owned by a specific user.
	select Users.* from Users inner join Collaborators on Users.Id=Collaborators.UserId inner join Notes on Notes.Id=Collaborators.NoteId where Notes.UserId=2 and  not exists (select 1 from Notes where Notes.Id!=2)
32] List all users who own notes and are also collaborators on other users notes.
	select Users.* from Users inner join Notes on Notes.UserId=Users.Id inner join Collaborators on Collaborators.UserId=Users.Id
33] Find all labels that are shared between two specific notes.
	select Labels.Name from Labels inner join NoteLabels on Labels.Id=NoteLabels.LabelId where NoteLabels.NoteId=2 or NoteLabels.NoteId=3
34] Retrieve the total number of collaborators for each note that has at least one collaborator.
	Select count(Collaborators.UserId), Notes.Title from Collaborators inner join Notes on Collaborators.NoteId=Notes.Id group by Notes.Title having count(Collaborators.UserId)>=1
35] Find the notes that have more collaborators than their owners total number of notes.
	select Notes.Title from Notes inner join Collaborators on Notes.Id=Collaborators.NoteId group by Notes.Title having count(Collaborators.userId)>(select count(Notes.Id) from Notes group by Notes.UserId)