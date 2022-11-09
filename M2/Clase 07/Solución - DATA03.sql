-- Homework 2.

DELETE 
FROM cohorte 
WHERE idCohorte = 1245;
DELETE 
FROM cohorte 
WHERE idCohorte = 1246;

DELETE 
FROM cohorte
WHERE idCohorte BETWEEN 1245 AND 1246;

DELETE 
FROM cohorte
WHERE idCohorte in (1245,1246);

SELECT * 
FROM cohorte;

-- Homework 3.

UPDATE cohorte
SET fechaInicio = '2022-05-16'
WHERE idCohorte = 1243;

UPDATE alumno
SET fechaIngreso = '2022-05-16'
WHERE idCohorte = 1243;

SELECT *
FROM alumno
WHERE idCohorte = 1243;

-- Homework 4.

UPDATE alumno
SET apellido = 'Ramirez'
WHERE idAlumno = 165;

SELECT *
FROM alumno
WHERE idAlumno = 165;

-- Homework 5.

SELECT CONCAT(nombre,' ',apellido) as nombreCompleto, fechaIngreso, idCohorte
FROM alumno
WHERE idCohorte = 1243;

-- Homework 6.

SELECT *
FROM instructor;

-- Soluciones compañeros

SELECT i.nombre,
	   i.apellido,
       i.idInstructor,
       carrera.nombre,
       cohorte.idCohorte
FROM instructor i -- ponemos el alias instructor as i
INNER JOIN cohorte 
	ON cohorte.idInstructor = i.idInstructor
inner join carrera
	on carrera.idCarrera = cohorte.idCarrera
where carrera.nombre like '%Full%';

SELECT * 
FROM instructor
WHERE idInstructor IN (SELECT idInstructor
						FROM cohorte
						INNER JOIN carrera ON cohorte.idCarrera=carrera.idCarrera
						WHERE nombre = 'Full Stack Developer');


SELECT *
FROM carrera
WHERE nombre LIKE 'F%';

SELECT DISTINCT nombre, apellido, cedulaIdentidad
FROM instructor
INNER JOIN cohorte
	ON instructor.idInstructor = cohorte.idInstructor
WHERE cohorte.idCarrera = 1;


-- Solución profesor

select  distinct i.cedulaIdentidad,
		i.nombre,
        i.apellido,
        i.fechaNacimiento,
        i.fechaIncorporacion,
        # co.codigo as codigoCohorte,
        ca.nombre as nombreCarrera
from instructor as i 
	join cohorte as co -- les pongo alias
		on (i.idInstructor = co.idInstructor)
    join carrera as ca
		on (co.idCarrera = ca.idCarrera)
where ca.nombre = 'Full Stack Developer';

-- Homework 7.

SELECT CONCAT(apellido,', ', nombre ) as Nombre
FROM alumno
WHERE idCohorte = 1235;

-- Homework 8.

select * from alumno 
where idCohorte=1235 and fechaIngreso like '%2019%';

SELECT *
FROM alumno
WHERE fechaIngreso BETWEEN '2019-01-01' AND '2019-12-31';

SELECT *
FROM alumno
WHERE year(fechaIngreso) = 2019 AND idCohorte = 1235; 

-- Homework 9.

/* En el M3 profudizaremos en el aprendizaje de SQL, pero aprovechemos lo que sabemos hasta aquí para entender como funcionan las relacionales. */

SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
INNER JOIN cohorte co
ON a.idCohorte=co.idCohorte
INNER JOIN carrera ca
ON ca.idCarrera = co.idCarrera;


SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
	INNER JOIN cohorte co
		ON a.idCohorte=co.idCohorte
	INNER JOIN carrera ca
		ON ca.idCarrera = co.idCarrera
WHERE a.nombre LIKE 'F%';


SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
	INNER JOIN cohorte co
		ON a.idCohorte=co.idCohorte
	INNER JOIN carrera ca
		ON ca.idCarrera = co.idCarrera
WHERE ca.nombre LIKE 'F%'; -- ESTE ESTÁ BIEN

SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
	INNER JOIN cohorte co
		ON a.idCohorte=co.idCohorte
	INNER JOIN carrera ca
		ON ca.idCarrera = co.idCarrera
WHERE ca.nombre = 'Full Stack Developer';

SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
	INNER JOIN cohorte co
		ON a.idCohorte=co.idCohorte
	INNER JOIN carrera ca
		ON ca.idCarrera = co.idCarrera
WHERE ca.nombre != 'Data Science';