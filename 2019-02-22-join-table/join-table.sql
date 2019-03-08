use school;

/*create table primes (
	Id integer auto_increment primary key,
    PrimeValue integer not null
);

create table fibonacci (
	Id integer auto_increment primary key,
    FiboValue integer not null
);*/

/*insert into primes values 
	(null, 2),
    (null, 3),
    (null, 5);

insert into fibonacci values 
	(null, 1),
    (null, 1),
    (null, 2);
*/
select * from primes p 
	left join fibonacci f
    on p.PrimeValue = f.FiboValue;