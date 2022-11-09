# 1. ¿Cuantas carreas tiene Henry?

USE henry;

SELECT count(idCarrera)
FROM carrera;

# 2. ¿Cuantos alumnos hay en total?

SELECT distinct count(nombre)
FROM alumno;

# 3. ¿Cuantos alumnos tiene cada cohorte?

SELECT cohorte, count(*)
FROM alumno
GROUP BY cohorte;

# 4. 

SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC;

# 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?

SELECT nombre, apellido
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;

SELECT DISTINCT nombre, apellido
FROM alumno
WHERE fechaIngreso in (SELECT MIN(fechaIngreso) from alumno);


# 6. ¿En que fecha ingreso?

SELECT nombre,apellido,fechaIngreso
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;

# 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

SELECT nombre,apellido
FROM alumno
ORDER BY fechaIngreso DESC
LIMIT 1;


-- Una mejor alternativa es esta, ya que si hay varios alumnos con 
-- la misma fecha de ingreso nos los muestra

SELECT DISTINCT nombre, apellido, fechaIngreso
FROM alumno
WHERE fechaIngreso in (SELECT MAX(fechaIngreso) from alumno);

# 8. ¿Cuantos alumnos ingresaron por año?

SELECT YEAR(fechaIngreso) "Año Ingreso", COUNT(*) AS Cantidad
FROM alumno
GROUP BY YEAR(fechaIngreso)
ORDER BY YEAR(fechaIngreso);

# 9. ¿Cuantos alumnos ingresaron por semana?

SELECT YEAR(fechaIngreso) AS "Año", WEEKOFYEAR(fechaIngreso) as "Semana", 
		   COUNT(*) AS Cantidad
FROM alumno
GROUP BY WEEKOFYEAR(fechaIngreso), YEAR(fechaIngreso)
ORDER BY 1,2;

# 10. En que años ingreasaron más de 20 alumnos?

SELECT YEAR(fechaIngreso) AS "Año Ingreso", COUNT(*) AS Cantidad
FROM alumno
GROUP BY YEAR(fechaIngreso)
HAVING COUNT(*)>20;

# 11. ¿Cual es la edad de los instructores?.

SELECT CURDATE();

SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", 
       TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS "Años"
FROM instructor;

-- Al sumarle la cantidad de años a la fecha de nacimiento, 
-- podemos verificar que efectivamente cálcula años completos.
-- Esto quiere decir que en el caso de 
-- Antonio Barrios	1981-07-09	40	2021-07-09, 
-- al sumarle la cantidad de años suma 40 y no 41.
SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", 
	   TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS "Años", 
	   DATE_ADD(fechaNacimiento,
		     INTERVAL (TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) YEAR) as "Verifica",
	   fechaNacimiento
FROM instructor;

# 12.

SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", 
	   TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS "Años"
FROM alumno
ORDER BY 2 DESC;

CREATE VIEW edadPromedio AS
SELECT AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) AS "Edad promedio"
FROM alumno;

SELECT idCohorte, AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) AS "Edad promedio"
FROM alumno
GROUP BY idCohorte; 

SELECT idCohorte, SUM(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) AS "Suma Edades"
FROM alumno
GROUP BY idCohorte; 


# 13. Elabora un listado de los alumnos que superan la edad promedio de Henry.

SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", 
	   TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS "Años"
FROM alumno
WHERE TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) > 32;

-- En el M3 veremos el concepto de "subconsultas", 
-- lo cual nos ayudará a volver dinámico el valor de nuestro filtro.

SELECT CONCAT(nombre," ",apellido) AS "Nombre y Apellido", 
       TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS "Años"
FROM alumno
WHERE TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) > (SELECT * FROM edadPromedio); 
-- Lo que hacemos es reemplazar el valor númerico por una consulta que lo devuelva.

DROP VIEW edadPromedio;