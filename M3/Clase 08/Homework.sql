USE henry_m3;	
-- Instrucción SQL N° 1

SELECT * FROM fact_inicial;
SELECT * FROM calendario;
DROP TABLE IF EXISTS fact_inicial;
CREATE TABLE IF NOT EXISTS fact_inicial (
	IdFecha					INT,
	Fecha					DATE,
	IdSucursal				INT,
    IdProducto				INT,
    IdProductoFecha			BIGINT,
    IdSucursalFecha			BIGINT,
    IdProductoSucursalFecha	BIGINT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha
 FROM gasto g JOIN calendario c
			  ON g.Fecha = c.fecha;

INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha NOT IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);
 /* La primera subquerry nos crea una lista
 con una variable v.IdSucursal * 100000000 + c.IdFecha 
 eliminando los outliers. Esta después se usa para filtrar nuestra querry, en donde queremos
 que la variable IdSucursalFecha no este incluida en la lista anterior, para que no haya colisión
 con ventas*/
 
 SELECT	v.IdSucursal * 100000000 + c.IdFecha 
FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
WHERE v.Outlier = 1;

SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha NOT IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

SELECT * FROM fact_inicial;
                                                    
-- Instrucción SQL N° 2

 /* Esta subquerry se comporta de manera similar a la anterior, solo que se considera
 el IdProducto en vez de IdSucursal*/

INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		co.Fecha,
		NULL AS IdSucursal, 
        co.IdProducto, 
        co.IdProducto * 100000000 + c.IdFecha AS  IdProductoFecha, 
        NULL IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	compra co JOIN calendario c
	ON (co.Fecha = c.fecha)
WHERE co.IdProducto * 100000000 + c.IdFecha NOT IN (SELECT	v.IdProducto * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

-- Instrucción SQL N° 3

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

CREATE VIEW kpi AS
SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

SELECT * FROM kpi;


SELECT Precio * Cantidad AS Total_Ventas, Fecha 
FROM fact_venta
WHERE Fecha = (	SELECT MAX(Fecha)
				FROM fact_venta );

SELECT Precio * Cantidad AS Total_Ventas, Fecha
FROM fact_venta
WHERE Fecha = (	SELECT MIN(Fecha)
				FROM fact_venta );


SELECT fact_venta.IdProducto, Producto, Precio * Cantidad AS Total_Ventas
FROM fact_venta
LEFT JOIN dim_producto
ON fact_venta.IdProducto = dim_produCto.IdProducto
WHERE Fecha = (	SELECT MAX(Fecha)
				FROM fact_venta )
GROUP BY fact_venta.IdProducto, Producto;

SELECT fact_venta.IdProducto, Producto, Precio * Cantidad AS Total_ventas
FROM fact_venta
LEFT JOIN dim_producto
ON fact_venta.IdProducto = dim_producto.IdProducto
WHERE Fecha = (	SELECT MIN(Fecha)
				FROM fact_venta )
GROUP BY fact_venta.IdProducto, Producto;

SELECT Fecha, SUM(Precio * Cantidad) AS Total_Ventas
FROM fact_venta
GROUP BY Fecha;

SELECT Fecha, Total_Ventas
FROM (	SELECT Fecha, SUM(Precio * Cantidad) AS Total_Ventas
		FROM fact_venta
		GROUP BY Fecha) AS ventas
GROUP BY Fecha
ORDER BY Total_Ventas DESC
LIMIT 1;
