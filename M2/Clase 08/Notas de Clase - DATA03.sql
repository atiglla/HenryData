USE henry;

SELECT *
FROM alumno
ORDER BY fechaNacimiento ASC;


SELECT nombre, fechaNacimiento
FROM alumno
ORDER BY fechaNacimiento ASC
LIMIT 1;


SELECT *
FROM alumno
ORDER BY idCohorte ASC, nombre ASC
LIMIT 10;


SELECT *
FROM alumno
ORDER BY fechaNacimiento ASC
LIMIT 5;

SELECT COUNT(*) as num_alumnos_X21, MAX(fechaIngreso), MIN(fechaNacimiento)
FROM alumno
WHERE year(fechaNacimiento) > 1999;

SELECT COUNT(*) as cant_alumnos, idCohorte
FROM alumno
GROUP BY idCohorte
ORDER BY cant_alumnos DESC;

CREATE VIEW cantidadAlumnos AS
SELECT COUNT(*) as cant_alumnos, idCohorte
FROM alumno
GROUP BY idCohorte
HAVING cant_alumnos > 15;


SELECT COUNT(*)
FROM cantidadAlumnos;