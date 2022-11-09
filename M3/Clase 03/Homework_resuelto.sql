use henry_m3;
/*Deteccion y corrección de Outliers sobre ventas*/
/*Motivos:
2-Outlier de Cantidad
3-Outlier de Precio
*/
SELECT v.*, o.promedio, o.maximo
FROM venta v JOIN (SELECT 	IdProducto,
							AVG(Precio) as promedio,
							AVG(Precio) + (3 * STDDEV(Precio)) AS maximo
					FROM venta
					GROUP BY IdProducto) o
			ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.maximo;
select * from venta where IdProducto = 42890;

SELECT v.*, o.promedio, o.maximo
FROM venta v JOIN (SELECT 	IdProducto,
							AVG(Cantidad) as promedio,
							AVG(Cantidad) + (3 * STDDEV(Cantidad)) AS maximo
					FROM venta
					GROUP BY IdProducto) o
			ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.maximo;
select * from venta where IdProducto = 42992;
select Cantidad, count(*) from venta group by Cantidad order by 1;

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 2
FROM venta v 
JOIN (SELECT IdProducto, AVG(Cantidad) As Promedio, STDDEV(Cantidad) as Desv FROM venta GROUP BY IdProducto) v2
	on (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > (v2.Promedio + (3 * v2.Desv)) OR v.Cantidad < 0;

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 3
FROM venta v 
JOIN (SELECT IdProducto, AVG(Precio) As Promedio, STDDEV(Precio) as Desv FROM venta GROUP BY IdProducto) v2
	on (v.IdProducto = v2.IdProducto)
WHERE v.Precio > (v2.Promedio + (3 * v2.Desv)) OR v.Precio < 0;

select * from aux_venta where Motivo = 2; -- outliers de cantidad
select * from aux_venta where Motivo = 3; -- outliers de precio

ALTER TABLE `venta` ADD `Outlier` TINYINT NOT NULL DEFAULT '1' AFTER `Cantidad`;

UPDATE venta v JOIN aux_venta a
	ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) co
JOIN
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) so
ON co.TipoProducto = so.TipoProducto;

-- KPI: Margen de Ganancia por producto superior a 20%
SELECT 	venta.Producto, 
		venta.SumaVentas, 
        venta.CantidadVentas, 
        venta.SumaVentasOutliers,
        compra.SumaCompras, 
        compra.CantidadCompras,
        ((venta.SumaVentas / compra.SumaCompras - 1) * 100) as margen
FROM
	(SELECT 	p.Producto,
			SUM(v.Precio * v.Cantidad * v.Outlier) 	as 	SumaVentas,
			SUM(v.Outlier) 							as	CantidadVentas,
			SUM(v.Precio * v.Cantidad) 				as 	SumaVentasOutliers,
			COUNT(*) 								as	CantidadVentasOutliers
	FROM venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2019)
	GROUP BY p.Producto) AS venta
JOIN
	(SELECT 	p.Producto,
			SUM(c.Precio * c.Cantidad) 				as SumaCompras,
			COUNT(*)								as CantidadCompras
	FROM compra c JOIN producto p
		ON (c.IdProducto = p.IdProducto
			AND YEAR(c.Fecha) = 2019)
	GROUP BY p.Producto) as compra
ON (venta.Producto = compra.Producto);

/*KPIs: Correccion Latitud y Longitud para evaluar la demora en la entrega teniendo den cuenta tambien la distancia*/
ALTER TABLE `localidad` ADD `Latitud` DOUBLE NOT NULL DEFAULT '0' AFTER `IdProvincia`, ADD `Longitud` DOUBLE NOT NULL DEFAULT '0' AFTER `Latitud`;

DROP TABLE IF EXISTS aux_cliente;
CREATE TABLE IF NOT EXISTS aux_cliente (
	IdCliente			INTEGER,
	Latitud				DOUBLE,
	Longitud			DOUBLE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO aux_cliente (IdCliente, Latitud, Longitud)
SELECT 	IdCliente, Latitud, Longitud
FROM cliente WHERE Latitud < -55;

UPDATE cliente c JOIN aux_cliente ac
	ON (c.IdCliente = ac.IdCliente)
SET c.Latitud = ac.Longitud, c.Longitud = ac.Latitud;

UPDATE `cliente` SET Latitud = Latitud * -1 WHERE Latitud > 0;
UPDATE `cliente` SET Longitud = Longitud * -1 WHERE Longitud > 0;

UPDATE localidad l 
	JOIN (	SELECT IdLocalidad, AVG(Latitud) AS Latitud
			FROM cliente WHERE Latitud <> 0 
			GROUP BY IdLocalidad) c
	ON (l.IdLocalidad = c.IdLocalidad)
SET l.Latitud = c.Latitud;

UPDATE localidad l 
	JOIN (	SELECT IdLocalidad, AVG(Longitud) AS Longitud
			FROM cliente WHERE Longitud <> 0 
			GROUP BY IdLocalidad) c
	ON (l.IdLocalidad = c.IdLocalidad)
SET l.Longitud = c.Longitud;

UPDATE cliente c JOIN localidad l
	ON (c.IdLocalidad = l.IdLocalidad)
SET c.Latitud = l.Latitud
WHERE c.Latitud = 0;

UPDATE cliente c JOIN localidad l
	ON (c.IdLocalidad = l.IdLocalidad)
SET c.Longitud = l.Longitud
WHERE c.Longitud = 0; 

SELECT v.*, SQRT( (c.Latitud - s.Latitud) * (c.Latitud - s.Latitud) + (c.Longitud - s.Longitud) * (c.Longitud - s.Longitud) ) * 111.1 as Dist
FROM venta v JOIN cliente c
		ON (v.IdCliente = c.IdCliente)
    JOIN sucursal s
    	ON (v.IdSucursal = s.IdSucursal);