--CREATE DATABASE Farmacia;

USE Farmacia;

CREATE TABLE Presentacion (
  IDPresentacion INT IDENTITY(1,1) NOT NULL,
  Tamaño FLOAT,
  Material VARCHAR(50),
  PRIMARY KEY (IDPresentacion)
);

CREATE TABLE Tipo (
  IDTipo INT IDENTITY(1,1) NOT NULL,
  Nombre VARCHAR(50),
  PRIMARY KEY (IDTipo)
);

CREATE TABLE Producto (
  IDProducto INT IDENTITY(1,1) NOT NULL,
  Descripcion VARCHAR(50),
  PrecioCosto FLOAT,
  Marca VARCHAR(50),
  FK_IDTipo INT,
  PRIMARY KEY (IDProducto),
  FOREIGN KEY (FK_IDTipo) REFERENCES Tipo (IDTipo)
);

CREATE TABLE Aparece (
  FK_IDPresentacion INT NOT NULL,
  FK_IDProducto INT NOT NULL,
  PRIMARY KEY (FK_IDPresentacion, FK_IDProducto),
  FOREIGN KEY (FK_IDPresentacion) REFERENCES Presentacion (IDPresentacion),
  FOREIGN KEY (FK_IDProducto) REFERENCES Producto (IDProducto)
);

CREATE TABLE Cliente (
  Nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (Nombre)
);

CREATE TABLE Domicilios (
  Domicilio VARCHAR(50) NOT NULL,
  FK_NombreCliente VARCHAR(50) NOT NULL,
  PRIMARY KEY (Domicilio, FK_NombreCliente),
  FOREIGN KEY (FK_NombreCliente) REFERENCES Cliente (Nombre)
);

CREATE TABLE Telefonos (
  Telefono VARCHAR(50) NOT NULL,
  FK_NombreCliente VARCHAR(50) NOT NULL,
  PRIMARY KEY (Telefono, FK_NombreCliente),
  FOREIGN KEY (FK_NombreCliente) REFERENCES Cliente (Nombre)
);

CREATE TABLE Comprobante (
  IDComprobante INT IDENTITY(1,1) NOT NULL,
  DomicilioEntrega VARCHAR(50),
  FormaPago VARCHAR(50),
  FechaRealizacion DATETIME2,
  FK_NombreCliente VARCHAR(50),
  PRIMARY KEY (IDComprobante),
  FOREIGN KEY (FK_NombreCliente) REFERENCES Cliente (Nombre),
);

CREATE TABLE LineaComprobante (
  IDLinea INT IDENTITY(1,1) NOT NULL,
  FK_IDComprobante INT NOT NULL,
  CantidadSolicitada INT,
  PRIMARY KEY (IDLinea, FK_IDComprobante),
  FOREIGN KEY (FK_IDComprobante) REFERENCES Comprobante (IDComprobante),
);

CREATE TABLE Registra (
  FK_IDProducto INT NOT NULL,
  FK_IDLinea INT NOT NULL,
  FK_IDComprobante INT NOT NULL,
  PRIMARY KEY (FK_IDProducto, FK_IDLinea, FK_IDComprobante),
  FOREIGN KEY (FK_IDProducto) REFERENCES Producto (IDProducto),
  FOREIGN KEY (FK_IDLinea, FK_IDComprobante) REFERENCES LineaComprobante (IDLinea, FK_IDComprobante)
);

CREATE TABLE Sucursal (
  IDSucursal INT IDENTITY(1,1) NOT NULL,
  Nombre VARCHAR(50),
  PRIMARY KEY (IDSucursal)
);

CREATE TABLE Comercializa (
  FK_IDProducto INT NOT NULL,
  FK_IDSucursal INT NOT NULL,
  PRIMARY KEY (FK_IDProducto, FK_IDSucursal),
  FOREIGN KEY (FK_IDProducto) REFERENCES Producto (IDProducto),
  FOREIGN KEY (FK_IDSucursal) REFERENCES Sucursal (IDSucursal)
);

CREATE TABLE Vendedor (
  Legajo INT IDENTITY(1,1) NOT NULL,
  Nombre VARCHAR(50),
  Fechaingreso DATETIME2,
  TurnoManiana BIT,
  TurnoTarde BIT,
  PRIMARY KEY (Legajo),
);

CREATE TABLE Trabaja (
  FK_LegajoVendedor INT NOT NULL,
  FK_IDSucursal INT NOT NULL,
  HorariEoEntrada TIME,
  HorarrioSalida TIME,
  PRIMARY KEY (FK_LegajoVendedor, FK_IDSucursal),
  FOREIGN KEY (FK_LegajoVendedor) REFERENCES Vendedor (Legajo),
  FOREIGN KEY (FK_IDSucursal) REFERENCES Sucursal (IDSucursal)
);