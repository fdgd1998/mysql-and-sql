USE cazadores;

INSERT INTO CLUB VALUES
	(11,'Los Trillaos'),
    (22,'Los Tiradores');
    
INSERT INTO CAZADOR VALUES
	(1,'Pepa Ramirez',31,'M',698747125,300,11),
    (2,'Maria Cortez',45,'M',658547125,200,11),
	(3,'Antonio Ramirez',25,'H',698547125,300,11),
    (4,'Antonio Gomez',36,'H',698547125,500,22),
    (5,'Mariana Diaz',18,'M',698987125,800,22);
    
INSERT INTO ARMAS VALUES
	(1,'Rifle 3a2'),
	(2,'Franco 78'),
    (3,'Winchester x-24'),
    (4,'AK-47');
    
INSERT INTO POSEE VALUES
	(1,1,1),
    (2,1,2),
    (3,1,3),
    (4,2,1),
    (5,3,4),
    (6,4,1),
    (7,4,2),
    (8,4,4),
    (9,5,3);
    
INSERT INTO PIEZAS VALUES
	(1,'Venado','Albino','Sur'),
    (2,'Mono','Babuino','Norte'),
    (3,'Antilope','Rayado','Oeste');
    
INSERT INTO CACERIA VALUES
	(1,1,3,'2015-05-25',1.85,35.41,'Hembra'),
    (2,3,1,'2014-07-18',2.14,78.45,'Macho'),
    (3,7,2,'2008-04-17',1.35,25.78,'Macho');

    
    
    
    
    
    