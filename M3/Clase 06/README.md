![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Variables

En los scripts SQL, se pueden utilizar variables para almacenar valores durante la ejecución de una secuencia de comandos y utilizarlos luego.<br>
MySQL reconoce diferentes tipos de variables. El primer tipo son las variables definidas por el usuario, identificadas por un símbolo @. Para inicializar una variable definida por el usuario, necesitas usar una declaración SET. Se puede inicializar muchas variables a la vez, separando cada declaración de asignación con una coma. Una vez que asignas un valor a una variable, tendrá un tipo de acuerdo al valor dado.

```SQL

SET @carrera1 = 'Data Science',@carrera2 = 'Full Stack'

SELECT @carrera1, @carrera2


```

Resulta útil muchas veces guardar el valor de una consulta SELECT en una variable. El valor de la variable, puede ser utilizado luego para realizar otras consultas u operaciones.<br>
La sintaxis para asignar una variable dentro de una sentencia SELECT es:

```SQL

SELECT @cod := codigo FROM cohortes WHERE idCohorte = 1235;

SELECT @cod

SELECT fechaInicio 
FROM cohortes
WHERE codigo = @cod

```

En segundo lugar están las variables locales. Este tipo de variables no necesitan el prefijo @ en sus nombres, se declaradan antes de que puedan ser usadas. Se pueden utilizar variables locales de dos maneras:
- Utilizando la declaración DECLARE.
- Como un parámetro dentro de una declaración STORED PROCEDURE. Se utilizan variables en los procedimientos almacenados para obtener resultados inmediatos. Estas variables son locales dentro del procedimiento.

Cuando se declara una variable local, se suele asignar un valor por defecto. La variable se inicializa con un valor NULL si no asignas ningún valor.

Cada variable existe en el espacio delimitado por el bloque BEGIN - END.


```SQL

-- Más abajo daremos más detalles sobre los procedimientos almacenados.
DELIMITER $$

CREATE PROCEDURE GetTotalAlumnos()
BEGIN
	DECLARE totalAlumnos INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalAlumnos
    FROM alumnos;
    
    SELECT totalAlumnos;
END$$

DELIMITER ;

CALL GetTotalAlumnos()

```
Existen también las denominadas variables del sistema, laa cuales se establecen normalmente al inicio del servidor.

Las variables del sistema se idenfican con un doble signo @ o utilizando las palabras GLOBAL o SESSION en la sentencia SET. Indican la configuración por defecto y pueden ser modificadas en caso de ser necesario.<br>
Para ver las variables de sistema en uso dentro de una sesión o en el servidor, se utiliza la sentencia SHOW VARIABLES.<br>
Es necesario a veces conocer el valor de estas variables, como el caso de la version que se está utilizando, o conocer y cambiar un timeout. Son muy útiles para quienes tratan de mejorar el rendimiento de su sesión.

```SQL
SHOW VARIABLES -- Muestra todas las variables.

SHOW SESSION VARIABLES 
SHOW LOCAL VARIABLES 
SHOW VARIABLES 

-- Se puede utilizar el operador LIKE '%Variable%' para acceder a una variable en particular.
-- Ejemplo:

SHOW SESSION VARIABLES LIKE 'version'

SHOW SESSION VARIABLES LIKE 'version_comment'

```

## Funciones

Las funciones  nos permiten procesar y manipular datos de forma procedural de un modo muy eficiente. Existen funciones integradas dentro de SQL, algunas de las que utilizamos son AVG, SUM, CONCATENATE, etc.<br>
Pueden ser utilizadas en las sentencias SQL independientemente del lenguaje de programación del servidor sobre el que se ejecuten las consultas. Las funciones también se pueden crear dentro de SQL y esto permite personalizar ciertas operaciones propias del proyecto.
Para poder crear funciones se deben tener los permisos INSERT y DELETE.<br>

La sintaxis de una función almacenada es la siguiente:
```SQL
-- EJEMPLO 1:

-- Esta función recibe una fecha de ingreso y cálcula la antigüedad en meses del alumno.

DELIMITER $$
CREATE FUNCTION antiguedadMeses(fechaIngreso DATE) RETURNS INT -- Asignamos un nombre, parámetros de la función y tipo de dato a retornar.

-- La función se define entre BEGIN - END.
BEGIN
	DECLARE meses INT; -- Declaramos las variables que van a operar en la función
	SET meses = TIMESTAMPDIFF(MONTH, fechaIngreso, DATE(NOW())); - -- Definimos el script.
    RETURN meses; -- Retornamos el valor de salida que debe coincidir con el tipo declarado en CREATE
END$$

DELIMITER ;

SELECT * , antiguedadMeses(fechaIngreso) 

FROM alumnos

-- EJEMPLO 2:

-- Esta función recibe el id de un alumno y devuelve su antigüedad en meses.

DELIMITER $$
CREATE FUNCTION antiguedadMeses2(id INT) RETURNS INT
BEGIN
	DECLARE meses INT;
    SELECT TIMESTAMPDIFF(MONTH, fechaIngreso, DATE(NOW()))
    INTO meses
    FROM alumnos
    WHERE idAlumno = id;
    RETURN meses;
END$$

DELIMITER ;

SELECT antiguedadMeses2(130)

```
- [Funciones MySQL](https://manuales.guebs.com/mysql-5.0/functions.html)
- [Funciones SQL Server](https://docs.microsoft.com/es-es/sql/t-sql/functions/functions?view=sql-server-ver15)
- [Funciones PostgreSQL](https://runebook.dev/es/docs/postgresql/functions-aggregate)

## Procedimientos Almacenados

Es un objeto que se crea con la sentencia CREATE PROCEDURE y se invoca con la sentencia CALL. Un procedimiento puede tener cero o muchos parámetros de entrada y cero o muchos parámetros de salida.<br>
Para definir un procedimiento almacenado es necesario modificar temporalmente el carácter separador que se utiliza para delimitar las sentencias SQL.<br>
El carácter separador que se utiliza por defecto en SQL es el punto y coma (;). Para crear procedimientos almacenados vamos a utilizar los caracteres $$ para delimitar las instrucciones SQL.

DELIMITER $$
DELIMITER;

Resulta útil cuando se repite la misma tarea repetidas veces, siendo un buen método para encapsular el código. Al igual que ocurre con las funciones, también puede aceptar datos como parámetros, de modo que actúa en base a éstos.


```SQL
CREATE PROCEDURE nombre_procedimiento
AS
sentencias_sql
GO;

```

Los parámetros de los procedimientos almacenados de MySQL pueden ser de tres tipos:
- IN: Es el tipo de parámetro que se usa por defecto. La aplicación o código que invoque al procedimiento tendrá que pasar un argumento para este parámetro. El procedimiento trabajará con una copia de su valor ya que está protegido, teniendo el parámetro su valor original al terminar la ejecución del procedimiento.<br>
- OUT: El valor de este parámetros pude ser cambiado en el procedimiento, y además su valor modificado será enviado de vuelta al código o programa que invoca el procedimiento.
- INOUT: Es una mezcla de los dos conceptos anteriores. La aplicación o código que invoca al procedimiento puede pasarle un valor a éste, devolviendo el valor modificado al terminar la ejecución.

```SQL
-- Este procedimiento lista los alumnos pertenecientes a una carrera.

DELIMITER $$
CREATE PROCEDURE listarCarrera( IN nombreCarrera VARCHAR(25))
BEGIN
	SELECT CONCAT(alumnos.nombre,' ',apellido) AS Alumno, cohorte
	FROM alumnos
	INNER JOIN cohortes
	ON cohorte = idCohorte
	INNER JOIN carreras 
	ON carrera = idCarrera
	WHERE carreras.nombre=nombreCarrera;
END;

DELIMITER

CALL listarCarrera('Data Science')

```

- [Triggers, procedimientos y funciones](https://josejuansanchez.org/bd/unidad-12-teoria/index.html#:~:text=Un%20procedimiento%20almacenado%20es%20un,o%20muchos%20par%C3%A1metros%20de%20salida.)


## Homework

1. Crear un procedimiento que recibe como parametro una fecha y devuelva el listado de productos que se vendieron en esa fecha.<br>
2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.
3. Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un margen bruto del 20% de cada uno de los productos.
4. Crear un procedimiento que permita listar los productos vendidos desde fact_venta a partir de un "Tipo" que determine el usuario.
5. Crear un procedimiento que permita realizar la insercción de datos en la tabla fact_inicial.
6. Crear un procedimiento almacenado que reciba un grupo etario y devuelta el total de ventas para ese grupo.
7. Crear una variable que se pase como valor para realizar una filtro sobre Rango_etario en una consulta génerica a dim_cliente.

