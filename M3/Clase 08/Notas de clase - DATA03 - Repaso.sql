DROP TABLE IF EXISTS pais;
CREATE TABLE IF NOT EXISTS `pais` (

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci; 

LOAD DATA INFILE 'ruta' 
INTO TABLE pais
FIELDS TERMINATED BY ',' ENCLOSED BY '""' ESCAPED BY '' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

USE henry_m3;

SELECT * FROM venta;

SELECT YEAR(Fecha) as Año
FROM venta
GROUP BY YEAR(Fecha);

SELECT COUNT(IdVenta), YEAR(Fecha) as Año
FROM venta
GROUP BY Año
HAVING Año = 2018;



SELECT SUM(Precio * Cantidad), YEAR(Fecha) as Año
FROM venta
GROUP BY Año
IS NOT HAVING Año = 2018;

SELECT SUM(Precio * Cantidad), YEAR(Fecha) as Año
FROM venta
GROUP BY Año
NOT HAVING Año = 2018;


SELECT SUM(Precio * Cantidad), YEAR(Fecha) as Año
FROM venta
GROUP BY Año
HAVING Año NOT IN (2018);

SELECT DISTINCT SUM(Precio * Cantidad), YEAR(Fecha) as Año
FROM venta
GROUP BY Año
HAVING Año != 2018;

SELECT SUM(a.Cantidad * a.Precio)
FROM (SELECT *, YEAR(Fecha) as Año
	FROM venta
	HAVING Año <> 2018) a;
    
SELECT * FROM venta; -- JOIN
SELECT * FROM producto;
SELECT * FROM tipo_producto;

SELECT *
FROM venta v
	 JOIN producto p
     ON (v.IdProducto = p.IdProducto and YEAR(Fecha) = 2020)
     JOIN tipo_producto tp
     ON (p.IdTipoProducto = tp.IdTipoProducto and tp.IdTipoProducto = 8);
     
SELECT *
FROM venta v
	 JOIN producto p
     ON (v.IdProducto = p.IdProducto and YEAR(Fecha) = 2020)
     JOIN tipo_producto tp
     ON (p.IdTipoProducto = tp.IdTipoProducto)
WHERE tp.TipoProducto LIKE '%inform%';

-- Contar la cantidad de clientes que compraron solo informatica en 2020

SELECT count(distinct IdCliente)
      FROM venta v
      JOIN producto p
	  ON (v.IdProducto = p.IdProducto and YEAR(Fecha) = 2020)
      JOIN tipo_producto tp
      ON (p.IdTipoProducto = tp.IdTipoProducto)
WHERE tp.IdTipoProducto = 8 AND v.IdCliente NOT IN 
											(SELECT distinct v.IdCliente
											       FROM venta v
												   JOIN producto p
												   ON (v.IdProducto = p.IdProducto and YEAR(Fecha) = 2020)
												  JOIN tipo_producto tp
												  ON (p.IdTipoProducto = tp.IdTipoProducto)
											 WHERE tp.IdTipoProducto <> 8 );
											
SELECT DISTINCT v.IdCliente
											       FROM venta v
												   JOIN producto p
												   ON (v.IdProducto = p.IdProducto and YEAR(Fecha) = 2020)
												  JOIN tipo_producto tp
												  ON (p.IdTipoProducto = tp.IdTipoProducto)
											 WHERE tp.IdTipoProducto <> 8 ;

SELECT * FROM venta JOIN producto ON venta.IdProducto = producto.IdProducto WHERE IdCliente =4;

-- Ganancia por tipo de producto (Venta - Compra)

SELECT *
FROM venta;

SELECT * FROM compra;

SELECT tp.TipoProducto, SUM(v.Precio*v.Cantidad - c.Precio * c.Cantidad) as Ganancia -- hay que agregarle una funci{on
FROM venta v
	 JOIN compra c
     ON v.IdProducto = c.IdProducto
     JOIN producto p
     on c.IdProducto = p.IdProducto
     JOIN tipo_producto tp
     ON p.IdTipoProducto = tp.IdTipoProducto
GROUP BY tp.TipoProducto;

