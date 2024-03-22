--USE master; --Se utilza master para crear una nueva BD.

--DDL (CREATE - ALTER - DROP).

--DROP DATABASE IF EXISTS EjemploDB; --Eliminar una DB.

--IF DB_ID('EjemploDB') IS NOT NULL --Forma alternativa para eliminar una BD, es compatible con todas las versiones.
--BEGIN
--  DROP DATABASE EjemploDB
--END;

--CREATE DATABASE EjemploDB; --Crear una DB.

USE EjemploDB;

--CREATE TABLE Alumno --Manejo de tiempo, DATETIME o DATETIME2 (fecha completa), DATE (solo fecha) y TIME (solo hora).
--(
--IDAlumno INT PRIMARY KEY IDENTITY (1,1) NOT NULL, --IDENTITY (comienza en 1, e incrementa de a uno).
--Nombre VARCHAR(30) NOT NULL
--);

--DROP TABLE IF EXISTS Alumno; --Eliminar una tabla.

--ALTER TABLE Alumno --Agregar un atributo a la tabla.
--ADD
--IDTutor INT;

--ALTER TABLE Alumno --Agregar una restriccion.
--ADD CONSTRAINT FK_IDTutor
--FOREIGN KEY (IDTutor) REFERENCES Alumno(IDAlumno);

--ALTER TABLE Alumno --Eliminar una restriccion.
--DROP CONSTRAINT FK_IDTutor;

--ALTER TABLE Alumno --Eliminar un atributo.
--DROP COLUMN IDTutor;

--ALTER TABLE Alumno --Modificar un atributo.
--ALTER COLUMN Nombre VARCHAR(50);