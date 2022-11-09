-- Solución de Homework.
use henry_m3;


-- 1. Crear un procedimiento que recibe como parametro una fecha y devuelva el listado de productos que se vendieron en esa fecha.

DROP PROCEDURE IF EXISTS listaProductos;

DELIMITER $$
CREATE PROCEDURE listaProductos(IN fechaVenta DATE)
BEGIN
	Select distinct tp.TipoProducto, p.Producto
	From fact_venta v join dim_producto p
			On (v.IdProducto = p.IdProducto
				And v.Fecha = fechaVenta)
		join tipo_producto tp
			On (p.idTipoProducto = tp.IdTipoProducto)
	Order by tp.TipoProducto, p.Producto;
END$$

DELIMITER ;

CALL listaProductos('2020-01-01');

-- 2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.

/* Margen Bruto = (PrecioVenta - PrecioCompra) / PrecioCompra 
pero si nos piden que calculemos el valor NOMINAL de determinado margen bruto según 
un precio dado debemos hacer PrecioCompra * margenBruto
*/

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS margenBruto;

DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,3), margen DECIMAL (9,2)) RETURNS DECIMAL (15,3)
BEGIN
	DECLARE margenBruto DECIMAL (15,3);
    
    SET margenBruto = precio * margen;
    
    RETURN margenBruto;
END$$

DELIMITER ;

Select margenBruto(100.50, 0.2);

-- 3. Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un margen bruto del 20% de cada uno de los productos.


/* Podemos querer obtener el margen bruto sobre el precio de compra */

Select 	c.Fecha,
		pr.Nombre					as Proveedor,
		p.Producto,
		c.Precio 					as PrecioCompra,
        margenBruto(c.Precio, 1.3)	as PrecioMargen
From 	compra c 
		Join producto p
			On (c.IdProducto = p.IdProducto)
		Join proveedor pr
			On (c.IdProveedor = pr.IdProveedor);



/* Podemos querer obtener el margen bruto sobre el precio de lista*/

SELECT 	Producto, 
		margenBruto(Precio, 0.30) AS Margen
FROM producto;

/* ¿Y cómo hacemos si querémos obtener el precio que cumple el margen, junto con el margen
de los productos de IMPRESIÓN? */

SELECT 	p.IdProducto, 
		p.Producto,
        p.Precio,
        margenBruto(Precio, 0.3) AS Margen,
        margenBruto(Precio, 1.3) AS PrecioMargen
FROM producto p join tipo_producto tp
	On (p.IdTipoProducto = tp.IdTipoProducto
		And TipoProducto = 'Impresión');
     
     
-- Un ejemplo más sobre el precio de compra

SELECT 	IdProducto, 
		precio as PrecioCompra, 
        ROUND(precio * ( (100 + 10) /100 ), 2) AS PrecioFinal -- esto es lo mismo que decir precio * 1.1, le pedimos 10% de margen
FROM compra;


/* Podemos también crear un procedimiento que calcule el precio final si le damos un porcentaje */

DROP PROCEDURE IF EXISTS MargenbrutoJ;
DELIMITER $$
CREATE PROCEDURE MargenbrutoJ(IN porcent int)
BEGIN
    /*SELECT IdProducto, precio as PrecioVenta, ROUND(precio /((100 - porcent)/100),2) AS PrecioFinal
    FROM compra;
    */
    SELECT IdProducto, precio as PrecioVenta, ROUND(precio * ( (100 + porcent) /100 ), 2) AS PrecioFinal
    FROM compra;
END $$
DELIMITER ;

CALL MargenbrutoJ(30);

-- 4. Crear un procedimiento que permita listar los productos vendidos desde fact_venta a partir de un "Tipo" que determine el usuario.

DROP PROCEDURE IF EXISTS listaCategoria;

DELIMITER $$
CREATE PROCEDURE listaCategoria(IN categoria VARCHAR (25))
BEGIN
	SELECT 	v.Fecha,
			v.Fecha_Entrega,
			v.IdCliente,
			v.IdCanal,
			v.IdSucursal,
			tp.TipoProducto,
			p.Producto,
			v.Precio,
			v.Cantidad
	FROM venta v join producto p
			On (v.IdProducto = p.idProducto
				And v.Outlier = 1)
		Join tipo_producto tp
			On (p.IdTipoProducto = tp.IdTipoProducto
				And TipoProducto collate utf8mb4_spanish_ci LIKE Concat('%', categoria, '%'));
                -- And TipoProducto = categoria);
END $$
DELIMITER ;

CALL listaCategoria('au');

-- 5. Crear un procedimiento que permita realizar la insercción de datos en la tabla fact_inicial (en realidad es fact_venta).

DROP TABLE IF EXISTS `fact_inicial`;
CREATE TABLE IF NOT EXISTS `fact_inicial` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCanal`				INTEGER, 
  `IdCliente`			INTEGER, 
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				DECIMAL(15,2),
  `Cantidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP PROCEDURE IF EXISTS cargarFact_inicial;

DELIMITER $$
CREATE PROCEDURE cargarFact_inicial()
BEGIN
	TRUNCATE table fact_inicial;

    INSERT INTO fact_inicial (IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad)
    SELECT	IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
    FROM 	venta
    WHERE  	Outlier = 1;
END $$
DELIMITER ;

CALL cargarFact_inicial();

show triggers;


SELECT 	c.Rango_Etario, 
		sum(v.Precio*v.Cantidad) 	AS Total_Ventas
FROM fact_venta v
	INNER JOIN dim_cliente c
		ON (v.IdCliente = c.IdCliente
			and c.Rango_Etario collate utf8mb4_spanish_ci = '2_De 31 a 40 años')
GROUP BY c.Rango_Etario;
    
DROP PROCEDURE ventasGrupoEtario; 

DELIMITER $$
CREATE PROCEDURE ventasGrupoEtario(IN grupo VARCHAR(25))
BEGIN
	SELECT 	c.Rango_Etario, 
			sum(v.Precio*v.Cantidad) 	AS Total_Ventas
	FROM fact_venta v
		INNER JOIN dim_cliente c
			ON (v.IdCliente = c.IdCliente
				and c.Rango_Etario collate utf8mb4_spanish_ci like Concat('%', grupo, '%'))
	GROUP BY c.Rango_Etario;
END $$
DELIMITER ;

SELECT DISTINCT Rango_Etario FROM dim_cliente;

CALL ventasGrupoEtario('31%40');

SET @grupo = '2_De 31 a 40 años';

SELECT *
FROM dim_cliente
WHERE Rango_Etario collate utf8mb4_spanish_ci = @grupo
LIMIT 10;