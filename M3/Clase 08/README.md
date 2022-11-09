![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Subconsultas

Una consulta secundaria es una consulta de selección que está contenida dentro de otra consulta. La consulta de selección interna generalmente se usa para determinar los resultados de la consulta de selección externa. Consiste en utilizar los resultados de una consulta dentro de otra, que se considera la principal.<br>
Es una sentencia SELECT anidada dentro de una instrucción SELECT, SELECT…INTO, INSERT…INTO, DELETE, o UPDATE o dentro de otra
subconsulta.<br>
Una subconsulta tiene la misma sintaxis que una sentencia SELECT exceptuando que aparece encerrada entre paréntesis, no puede contener la cláusula ORDER BY, ni puede ser la UNION de varias sentencias SELECT.<br>
Las consultas que utilizan subconsultas suelen ser más fáciles de interpretar por el usuario.<br>
Recordemos que dentrol SQL, los datos solo son accesibles a través de consultas. Es por ello que si queremos por ejemplo obtener la fecha donde ingreso el primer estudiantes dentrol del moodelo desarrollado en el modulo anterior, la instrucción sería la siguiente:

```SQL

SELECT MIN(fechaIngreso) AS fecha
FROM alumnos

```
Si tuvieramos la intención de utulizar este valor para obtener un listado de todos los estudiantes que ingresaron en esa fecha lo intuitivo sería lo siguiente:

```SQL

SELECT idAlumno, fechaIngreso
FROM alumnos
WHERE fechaIngreso = MIN(fechaIngreso)

```

Lo anterior no resulta posible, debido a que como mencionamos más arriba para poder acceder a ese valor MIN(fechaIngreso), se debe hacer una consulta. Es por ello que aquí radica la utilidad y el funamento en la utilización de subconsultas.

```SQL

SELECT idAlumno, fechaIngreso
FROM alumnos
WHERE fechaIngreso = (  SELECT MIN(fechaIngreso) AS fecha
                        FROM alumnos)
```

Resulta siempre muy importante entender que valor esta devolviendo una consulta específica, ya que de haber presentado esta última instrucción de forma inicial quizás la compresión hubiera sidi más difícil. Las subconsultas pueden devolver al igual que cualquier otra instrucción tablas o valores. Y estos resultados a su vez pueden utilizarse para otro tipo de operaciones.<br>

Las subconsultas son un proceso de selección interno, y se pueden utilizar en cualquier sentencia que permita una expresión.

SELECT: Para calcular y crear un nuevo campo virtual a la consulta principal.

FROM: Para devolver una tabla secundaria calculada o un campo calculado con un contexto diferente.

WHERE: Para definir filtros compuestos cálculados. Si se conociera el valor a calcular con la subconsulta, su utilizaría ese valor. Por ej:<br>
La fecha mas reciente "MAX(date)". El operador utilizado para comparar, depende del resultado de la subconsulta:<br>
Listas --> IN , NOT IN.<br>
Valor único --> = , >=, <=, etc.<br>

Las tablas de las subconsultas, solo "existen" en ellas. Es decir, por fuera del parentesis que abarca la subconsulta, no se pueden agregar campos que refieran a esa tabla. Salvo que se incluya en el FROM de la principal.

En resumen:<br>
- Cuando necesites agregar un filtro cálculado, agregarás una subconsulta en WHERE o HAVING.<br>
- Cuando necesites anexar un campo calculado de otra tabla y este NO requiera agregación, la utilizaras en SELECT.<br>
- Cuando necesites anexar un campo calculado de otra tabla y este SI requiera agregación, la utilizaras en FROM. Para romper el contexto de filas.<br>

EXISTEN MÁS CASOS Y POSIBILIDADES.

En cuestiones de rendimiento, no se puede asegurar al 100% que las subconsultas sean más efectivas que otros métodos como JOIN, UNION o variables, ya que en realidad esto depende de diversos factores como el manejo de los índices, el tamaño de las tablas, el motor de la base de datos, entre otros. No obstante, proveen una forma bastante interesante de extraer datos.

- [Subconsultas en MySQL](https://dev.mysql.com/doc/refman/8.0/en/subqueries.html)<br>
- [Subconsultas en SQL Server](https://docs.microsoft.com/es-es/sql/relational-databases/performance/subqueries?view=sql-server-ver15)<br>

## Vistas

Es un mecanismo que permite almacenar de forma permanete el resuLtado de una consulta en SQL. A su vez este resultado almacenado en la vista se puede acceder como si fuera una tabla, denominandose a la vista como una tabla virtual. <br>
Las vistas se componen de campos y filas provenientes del resultado de la consulta, las cuales pueden venir de varias tablas.<br>
Al igual que con los otros objetos que forman parte de la base de datos se crean mediante la sentencia CREATE y se eliminan mediante DROP.

```SQL
-- Crear una vista.
CREATE VIEW primerosAlumnos AS
SELECT idAlumno, fechaIngreso
FROM alumnos
WHERE fechaIngreso = (  SELECT MIN(fechaIngreso) AS fecha
                        FROM alumnos)

-- Obtener los resultados de una vista.
SELECT *
FROM primerosAlumnos

-- Modificar una vista.
ALTER VIEW primerosAlumnos AS
SELECT idAlumno, CONCAT(apellido," ",nombre), fechaIngreso
FROM alumnos
WHERE fechaIngreso = (  SELECT MIN(fechaIngreso) AS fecha
                        FROM alumnos)

-- Eliminar una vista
DROP VIEW primerosAlumnos

```
Al crear una vista, esta queda alojada en la base de datos correspondiente y se pueden ver en la iterfaz del gestor de base de datos.

<img src="../_src/assets/vista.PNG"  height="100">

Una vista actúa como filtro de las tablas subyacentes a las que se hace referencia en ella. La consulta que define la vista puede provenir de una o de varias tablas, o bien de otras vistas de la base de datos actual u otras bases de datos. Asimismo, es posible utilizar las consultas distribuidas para definir vistas que utilicen datos de orígenes heterogéneos. Esto puede resultar de utilidad, por ejemplo, si desea combinar datos de estructura similar que proceden de distintos servidores, cada uno de los cuales almacena los datos para una región distinta de la organización.

### Ventajas

- Permite centrar, simplificar y personalizar la forma de mostrar la información a cada usuario.<br>
- Se usa como mecanismo de seguridad, el cual permite a los usuarios obtener acceso a la información proveninete de la vista sin acceder a otras opciones.<br>
- Proporciona una sintaxis simple para acceder a los resultados de la vista.

- [Vistas en SQL Server](https://docs.microsoft.com/es-es/sql/relational-databases/views/views?view=sql-server-ver15#:~:text=Una%20vista%20es%20una%20tabla,en%20una%20base%20de%20datos.)<br>
- [Vistas en MySQL](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)<br>

## Homework

1. Analiza mediante comentarios las instrucciones N° 1 y N° 2, detalladas en el archivo SQL. ¿Que tipo de resultado devulven las subconsultas?, ¿Cual es la finalidad de implementar las instrucciones?, ¿Que rol cumple la instrucción NOT IN?.<br> 
2. Analiza mediante comentarios la instruccion N° 3 detallada en el archivo SQL. ¿Que tipo de resultado devulven las subconsultas?, ¿Cual es la finalidad de implementar las instrucciones en FROM?, ¿Que campos actuán como claves para permitir la instrucción JOIN en las subconsultas?.<br> 
3. Crear una vista a partir de la instrucción N° 3.
4. Obtener el total de ventas del primer día y útlimo día sobre los cuales se tenga resgitros.
5. Obtenga un listado de los productos vendidos y del total de ventas de cada uno, según los requisitos del punto anterior.
6. Obtenga el importe total de ventas por fecha y a partir de este último listado, en que fecha se obtuvo el récord de ventas.


