drop database if exists library;
create database library;

use library;

create table Books (
    Id int auto_increment primary key,
    Title varchar(100) not null,
    ISBN bigint not null,
    ReleaseDate date not null
);

create table Authors (
    Id int auto_increment primary key,
    Name varchar(100) not null,
    BookId int,
    foreign key (BookId) references Books(Id)
);

insert into Books values
    (null, 'Dressed for death', 9781234567897, '2019-01-20'),
    (null, 'Azure Windows', 979123456789, '2018-06-10'),
    (null, 'The Elemental Guardian', 9781565812314, '2018-09-05'),
    (null, 'Voyages of Thorn', 9788417440046, '2018-05-17'),
    (null, 'The Flame''s Dreamer', 9780837648675, '2017-12-21'),
    (null, 'The Thorn of the Bridges', 9786874079359, '2015-08-31'),
    (null, 'Sky in the Edge', 9788033178101, '2016-11-12');

-- select * from Books;

insert into Authors values
    (null, 'Lygia Kiran', null),
    (null, 'Anatolia Daniela', 3),
    (null, 'Raphaël Fauna', 4),
    (null, 'Katinka Rosina', 1),
    (null, 'Adde Remington', 2),
    (null, 'Adde Remington', 6),
    (null, 'Adde Remington', 5),
    (null, 'Konrad Mubin', null),
    (null, 'Katinka Rosina', 7),
    (null, 'Kristina Tamara', 3),
    (null, 'Münir Costică', 4),
    (null, 'Tracy Melker', 3),
    (null, 'Tracy Melker', 4),
    (null, 'Münir Costică', 3),
    (null, 'Katinka Rosina', 2);

-- select * from Authors;

-- 1. Заглавията на всички книги, издадени през определена година.
select b.Title from Books b
    where b.ReleaseDate
    between '2018-01-01'
    and '2019-01-01';

-- 2. Заглавието, годината на издаване и ISBN номер на всички
-- книги на определен автор, идентифициран по неговото име.

select b.Title, b.ReleaseDate,
        a.Name, b.ISBN
    from Authors a
    left join Books b on a.BookId = b.Id
    where a.Name = 'Adde Remington';

-- 3. Имената на всички автори на определена
-- книга, идентифицирана по своя ISBN номер.
select a.Name from Authors a
    left join Books b on a.BookId = b.Id
    where b.ISBN = 9781565812314;

-- 4.Броят на книгите на всеки един автор и името му, подредени в низходящ
-- ред по брой на книгите. Включете и авторите, които нямат издадени книги.

select a.Name, count(a.BookId)
    from Authors a
    left join Books B on a.BookId = B.Id
    group by a.Name
    order by count(a.BookId) desc;

-- 5.Заглавията на всички книги от определена година и броя на авторите им, като включите само
-- книгите, които имат поне два автора. Подредете резулатите по азбучен ред на заглавията на книгите.

select b.Title, count(a.Name)
        from Books b
        left join Authors a on b.Id = a.BookId
        where b.ReleaseDate
        between '2018-01-01'
        and '2019-01-01'
        group by a.Name
        having count(a.Name) >= 2
        order by b.Title;