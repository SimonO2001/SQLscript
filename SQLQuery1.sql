IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'TEC')
Create database TEC;

else
use TEC -- Her tjekker SQL om databasen findes, hvis ikke opretter den en ny database ved navn "TEC"
go

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'POST_NR_BY')
begin
CREATE TABLE POST_NR_BY (
post_nr Int NOT NULL PRIMARY KEY,
by_navn Char(255)
);


insert into POST_NR_BY values
(2650, NULL),
(2300, null),
(2500, null),
(2610, null),
(3650, null),
(2830, null),
(2770, null),
(1824, null),
(2740, null),
(2750, null);
end

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'postnr$')
begin
update POST_NR_BY
set by_navn = postnr$.postnr#1 from postnr$
where post_nr_by.post_nr = postnr$.Postnr#;
end


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'SKOLE_KLASSE')
begin

CREATE TABLE SKOLE_KLASSE (
klasse_id Int NOT NULL PRIMARY KEY,
klasse Char(255)
);


insert into SKOLE_KLASSE values
(1, '1A'),
(2, '9B'),
(3, '4D');
end

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ELEV')
begin

CREATE TABLE ELEV (
elev_id Int NOT NULL PRIMARY KEY, 
fornavn Char (255), 
efternavn Char (255), 
adresse Char (255),
klasse_id Int FOREIGN KEY REFERENCES SKOLE_KLASSE (klasse_id),
post_nr Int FOREIGN KEY REFERENCES POST_NR_BY (post_nr)
);


insert into ELEV values
(1, 'Bo', 'Andersen', 'Gammel Byvej 12', '1', '2650'),
(2, 'Frederikke', 'Hansen', 'Amager Boulevard 5', '2', '2300'),
(3, 'Jens', 'Mikkelsen', 'Lily Brogbergs Vej 17', '3', '2500'),
(4, 'Philip', 'Mortensen', 'Brunevang 90', '1', '2610'),
(5, 'Kasper', 'Frederiksen', 'Bryggetorvet 32', '2', '3650'),
(6, 'Milla', 'Jørgensen', 'Virum Torv 25', '3', '2830'),
(7, 'fie', 'Kudsen', 'Allen 85', '1', '2770'),
(8, 'Henrik', 'Madsen', 'Lily Brogbergs Vej 53', '2', '2500');
end

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'laerer')
begin

CREATE TABLE laerer (
laerer_id Int NOT NULL PRIMARY KEY, 
fornavn Char (255),
efternavn Char(255),
adresse Char(255),
klasse_id Int FOREIGN KEY REFERENCES SKOLE_KLASSE (klasse_id),
post_nr Int FOREIGN KEY REFERENCES POST_NR_BY (post_nr)
);


insert into laerer values
(1, 'Tom', 'it', 'Sankt Thomas alle 3', '1', 1824),
(2, 'Lars', 'Henriksen', 'Nissedalen 76', '2', 2740),
(3, 'Mia', 'Hansen', 'Østervej 16', '3', 2750);
end

select elev.fornavn, elev.efternavn, SKOLE_KLASSE.klasse 
from elev
join SKOLE_KLASSE on elev.klasse_id = SKOLE_KLASSE.klasse_id;


select laerer.fornavn, laerer.efternavn, post_nr_by.by_navn 
from laerer
join post_nr_by on laerer.post_nr = post_nr_by.post_nr;


select elev.fornavn, elev.efternavn, laerer.fornavn, laerer.efternavn
from elev
join laerer on elev.efternavn = laerer.efternavn;

