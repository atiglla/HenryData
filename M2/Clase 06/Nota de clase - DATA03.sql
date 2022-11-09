CREATE DATABASE henry;

USE henry;

CREATE TABLE alumno (
	cedulaIdentidad INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fechaInicio DATE,
    PRIMARY KEY(cedulaIdentidad)
);


CREATE TABLE alumnos (
	cedulaIdentidad INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    fechaInicio DATE,
    PRIMARY KEY(cedulaIdentidad)
);