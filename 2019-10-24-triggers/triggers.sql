DROP DATABASE IF EXISTS school;
CREATE DATABASE school CHARSET 'utf8';
USE school;

create table Teachers(
  Id int auto_increment primary key,
  Name varchar(100)
);

CREATE TABLE Students(
	Id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(150) NOT NULL,
	Num INTEGER NOT NULL,
	ClassNum INTEGER NOT NULL,
	ClassLetter CHAR(1) NOT NULL,
	Birthday DATE,
	EGN CHAR(10),
	EntranceExamResult NUMERIC(3,2)
);

CREATE TABLE Subjects(
	Id INTEGER NOT NULL AUTO_INCREMENT,
	Name VARCHAR(100),

	PRIMARY KEY(Id)
);

CREATE TABLE StudentMarks(
	StudentId INTEGER NOT NULL,
	SubjectId INTEGER NOT NULL,
	ExamDate DATETIME NOT NULL,
	Mark NUMERIC(3,2) NOT NULL,

	PRIMARY KEY( StudentId, SubjectId, ExamDate ),
	FOREIGN KEY (StudentId) REFERENCES Students(Id),
	FOREIGN KEY (SubjectId) REFERENCES Subjects(Id)
);

CREATE TABLE MarkWords(
	RangeStart NUMERIC(3,2) NOT NULL,
	RangeEnd NUMERIC(3,2) NOT NULL,
	MarkAsWord VARCHAR(15),

	PRIMARY KEY(RangeStart, RangeEnd)
);

INSERT INTO Students(Id, Name, Num, ClassNum, ClassLetter, Birthday, EGN) VALUES( 101, 'Зюмбюл Петров', 10, 11, 'а', '1999-02-28', NULL );
INSERT INTO Students(Name, Num, ClassNum, ClassLetter, Birthday, EGN) VALUES( 'Исидор Иванов', 15, 10, 'б', '2000-02-29', '0042294120' );
INSERT INTO Students(Name, Num, ClassNum, ClassLetter, Birthday, EGN) VALUES( 'Панчо Лалов', 20, 10, 'б', '2000-05-01', NULL );
INSERT INTO Students(Name, Num, ClassNum, ClassLetter, Birthday, EGN) VALUES( 'Петраки Ганьов', 20, 10, 'а', '1999-12-25', '9912256301' );
INSERT INTO Students(Name, Num, ClassNum, ClassLetter, Birthday, EGN) VALUES( 'Александър Момчев', 1, 8, 'а', '2002-06-11', NULL );

INSERT INTO Subjects(Id, Name) VALUES( 11, 'Английски език' );
INSERT INTO Subjects(Name) VALUES( 'Литература' );
INSERT INTO Subjects(Name) VALUES( 'Математика' );
INSERT INTO Subjects(Name) VALUES( 'СУБД' );

INSERT INTO StudentMarks VALUES( 101, 11, '2017-03-03', 6 );
INSERT INTO StudentMarks VALUES( 101, 11, '2017-03-31', 5.50 );
INSERT INTO StudentMarks VALUES( 102, 11, '2017-04-28', 5 );
INSERT INTO StudentMarks VALUES( 103, 12, '2017-04-28', 4 );
INSERT INTO StudentMarks VALUES( 104, 13, '2017-03-03', 5 );
INSERT INTO StudentMarks VALUES( 104, 13, '2017-04-07', 6 );
INSERT INTO StudentMarks VALUES( 104, 11, '2017-04-07', 4.50 );

INSERT INTO MarkWords VALUES( 2, 2.50, 'Слаб' );
INSERT INTO MarkWords VALUES( 2.50, 3.50, 'Среден' );
INSERT INTO MarkWords VALUES( 3.50, 4.50, 'Добър' );
INSERT INTO MarkWords VALUES( 4.50, 5.50, 'Мн. добър' );
INSERT INTO MarkWords VALUES( 5.50, 6, 'Отличен' );

insert into Teachers values
    (null, 'Валентин Иванов'),
    (null, 'Александър Чернаев'),
    (null, 'Лидия Иванова'),
    (null, 'Стела Стефанова'),
    (null, 'Валентин Хинков');

select st.Name, sb.Name,
       sm.ExamDate, sm.Mark,
    case
        when sm.Mark between 2 and 2.49
            then concat('Слаб(', cast(sm.Mark as signed), ')')
        when sm.Mark between 2.5 and 3.49
            then concat('Среден(', cast(sm.Mark as signed), ')')
        when sm.Mark between 3.5 and 4.49
            then concat('Добър(', cast(sm.Mark as signed), ')')
        when sm.Mark between 4.5 and 5.49
            then concat('Много добър(', cast(sm.Mark as signed), ')')
        when sm.Mark between 5.5 and 6
            then concat('Среден(', cast(sm.Mark as signed), ')')
    end
    from StudentMarks sm
    inner join Students st on sm.StudentId = st.Id
    inner join Subjects sb on sm.SubjectId = sb.Id;

select st.Name,
    concat(st.ClassNum, st.ClassLetter)
    as Position
    from Students st
    where ClassNum in(10, 12)
union all
select t.Name, concat('учител')
    from Teachers t
    order by 1;

(select st.Name,
       avg(sm.Mark) as Avg
    from Students st
    inner join StudentMarks sm on st.Id = sm.StudentId
    inner join Subjects sb on sm.SubjectId = sb.Id
    group by st.Name
    order by sm.Mark desc
    limit 1
)
union
(
    select st.Name,
       avg(sm.Mark) as Avg
    from Students st
    inner join StudentMarks sm on st.Id = sm.StudentId
    inner join Subjects sb on sm.SubjectId = sb.Id
    group by st.Name
    order by sm.Mark
    limit 1
);

create view ClassMarks(
    Class,
    SubjectName,
    AverageMark
)
as
select st.ClassNum, sb.Name, avg(sm.Mark)
    from StudentMarks sm
    left join Students st on sm.StudentId = st.Id
    left join Subjects sb on sm.SubjectId = sb.Id
    group by st.ClassNum, sb.Id, sb.Name;

update Students set ClassNum = 12 where ClassNum = 10;
drop view ClassMarks;

select *
    from ClassMarks
    where Class = 12;


create view AverageGradeForEverySubjectForEveryStudent (
    StudentName,
    SubjectName,
    AverageGrade
)
as
select st.Name, sb.Name, avg(sm.Mark)
    from StudentMarks sm
    left join Students st on sm.StudentId = st.Id
    left join Subjects sb on sm.SubjectId = sb.Id
    group by sb.Name, st.Name;

drop view AverageGradeForEverySubjectForEveryStudent;

select * from AverageGradeForEverySubjectForEveryStudent;

select st.Name, sb.Name, avg(sm.Mark)
    from Students st
    left join StudentMarks sm on st.Id = sm.StudentId
    left join Subjects sb on sm.SubjectId = sb.Id
    group by sb.Name;

select st.Name, sb.Name, avg(sm.Mark)
    from Subjects sb
    left join StudentMarks sm on sb.Id = sm.SubjectId
    left join Students st on sm.StudentId = st.Id
    group by sb.Name;

select ags.SubjectName, ags.StudentName, max(ags.AverageGrade)
    from AverageGradeForEverySubjectForEveryStudent ags
    group by ags.SubjectName;

create procedure SearchForNameDuplication(IN name varchar(150))
begin
    declare numberOfRows int default 0;
    declare firstId int default 0;
    declare lastId int default 0;
    declare nextId int default firstId;

    select min(sm.StudentId) from StudentMarks sm into firstId;
    select max(sm.StudentId) from StudentMarks sm into lastId;
    select count(*) from StudentMarks into numberOfRows;

    drop table if exists TempNames;
    create temporary table TempNames(
        id int,
        Name varchar(200)
    );

    while firstId <= lastId do
            select st.Name
            from StudentMarks sm
                     left join Students st on st.Id = sm.StudentId;

        end while;

    select * from TempNames;
    drop table TempNames;
end;

create function ProcessName(StudentId int, StudentName varchar(150)) returns varchar(200)
begin
    declare CountToThis int;
    declare DuplicatesCount int;

    select count(this.Id), count(*)
    into CountToThis, DuplicatesCount
    from Students st
             left join Students this
                       on st.Id <= this.Id and this.Id = StudentId
    where st.Name = StudentName
    order by st.Id;

    if DuplicatesCount >= 1 then
        return concat(StudentName, '(', CountToThis, ')');
    else
        return StudentName;
    end if;
end;

create table NewTeachers(
    Id int auto_increment primary key,
    FirstName varchar(150),
    MiddleName varchar(150),
    LastName varchar(150),
    FullName varchar(450)
);

create trigger ConcatFullName before insert on newteachers
    for each row set New.FullName = concat(New.FirstName, ' ', New.MiddleName, ' ', New.LastName);

insert into NewTeachers(Id, FirstName, MiddleName, LastName) values
    (null, 'Pesho', 'Peshev', 'Peshev'),
    (null, 'Gosho', 'Goshov', 'Goshov'),
    (null, 'Tosho', 'Toshov', 'Toshov');

select * from NewTeachers;