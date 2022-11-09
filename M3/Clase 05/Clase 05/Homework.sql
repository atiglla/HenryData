use henry_m3;

SELECT *
FROM fact_venta;
-- Creamos la tabla que auditará a los usuarios que realizan cambios
-- se podrían haber agregado más columnas, incluso una FK
DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` ( 
	`Fecha`				DATE,
	`Fecha_Entrega`		DATE,
  	`IdCanal` 			INTEGER, -- Se puede usar INT también, sin el paréntesis
  	`IdCliente` 		INTEGER,
  	`IdEmpleado` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `usuario` 			VARCHAR(20),
    `fechaModificacion` 	DATETIME
);


SELECT *
FROM fact_venta_auditoria;

-- Creamos el trigger que se ejecutara luego de cada cambio
DROP TRIGGER fact_venta_auditoria;
CREATE TRIGGER fact_venta_auditoria AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_auditoria (Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, usuario, fechaModificacion)
VALUES (NEW.Fecha, NEW.Fecha_Entrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, 
        NEW.IdProducto, CURRENT_USER,NOW());

SELECT CURRENT_USER,NOW();

truncate table fact_venta;
-- truncate table fact_venta_auditoria;

SELECT *
FROM fact_venta;

insert into fact_venta (IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, 
                        IdEmpleado, IdProducto, Precio, Cantidad)
select IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
from venta;

select count(*) from fact_venta; -- contar los registros de la tabla fact_venta
select count(*) from fact_venta_auditoria;

SELECT *
FROM fact_venta_auditoria;

-- Creamos la tabla que llevara una cuenta de los registros.
DROP TABLE IF EXISTS `fact_venta_registros`;
CREATE TABLE IF NOT EXISTS `fact_venta_registros` (
  	id 	INT NOT NULL AUTO_INCREMENT,
	cantidadRegistros INT,
	usuario VARCHAR (20),
	fecha DATETIME,
	PRIMARY KEY (id)
);


-- Creamos el trigger que se ejecutara luego de cada cambio
DROP TRIGGER fact_venta_registros;
CREATE TRIGGER fact_venta_registros
AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_registros (cantidadRegistros,usuario, fecha) 
VALUES ((SELECT COUNT(*) FROM fact_venta),CURRENT_USER,NOW());

-- Creamos una tabla donde podremos almacenar la cantidad de registros por día
DROP TABLE IF EXISTS registros_tablas;
CREATE TABLE registros_tablas (
id INT NOT NULL AUTO_INCREMENT,
tabla VARCHAR(30),
fecha DATETIME,
cantidadRegistros INT,
PRIMARY KEY (id)
);

-- Esta instrucción nos permite cargar la tabla anterior y saber cual es la cantidad de registros por día.
INSERT INTO registros_tablas (tabla, fecha, cantidadRegistros)
SELECT 'venta', Now(), COUNT(*) FROM venta;
INSERT INTO registros_tablas (tabla, fecha, cantidadRegistros)
SELECT 'gasto', Now(), COUNT(*) FROM gasto;
INSERT INTO registros_tablas (tabla, fecha, cantidadRegistros)
SELECT 'compra', Now(), COUNT(*) FROM compra;

SELECT * FROM registros_tablas;
show triggers;

SELECT DATE('2011-01-01 00:00:10');

-- Creamos una tabla para auditar cambios
DROP TABLE IF EXISTS `fact_venta_cambios`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambios` (
  	`Fecha` 			DATE,
  	`IdCliente` 		INTEGER,
    -- IdCliente1          INTEGER,
	-- IdProducto1			INTEGER,
  	`IdProducto` 		INTEGER,
    `Precio` 			DECIMAL(15,3),
    `Cantidad` 			INTEGER
);

-- 6. Creamos el trigger que carga nuevos registros
DROP TRIGGER fact_venta_cambios ;
CREATE TRIGGER fact_venta_cambios  AFTER UPDATE ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_cambios (Fecha, IdCliente, IdProducto, Precio, Cantidad)
VALUES (OLD.Fecha,OLD.IdCliente, OLD.IdProducto, OLD.Precio, OLD.Cantidad);

SELECT * FROM fact_venta_cambios;
select * from fact_venta where IdVenta = 3;
update fact_venta set Precio = 1050 where IdVenta = 3;




-- Creamos el trigger que carga cambios en los registros
DROP TRIGGER auditoria_actualizacion;
CREATE TRIGGER auditoria_actualizacion AFTER UPDATE ON fact_venta
FOR EACH ROW
UPDATE fact_venta_cambios
SET 
IdCliente = OLD.IdCliente, 
IdProducto = OLD.IdProducto,
IdCliente1 = NEW.IdCliente, -- se crean dos columnas para mantener
IdProducto1 = NEW.IdProducto
WHERE Fecha = OLD.Fecha;

update fact_venta set Precio = 450 where IdVenta = 3;

SELECT * FROM fact_venta_cambios;
