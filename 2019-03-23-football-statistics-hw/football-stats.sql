-- 1. Създайте база данни "PlayerStats" за статистики на футболисти от един отбор.
drop database if exists PlayerStats;
create database PlayerStats;

use PlayerStats;

-- 2. Създайте таблица "StatTypes" за следените статистики със следната структура и данни:

create table StatTypes (
  StatCode varchar(3) not null primary key,
  Name varchar(20)
);

-- 3. Създайте таблица "Positions" с позициите на играчите със следната структура и данни:

create table Positions (
  PositionCode varchar(2) not null primary key,
  Name varchar(30)
);

-- 4. Създайте таблица "Players" с играчите в отбора със
-- следната структура и данни, включително връзки към други таблици:

create table Players (
  Id integer not null auto_increment primary key,
  Name varchar(100) not null,
  Num integer not null,
  PositionCode varchar(2) not null,
  foreign key (PositionCode) references Positions(PositionCode)
);

alter table Players modify column PositionCode varchar(2) after Num;

-- 5. Създайте таблица "Tournaments" с турнири, в
-- които участва отбора, със следната структура и данни:

create table Tournaments (
  Id integer not null auto_increment primary key,
  Name varchar(100)
);

-- 6. Създайте таблица "Matches" с планираните и изиграни мачове на отбора
-- със следната структура и данни, включително връзки към други таблици:

create table Matches (
  Id integer not null auto_increment primary key,
  TournamentId integer not null,
  MatchDate date not null,
  foreign key (TournamentId) references Tournaments(Id)
);

-- 7. Създайте таблица "MatchStats" с настъпилите събития в
-- мача със следната структура и данни, включително връзки към други таблици:

create table MatchStats (
  Id integer not null auto_increment primary key,
  MatchId integer not null,
  PlayerId integer not null,
  EventMinute integer not null,
  StatCode varchar(3) not null,
  foreign key (MatchId) references Matches(Id),
  foreign key (PlayerId) references Players(Id),
  foreign key (StatCode) references StatTypes(statcode)
);

insert into StatTypes values
                             ('G', 'Гол'),
                             ('A', 'Асистенция'),
                             ('R', 'Червен картон'),
                             ('Y', 'Жълт картон'),
                             ('OG', 'Автогол'),
                             ('IN', 'Смяна влиза'),
                             ('OUT', 'Смяна излиза');

-- select * from StatTypes;

insert into Positions values
                             ('GK', 'Вратар'),
                             ('RB', 'Десен защитник'),
                             ('LB', 'Ляв защитник'),
                             ('CB', 'Централен защитник'),
                             ('RM', 'Десен полузащитник'),
                             ('LM', 'Ляв полузащитник'),
                             ('CM', 'Полузащитник'),
                             ('CF', 'Централен нападател');

-- select * from Positions;

insert into Players values
                           (null, 'Ivaylo Trifonov', 1, 'GK'),
                           (null, 'Valko Trifonov', 2, 'RB'),
                           (null, 'Ognyan Yanev', 3, 'CB'),
                           (null, 'Zahari Dragomirov', 4, 'CB'),
                           (null, 'Bozhidar Chilikov', 5, 'LB'),
                           (null, 'Timotei Zahariev', 6, 'CM'),
                           (null, 'Marin Valentinov', 7, 'CM'),
                           (null, 'Mitre Cvetkov', 99, 'CF'),
                           (null, 'Zlatko Genov', 9, 'CF'),
                           (null, 'Matey Goranov', 10, 'RM'),
                           (null, 'Sergei Zhivkov', 11, 'LM');

-- select * from Players;

insert into Tournaments values
                               (null, 'Шампионска лига'),
                               (null, 'Първа лига'),
                               (null, 'Купа на България'),
                               (null, 'Суперкупа на България');

-- select * from Tournaments;

insert into Matches values
                           (null, '2018-04-08', 2),
                           (null, '2018-04-13', 2),
                           (null, '2018-04-21', 2),
                           (null, '2018-04-28', 2),
                           (null, '2018-05-06', 2),
                           (null, '2018-05-11', 2),
                           (null, '2017-09-21', 3),
                           (null, '2017-10-26', 3);

select * from Matches;

insert into MatchStats values
                              (null, 8, 9, 14, 'G'),
                              (null, 8, 8, 14, 'A'),
                              (null, 8, 3, 43, 'Y'),
                              (null, 7, 2, 28, 'Y'),
                              (null, 7, 10, 45, 'Y'),
                              (null, 7, 10, 65, 'R'),
                              (null, 1, 10, 23, 'G'),
                              (null, 1, 9, 23, 'A'),
                              (null, 1, 9, 43, 'G'),
                              (null, 2, 4, 33, 'OG'),
                              (null, 2, 9, 68, 'G'),
                              (null, 2, 1, 68, 'A'),
                              (null, 3, 3, 35, 'G'),
                              (null, 3, 4, 35, 'A'),
                              (null, 3, 8, 55, 'G'),
                              (null, 3, 11, 55, 'A'),
                              (null, 4, 3, 9, 'G'),
                              (null, 4, 8, 9, 'G'),
                              (null, 4, 8, 56, 'OG'),
                              (null, 5, 8, 67, 'G');

-- select * from MatchStats;