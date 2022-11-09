![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Join

La instrucción Join, se usa para acceder los datos de dos tablas relacionadas a través de algún campo en común, este acceso se da gracias a las “foreign key” que permiten generar las relaciones entre ellas. Join permite tener un alto grado de normalización en las tablas y aún así poder accederlas de forma sencilla.

![Join1](https://www.campusmvp.es/recursos/image.axd?picture=INNER-LEFT-RIGHT-FULL-JOIN.png)


### Teoria de conjuntos

El álgebra de conjuntos engloba las relaciones que se pueden establecer entre ellos.

- Unión de conjuntos: La unión de dos o más conjuntos contiene cada elemento que está contenido, al menos, en alguno de ellos.<br>
- Intersección de conjuntos: La intersección de dos o más conjuntos incluye todos los elementos que estos conjuntos comparten o que tienen en común.<br>
- Diferencia de conjuntos: La diferencia de un conjunto respecto a otro es a igual a los elementos del primer conjunto menos los elementos del segundo.<br>
- Conjuntos complementarios: El complemento de un conjunto incluye todos los elementos que no están contenidos en dicho conjunto (pero que sí pertenecen a otro conjunto de referencia).<br>
- Diferencia simétrica: La diferencia simétrica de dos conjuntos incluye todos elementos que están en uno o en otro, pero no en ambos al mismo tiempo.<br>
- Producto cartesiano: Es una operación que da como resultado un nuevo conjunto. Contiene como elementos los pares ordenados o las tuplas (series ordenadas) de los elementos que pertenecen a dos o más conjuntos. Son pares ordenados si se trata de dos conjuntos y tuplas si son más de dos conjuntos.


### Diagrama de Venn

Como vimos en móduloa anteriores los diagramas de Venn son esquemas usados en la teoría de conjuntos. Estos diagramas muestran colecciones (conjuntos) de cosas (elementos) por medio de líneas cerradas. La línea cerrada exterior abarca a todos los elementos bajo consideración, el conjunto universal U. Usa círculos que se superponen u otras figuras para ilustrar las relaciones lógicas entre dos o más conjuntos de elementos.

- Conjunto: Una colección de cosas. Dada la versatilidad de los diagramas de Venn, las cosas pueden ser realmente lo que quieras. Pueden ser elementos, objetos, miembros o términos similares.


- Unión: Todos los elementos de los conjuntos.


- Intersección: Los elementos que se superponen en los conjuntos. A veces se denominan "subconjuntos".

- Diferencia simétrica entre dos conjuntos: Todo, excepto la intersección.

- Complemento relativo: En un conjunto pero no en el otro..

### Tipos de JOIN en SQL

- Inner Join: Devuelve sólo aquellas filas donde haya un “match”, es decir, las filas donde el valor del campo de la tabla A que se utiliza para hacer el Join coincida con el valor del campo correspondiente en la tabla B.  Ejemplo: devolver todos los productos para los que haya como mínimo un pedido en los últimos días (el inner join enlazará el campo producto en la tabla Pedido con la clave primaria de ese producto en la tabla Producto). Se aplica por defecto cuando no indicamos otra cosa al hacer la consulta.<br> 
- Left Join: Cuando quieres todas las filas para las que haya match pero también aquellas de la Tabla A que no hagan match. Siguiendo el ejemplo anterior, si quieres listar todos los productos con datos de sus pedidos pero mostrando también aquellos productos para lo que no tengas todavía un pedido, la solución sería hacer una Left Outer join entre Producto y Pedido.<br>
- Right Join:  Exactamente lo mismo pero a la inversa, cuando quieres listar las filas de la tabla B aunque no estén relacionadas con ninguna fila de la tabla A. Es un operador un poco redundante ya que se podría cambiar simplemente el orden de las  tablas en el Join y utilizar un left para conseguir el mismo efecto. No obstante, y como parte de Joins múltiples, es útil tener los dos para un mejor comprensión de la consulta
- Full outer join. Es como la suma de las dos anteriores. Queremos tanto las filas de la A como las de B, tanto si hay match como si no (evidentemente cuando haya match la consulta devolverá todos los campos de A y B que hayamos indicado, cuando no, la consulta devolverá sólo los campos de A o B).

![Join](https://ingenieriadesoftware.es/wp-content/uploads/2018/07/sqljoin.jpeg)

- [JOIN en MySQL](https://dev.mysql.com/doc/refman/8.0/en/join.html)<br>
- [UNION en MySQL](https://dev.mysql.com/doc/refman/8.0/en/union.html)<br>
- [UNION en MySQL](https://dev.mysql.com/doc/refman/8.0/en/union.html)<br>
- [JOIN en SQL Server](https://docs.microsoft.com/es-es/sql/relational-databases/performance/joins?view=sql-server-ver15)<br>

## Homework

1. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto y su respectivo precio.
2. Obteber un listado de clientes con la cantidad de productos adquiridos, incluyendo aquellos que nunca compraron algún producto.
3. Obtener un listado de cual fue el volumen de compra (cantidad) por año de cada cliente. 
4. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto, la cantidad de productos adquiridos y el precio promedio.
5. Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad, presentar el análisis en un listado con el nombre de cada localidad.
6. Cacular la cantidad de productos vendidos y la suma total de ventas para cada provincia, presentar el análisis en un listado con el nombre de cada provincia, pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.
7. Obtener un listado de dos campos en donde por un lado se obtenga la cantidad de productos vendidos por rango etario y las ventas totales en base a esta misma dimensión. El resultado debe obtenerse en un solo listado.
8. Obtener la cantidad de clientes por provincia.

