-- Insertar forma 1

INSERT INTO carrera
VALUES (1,'Fullstack Developer'),
	   (2, 'Data Scientist');
       
SELECT * 
FROM carrera;

INSERT INTO instructor
VALUES (1,15050678, 'Ricardo', 'Montaner', '1987-03-01', null),
	   (2,39000000, 'Pablo José', 'Romero', '1995-08-15', '2022-06-06');

SELECT *
FROM instructor;

INSERT INTO cohorte
VALUES	(1,'DATA01',1,1,'2022-01-01',null),
		(2,'DATA02',1,1,'2022-03-01',null),
		(3,'DATA03',1,1,'2022-04-01',null);
        
SELECT *
FROM cohorte;

-- Insertar forma 2

INSERT INTO alumno (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, idCohorte)
VALUES (44123456, 'Pepito', 'González', '1995-08-15', '2022-04-01', 1),
	   (1200, 'Roque', 'Peña', '1890-08-15', '2022-04-01', 1),
       (33123476, 'Pepita', 'Romero', '1995-08-15', '2022-04-01', 1);

TRUNCATE TABLE alumno;
SELECT *
FROM alumno;

SELECT *
FROM instructor
WHERE apellido LIKE '%a';

SELECT *
FROM instructor
WHERE fechaNacimiento < '1990-01-01';


SELECT *
FROM instructor
WHERE fechaNacimiento BETWEEN '1990-01-01' AND '2000-01-01';

UPDATE instructor
SET nombre = 'Juan', apellido = 'Tolosa'
WHERE idInstructor = 2;

SELECT count(idAlumno) as NumAlumn
FROM alumno;

SELECT count(*) as NumC
FROM cohorte;


CREATE DATABASE kiosco;

USE kiosco;

CREATE TABLE venta(
	idVenta INT NOT NULL AUTO_INCREMENT,
    precio INT NOT NULL,
    cantidad INT NOT NULL,
    fechaVenta DATE NOT NULL,
    PRIMARY KEY (idVenta)
);


INSERT INTO venta(precio, cantidad, fechaVenta)
VALUES (50, 50, '2000-12-05'),
	   (70,10, '2002-06-06'),
       (1000, 5, '2020-12-05'),
	   (70,15, '1995-06-06'),
       (25, 23, '2015-12-05'),
	   (700,16, '2018-06-06');
       
        
SELECT *
FROM venta;

SELECT idVenta , cantidad * precio as Ingreso
FROM venta
WHERE year(fechaVenta) BETWEEN 2010 AND 2020;

SELECT idVenta , cantidad * precio as Ingreso
FROM venta
WHERE cantidad * precio > 5000 OR cantidad * precio < 5000;

SELECT idVenta , cantidad * precio as Ingreso
FROM venta
WHERE pais LIKE 'C%';

ALTER TABLE venta
ADD pais VARCHAR(20);

SELECT *
FROM venta;

UPDATE venta
SET pais = 'Colombia'
WHERE idVenta in (1,2,3);

UPDATE venta
SET pais = 'México'
WHERE idVenta in (4,5,6);

SELECT *
FROM venta;