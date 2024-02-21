CREATE DATABASE University
USE University

CREATE TABLE Groups
(
Id INT PRIMARY KEY IDENTITY,
GrName NVARCHAR (10),
IsDeleted BIT DEFAULT 0
)

CREATE TABLE Students
(
Id INT PRIMARY KEY IDENTITY,
FullName NVARCHAR(50),
GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)

CREATE TABLE DeleteStudents
(
 Id INT PRIMARY KEY,
 FullName NVARCHAR(50),
 GroupId INT
)



INSERT INTO Groups(GrName,IsDeleted)
VALUES
('PB302',0),
('P136',0),
('D245',0),
('PF123',0),
('D344',0)

INSERT INTO Students(FullName,GroupId)
VALUES
('Fidan Heydarova',1),
('Jeikhun Jalilov',2),
('Lamiya Guliyeva',3),
('Nazrin Mammadova',4),
('Zulya Nabiyeva',5)


CREATE TRIGGER TR_DeleteStudent ON dbo.Students
AFTER DELETE
AS
INSERT INTO DeleteStudents(Id,FullName,GroupId)
SELECT D.Id,D.FullName,D.GroupId FROM deleted AS D 
JOIN GROUPS AS G ON G.Id=D.GroupId

SELECT * FROM Students
DELETE FROM Students WHERE GroupId=2
SELECT * FROM DeleteStudents


CREATE TRIGGER TR_DeleteGroups ON dbo.Groups
INSTEAD OF DELETE
AS
UPDATE dbo.Groups SET IsDeleted = 1 FROM deleted AS D
INNER JOIN Groups AS G ON G.Id = D.Id

SELECT * FROM Groups
DELETE FROM Groups WHERE ID=5
