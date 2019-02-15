use school;

create table studentsV2 (
	Id integer auto_increment primary key,
	Name varchar(150) not null,
    Class char(3) not null,
    Grade numeric(3, 2),
	Birthday date
);

insert into studentsV2 values 
	(null, 'Александър Маринов', '11a', null, '2001-04-24'),
    (null, 'Теодора Трифонова', '11b', 5.8, null),
    (null, 'Христина Иванова', '11a', 5.9, '2001-01-31');

/*select * from studentsV2 where class like '11b';

select * from studentsV2 
	where studentsV2.Birthday is null or studentsV2.Grade is null;
*/

update studentsV2 
	set studentsV2.Grade = studentsV2.Grade + 1 
    where studentsV2.Grade <= 5;

update studentsV2 
	set Grade = 6 where Name like '%ова' 
    or Name like '%ева';

select * from studentsV2;

drop table studentsV2;