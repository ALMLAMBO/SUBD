/*create database school;*/

use school;

/*create table students (
	Id integer auto_increment primary key,
	Name varchar(150) not null,
	EGN char(10) not null,
	Birthday date
);

insert into students values 
	(null, 'Aleksander Marinov', '1111111110', '2000-11-02'), 
    (null, 'Aleksander Petrov', '1234567890', '1999-02-01'),
    (null, 'Boris Georgiev', '0134567801', '1992-06-08'),
	(null, 'Georgi Demirev', '2143658709', '1932-09-01');
*/

select * from students
where Birthday < '2000-01-01' order by Birthday;

/*drop database school;*/