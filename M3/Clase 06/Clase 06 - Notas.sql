USE henry;

SELECT *
FROM cohorte;

SELECT codigo FROM cohorte WHERE idCohorte = 3;

SET @cod2 = 'DATA02';
SET @cod2 = 'DATA03';

SELECT @cod2;

SELECT *
FROM cohorte
WHERE codigo = @cod2;

SELECT @cod := codigo FROM cohorte WHERE idCohorte = 3;

SELECT @conteo := COUNT(codigo) FROM cohorte;

SET @numero = 10;

SELECT @conteo*@conteo;

DELIMITER $$

SELECT @cod$$

DELIMITER ;
SELECT *
FROM cohorte
WHERE codigo = @cod;

SELECT fechaInicio 
FROM cohorte
WHERE codigo = @cod;


-- $$ cambia el delimitador

delimiter $$
create procedure GetTotalAlumnos()
begin
	declare totalAlumnos int default 0;
    select count(*)
    into totalAlumnos
    from alumno;
    
    select totalAlumnos;
end $$

DELIMITER ;

CALL GetTotalAlumnos();

SHOW VARIABLES;

SHOW SESSION VARIABLES;

SHOW LOCAL VARIABLES;

SHOW VARIABLES LIKE '%timeout%';

-- EJEMPLO 1:

-- Esta función recibe una fecha de ingreso y cálcula la antigüedad en meses del alumno.

SHOW VARIABLES LIKE '%log_bin_trust%';

SET GLOBAL log_bin_trust_function_creators = 'ON';

DELIMITER $$
CREATE FUNCTION antiguedadMeses(fechaIngreso DATE) RETURNS INT -- Asignamos un nombre, parámetros de la función y tipo de dato a retornar.

-- La función se define entre BEGIN - END.
BEGIN
	DECLARE meses INT;
    DECLARE años INT; -- Declaramos las variables que van a operar en la función
	SET meses = TIMESTAMPDIFF(MONTH, fechaIngreso, DATE(NOW())); -- Definimos el script.
    RETURN meses; -- Retornamos el valor de salida que debe coincidir con el tipo declarado en CREATE
END$$

DELIMITER ;

SELECT idAlumno , antiguedadMeses(fechaIngreso) as antiguedad
FROM alumno
HAVING antiguedad > 20;

-- EJEMPLO 2:

-- Esta función recibe el id de un alumno y devuelve su antigüedad en meses.

DELIMITER $$
CREATE FUNCTION antiguedadMeses2(id INT) RETURNS INT
BEGIN
	DECLARE meses INT;
    SELECT TIMESTAMPDIFF(MONTH, fechaIngreso, DATE(NOW()))
    INTO meses
    FROM alumno
    WHERE idAlumno = id;
    RETURN meses;
END$$

DELIMITER ;

SELECT antiguedadMeses2(1);

-- Este procedimiento lista los alumnos pertenecientes a una carrera.

SELECT * FROM carrera;

DROP PROCEDURE listarCarrera;

DELIMITER $$
CREATE PROCEDURE listarCarrera( IN nombreCarrera VARCHAR(25))
BEGIN
	SELECT CONCAT(alumno.nombre,' ',alumno.apellido) AS Alumno, alumno.idCohorte
	FROM alumno
		INNER JOIN cohorte
			ON alumno.idCohorte = cohorte.idCohorte 
		INNER JOIN carrera
			ON a.idCarrera = carrera.idCarrera
   WHERE carrera.nombre = nombreCarrera;
END$$

DELIMITER ;

CALL listarCarrera('Data Science')
