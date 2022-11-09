CREATE DATABASE henry;

USE henry;

CREATE TABLE carrera (
	idCarrera INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR (20) NOT NULL,
	PRIMARY KEY (idCarrera)
);

SELECT *
FROM carrera;

/*Esto es un comentario
multilinea*/
-- Esto no

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT ,
	cedulaIdentidad VARCHAR(25) NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido VARCHAR (45) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIncorporacion DATE,
	PRIMARY KEY (idInstructor)
);

CREATE TABLE cohorte (
	idCohorte INT NOT NULL AUTO_INCREMENT,
	codigo VARCHAR (45) NOT NULL,
	idCarrera INT NOT NULL,
    idInstructor INT,
	fechaInicio DATE,
	fechaFinalizacion DATE,
	PRIMARY KEY (idCohorte),
	FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera),
	FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor)  
);

CREATE TABLE alumno (
	idAlumno INT NOT NULL AUTO_INCREMENT ,
	cedulaIdentidad VARCHAR(25) NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido VARCHAR (45) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIngreso DATE,
	idCohorte INT,
	PRIMARY KEY (idAlumno),
	FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte) 
);

SELECT * 
FROM alumno;