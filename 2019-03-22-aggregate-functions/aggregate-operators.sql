drop database if exists school;
create database school charset 'utf8';

use school;

create table Students (
  Id integer not null auto_increment primary key,
  Name varchar(150) not null,
  Num integer not null,
  ClassNum integer not null,
  ClassLetter varchar(1) not null,
  Birthday date,
  EGN char(10),
  EntranceExamResult numeric(3, 2) not null
);

create table Subjects (
  Id integer not null auto_increment primary key,
  Name varchar(100)
);

create table StudentMarks (
  StudentId integer not null,
  SubjectId integer not null,
  ExamDate datetime not null,
  Mark numeric(3, 2) not null,
  primary key(StudentId, SubjectId, ExamDate),
  foreign key (StudentId) references Students(Id),
  foreign key (SubjectId) references Subjects(Id)
);

create table MarkWords (
  RangeStart numeric(3, 2) not null,
  RangeEnd numeric(3, 2) not null,
  primary key(RangeStart, RangeEnd),
  MarkAsWord varchar(15)
);

insert into Students
  (Id, Name, Num, ClassNum, ClassLetter, Birthday, EGN)
  values (101, 'Зюмбюл Петров', 10, 11, 'а', '1999-02-28', null);

insert into Students
  (Name, Num, ClassNum, ClassLetter, Birthday, EGN)
  values ('Исидор Иванов', 15, 10, 'б', '2000-02-29', '0042294120'),
         ('Панчо Лалов', 20, 10, 'б', '2000-05-01', null),
         ('Петраки Ганьов', 20, 10, 'а', '1999-12-25', '9912256301'),
         ('Александър Момчев', 1, 8, 'а', '2002-06-11', null);

insert into Subjects(Id, Name) values
                                      (11, 'Английски език');

insert into Subjects(Name) values ('Литература'),
                                  ('Математика'),
                                  ('СУБД');

insert into StudentMarks values
                                (101, 11, '2017-03-03', 6),
                                (101, 11, '2017-03-31', 5.50),
                                (102, 11, '2017-04-28', 5),
                                (103, 12, '2017-04-28', 4),
                                (104, 13, '2017-03-03', 5),
                                (104, 13, '2017-04-07', 6),
                                (104, 11, '2017-04-07', 4.50);

insert into MarkWords values
                             (2, 2.50, 'Слаб'),
                             (2.50, 3.50, 'Среден'),
                             (3.50, 4.50, 'Добър'),
                             (4.50, 5.50, 'Мн. добър'),
                             (5.50, 6, 'Отличен');

-- 1. Брой пълни шестици по всеки един предмет

select sb.Name, count(*)
        from Subjects sb
        left join StudentMarks sm on sb.Id = sm.SubjectId
        where Mark = 6
        group by sb.Name;

-- 2. Среден успех по всеки предмет на всеки ученик

select st.Name, avg(sm.Mark)
        from Students st
        left join StudentMarks sm on st.Id = sm.StudentId
        group by st.Name;

-- 3. Всички ученици с отличен среден успех - име, номер, клас и успех

select st.Name, avg(sm.Mark)
        from Students st
        left join StudentMarks sm on st.Id = sm.StudentId
        group by st.Name
        having avg(sm.Mark) >= 5.5;

-- 4. Всички предмети, по които няма нито една оценка

select sb.Name, avg(sm.Mark)
        from Subjects sb
        left join StudentMarks sm on sb.Id = sm.SubjectId
        group by sb.Name
        having avg(sm.Mark) is null;

-- 5. Всички ученици, подредени по клас, паралелка и име

select * from Students st
          order by st.ClassNum asc,
                   st.ClassLetter asc,
                   st.Name asc;

-- 6. Учебните предмети със слаб среден успех по тях, подредени във възходящ ред на успеха

select sb.Name, avg(sm.Mark)
        from Subjects sb
        left join StudentMarks sm on sb.Id = sm.SubjectId
        group by sb.Name
        having avg(sm.Mark) < 3
        order by avg(sm.Mark) asc;