create table subjects (
  Id integer auto_increment primary key,
  Name varchar(50)
);

create table students (
  id int auto_increment primary key,
  Name varchar(100) not null,
  NumberInClass int not null,
  ClassId varchar(4) not null
);

create table studentsSubjects (
  Id int auto_increment primary key,
  StudentId integer not null,
  SubjectId integer not null,
  ExamDate date,
  foreign key (StudentId) references students(id),
  foreign key (SubjectId) references subjects(Id)
);

insert into subjects values
                    (null, 'English'),
                    (null, 'Russian'),
                    (null, 'Maths'),
                    (null, 'OOP'),
                    (null, 'SUBD');

insert into students values
                    (null, 'Aleksander', 1, '11A'),
                    (null, 'Hristina', 24, '11A'),
                    (null, 'Tosho', 2, '11B'),
                    (null, 'Gosho', 4, '11V'),
                    (null, 'Pesho', 1, '11G');

insert into studentsSubjects values
                        (null, 1, 2, '2019-01-06'),
                        (null, 1, 1, '2018-12-20');

select * from studentsSubjects;
select * from students;
select * from students;