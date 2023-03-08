-- 1
use albums_db;
select database();
-- 2 id
show tables;
show create table albums;
/*
CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1
*/

-- 3 album name
-- 4 number of albums sold in millions probably
select * from albums;
-- 5 the dark side of the moon, the wall
select * from albums where artist = 'Pink Floyd';
-- 6 1967
select release_date, name from albums where name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- 7 Grunge, alternative rock
select genre, name from albums where name = 'Nevermind';
/* 8
The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural
*/
select release_date, name from albums where release_date between 1990 and 1999;
/* 9
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
*/
select sales, name from albums where sales < 20;
