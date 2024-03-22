USE AdventureWorksLT2022;

--DML (SELECT - INSERT - UPDATE - DELETE).

--Orden logico de procesamiento del SELECT:
--1. FROM: Trae las tablas.
--2. WHERE: Filtra las tablas.
--3. GROUP BY: Aplica los grupos.
--4. HAVING: Aplica el HAVING.
--5. SELECT: Aplica el SELECT.
--6. ORDER BY: Ordena las filas.

--Ejercicios Parte 1.

--1. Obtener todos los clientes de la compañia para enviarles felicitaciones por la llegada de fin de año, indique su ID, nombre y apellido, y correo electronico.

SELECT [CustomerID] ID, [FirstName] Nombre, [LastName] Apellido, [EmailAddress] Correo
FROM SalesLT.Customer;

--2. Obtener todos los clientes de la compañia Friendly Bike Shop.

SELECT *
FROM SalesLT.Customer
WHERE [CompanyName] = 'Friendly Bike Shop';

--3. Obtener todos los clientes de las compañias The Bike Shop, The Commissary, The Gear Store.

SELECT *
FROM SalesLT.Customer
WHERE [CompanyName] = 'Friendly Bike Shop' OR [CompanyName] = 'The Commissary' OR [CompanyName] = 'The Gear Store'
ORDER BY [CompanyName];

--4. Obtener los clientes con apellidos Benson, Brown y Miller.

--Con OR.

SELECT *
FROM SalesLT.Customer
WHERE [LastName] = 'Benson' OR [LastName] = 'Brown' OR [LastName] = 'Miller'
ORDER BY [LastName];

--Con IN.

SELECT *
FROM SalesLT.Customer
WHERE [LastName] IN ('Benson', 'Brown', 'Miller')
ORDER BY [LastName];

--5. Obtener una lista de precios de los productos y sus categorias.

--Sin JOIN.

SELECT SalesLT.Product.[ProductID] ID, SalesLT.Product.[Name] Producto, SalesLT.Product.[ListPrice] Precio, SalesLT.ProductCategory.[Name] Categoria
FROM SalesLT.Product, SalesLT.ProductCategory
WHERE SalesLT.Product.[ProductCategoryID] = SalesLT.ProductCategory.[ProductCategoryID]
ORDER BY SalesLT.Product.[ProductID];

--Con JOIN.

SELECT SalesLT.Product.[ProductID] ID, SalesLT.Product.[Name] Producto, SalesLT.Product.[ListPrice] Precio, SalesLT.ProductCategory.[Name] Categoria
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.[ProductCategoryID] = SalesLT.ProductCategory.[ProductCategoryID]
ORDER BY SalesLT.Product.[ProductID];

--6. El departamento de logistica desea localizar a los clientes con direccion informada en Calgary, Toronto, Montreal o Arlington.

SELECT SalesLT.Customer.[CustomerID] ID, SalesLT.Customer.[LastName] Cliente, SalesLT.Address.[City] Direccion
FROM SalesLT.Customer, SalesLT.Address, SalesLT.CustomerAddress
WHERE SalesLT.Customer.[CustomerID] = SalesLT.CustomerAddress.[CustomerID] AND SalesLT.Address.[AddressID] = SalesLT.CustomerAddress.[AddressID]
AND (SalesLT.Address.[City] = 'Calgary' OR SalesLT.Address.[City] = 'Toronto' OR SalesLT.Address.[City] = 'Montreal' OR SalesLT.Address.[City] = 'Arlington')
ORDER BY SalesLT.Address.[City];

--7. El depto. de ventas desea armar ofertas para todos los productos que correspondan con los modelos Mountain-100 y Classic Vest.

SELECT SalesLT.Product.[ProductID] IDProducto, SalesLT.Product.[Name] Producto, SalesLT.ProductModel.[Name] Modelo
FROM SalesLT.Product, SalesLT.ProductModel
WHERE SalesLT.Product.[ProductModelID] = SalesLT.ProductModel.[ProductModelID]
AND (SalesLT.ProductModel.[Name] = 'Mountain-100' OR SalesLT.ProductModel.[Name] = 'Classic Vest');

--8. Obtener la lista de todos los clientes ordenados por apellido.

SELECT [CustomerID] ID, [LastName] Apellido
FROM SalesLT.Customer
ORDER BY [LastName];

--9. Obtener la lista de todos los clientes ordenados por apellido (con su nombre correspondiente) usando alias en tablas y campos.

SELECT [CustomerID] ID, [LastName] Apellido, 'Nombre: ' + [FirstName] Nombre --El alias hace referencia a la asignacion de un nuevo nombre para la columna.
FROM SalesLT.Customer
ORDER BY [LastName];

--10. Los primeros 5 clientes ordenados por apellido.

SELECT TOP 5 [CustomerID] ID, [LastName] Apellido, [FirstName] Nombre
FROM SalesLT.Customer
ORDER BY [LastName];

--11. Los primeros 5 clientes ordenados por nombre.

SELECT TOP 5 [CustomerID] ID, [FirstName] Nombre, [LastName] Apellido
FROM SalesLT.Customer
ORDER BY [FirstName];

--12. Los primeros 20 clientes ordenados por apellido utilizando ASC.

SELECT TOP 20 [CustomerID] ID, [LastName] Apellido --TOP no es estandar, se puede utilizar sin ORDER BY.
FROM SalesLT.Customer
ORDER BY [LastName] ASC; --Si no se pone ASC no pasa nada.

--13. Los clientes ordenados por apellido (del 11 al 20).

SELECT [CustomerID] ID, [LastName] Apellido --OFFSET FETCH es estandar, no se puede utilizar sin ORDER BY.
FROM SalesLT.Customer
ORDER BY [LastName]
OFFSET 10 ROWS --ROWS = ROW
FETCH NEXT 10 ROWS ONLY; --NEXT = FIRST

--14. Un cliente ordenado por apellido, agregar mas en el caso de valores repetidos.

SELECT TOP 1 WITH TIES [CustomerID] ID, [FirstName] Nombre, [LastName] Apellido --WITH TIES sirve para ampliar el limite en el caso de valores repetidos dentro del campo de ordenamiento.
FROM SalesLT.Customer
ORDER BY [FirstName] ASC;

--15. Obtener el 50.5% de los clientes ordenados por apellido.

SELECT TOP 50.5 PERCENT [CustomerID] ID, [FirstName] Nombre, [LastName] Apellido --PERCENT sirve para obtener un porcentaje de filas.
FROM SalesLT.Customer
ORDER BY [FirstName] ASC;

--16. Los primeros 5 clientes ordenados por apellido de forma descendente.

SELECT TOP 5 [CustomerID] ID, [FirstName] Nombre, [LastName] Apellido
FROM SalesLT.Customer
ORDER BY [FirstName] DESC;

--17. Mostrar todos los nombres distintos.

SELECT DISTINCT [LastName]
FROM SalesLT.Customer;

--18. Productos comenzados a vender despues del 2006.

SELECT P.[ProductID] IDProducto, P.[Name] Nombre, P.[SellStartDate] Fecha
FROM SalesLT.Product P
WHERE P.[SellStartDate] >= '2006';

--19. Productos comenzados a vender despues del 2006 y antes de la fecha actual.

SELECT P.[ProductID] IDProducto, P.[Name] Nombre, P.[SellStartDate] Fecha
FROM SalesLT.Product P
WHERE P.[SellStartDate] >= '2006' AND P.[SellStartDate] <= GETDATE();

--20. Imprimir las facturas con el tiempo transcurrido desde se pedido hasta la fecha actual.

SELECT [SalesOrderID] ID, [OrderDate] Fecha, CAST(DATEDIFF(YEAR, [OrderDate], GETDATE()) AS VARCHAR(10)) + ' años' TiempoTrasncurrido
FROM SalesLT.SalesOrderHeader;

--21. Obtener los clientes con segundo nombre.

SELECT [CustomerID] IDCliente, [MiddleName] SegundoNombre
FROM SalesLT.Customer
WHERE [MiddleName] IS NOT NULL
ORDER BY IDCliente;

--22. Obtener todas las facturas con sus clientes.

SELECT O.[SalesOrderID] IDFactura, C.[CustomerID] IDCliente, C.[LastName] ApellidoCliente
FROM SalesLT.SalesOrderHeader O
LEFT OUTER JOIN SalesLT.Customer C
ON O.[CustomerID] = C.[CustomerID]

--23. Sumar al anterior todos los productos.

SELECT O.[SalesOrderID] IDFactura,
       L.[SalesOrderDetailID] IDLinea,
       P.[ProductID] IDProducto,
       P.[Name] NombreProducto,
       L.[OrderQty] Cantidad,
       C.[CustomerID] IDCliente,
       C.[LastName] ApellidoCliente
FROM SalesLT.SalesOrderHeader O
LEFT OUTER JOIN SalesLT.Customer C ON O.[CustomerID] = C.[CustomerID]
INNER JOIN SalesLT.SalesOrderDetail L ON L.[SalesOrderID] = O.[SalesOrderID]
INNER JOIN SalesLT.Product P ON L.[ProductID] = P.ProductID
ORDER BY IDFactura;

SELECT O.[SalesOrderID] IDFactura,
       COUNT(*) CantidadLineas,
	   SUM(L.[OrderQty]) CanitidadProductos,
       C.[CustomerID] IDCliente,
       C.[LastName] ApellidoCliente
FROM SalesLT.SalesOrderHeader O
LEFT OUTER JOIN SalesLT.Customer C ON O.[CustomerID] = C.[CustomerID]
INNER JOIN SalesLT.SalesOrderDetail L ON L.[SalesOrderID] = O.[SalesOrderID]
INNER JOIN SalesLT.Product P ON L.[ProductID] = P.ProductID
GROUP BY O.[SalesOrderID], C.[CustomerID], C.[LastName];

--24. Listar las categorias con las categorias de la que dependen.

SELECT [ProductCategoryID] ID, [ParentProductCategoryID] IDPadre
FROM SalesLT.ProductCategory
WHERE [ParentProductCategoryID] IS NOT NULL;

--25. Obtener todas las categorias con sus productos, ordanadas por categoria y luego por producto.

SELECT C.[ProductCategoryID] IDCategoria, C.[Name] Nombre, P.[Name] Producto
FROM SalesLT.ProductCategory C
LEFT JOIN SalesLT.Product P
ON C.[ProductCategoryID] = P.[ProductCategoryID]
ORDER BY IDCategoria;

SELECT C.[ProductCategoryID] IDCategoria, C.[Name] Nombre, P.[ProductID] IDProducto, P.[Name] Nombre
FROM SalesLT.ProductCategory C
LEFT JOIN SalesLT.Product P
ON C.[ProductCategoryID] = P.[ProductCategoryID]
ORDER BY IDProducto;

--Ejercicios Parte 2.

--1. Obtener la cantidad de facturas existentes.

SELECT COUNT(*) CantidadFacturas
FROM SalesLT.SalesOrderHeader;

--2. Obtener el total facturado.

SELECT SUM([TotalDue]) TotalFacturado
FROM SalesLT.SalesOrderHeader;

--3. Obtener la cantidad de productos bajo la categoria "Road Bikes".

SELECT COUNT(*) ProductosRoadBikes
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.[ProductCategoryID] = SalesLT.ProductCategory.[ProductCategoryID] AND SalesLT.ProductCategory.[Name] = 'Road Bikes';

--4. Contar los productos existentes por categoria.

SELECT SalesLT.ProductCategory.[ProductCategoryID] AS IDCategoria, SalesLT.ProductCategory.[Name] Nombre, COUNT(*) AS 'Cantidad de Productos' --El COUNT cuenta por cada agrupacion.
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.[ProductCategoryID] = SalesLT.ProductCategory.[ProductCategoryID]
GROUP BY SalesLT.ProductCategory.[ProductCategoryID], SalesLT.ProductCategory.[Name]
ORDER BY SalesLT.ProductCategory.[ProductCategoryID];

SELECT SalesLT.ProductCategory.[ProductCategoryID] AS IDCategoria, SalesLT.ProductCategory.[Name] Nombre, COUNT(*) AS 'Cantidad de Productos'
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.[ProductCategoryID] = SalesLT.ProductCategory.[ProductCategoryID]
GROUP BY SalesLT.ProductCategory.[ProductCategoryID], SalesLT.ProductCategory.[Name]
HAVING COUNT(*) = 1
ORDER BY SalesLT.ProductCategory.[ProductCategoryID];

SELECT C.[ProductCategoryID] IDCategoria, C.[Name] NombreCategoria, P.[Name] NombreProducto
FROM SalesLT.Product P
INNER JOIN SalesLT.ProductCategory C
ON P.[ProductCategoryID] = C.[ProductCategoryID]
WHERE EXISTS
(
SELECT C.[ProductCategoryID]
FROM SalesLT.Product
WHERE SalesLT.Product.[ProductCategoryID] = C.[ProductCategoryID]
GROUP BY SalesLT.Product.[ProductCategoryID]
HAVING COUNT(*) > 1
);

--5. Totalizar las ventas por producto.

SELECT [ProductID] ID, SUM([LineTotal]) TotalVendido
FROM SalesLT.SalesOrderDetail
GROUP BY [ProductID];

--6. Igual al anterior pero agregarle el nombre del producto.

--Sin JOIN.

SELECT SalesLT.Product.[ProductID] IDProducto, SalesLT.Product.[Name] Producto, SUM(SalesLT.SalesOrderDetail.[LineTotal]) TotalVendido
FROM SalesLT.Product, SalesLT.SalesOrderDetail
WHERE SalesLT.Product.[ProductID] = SalesLT.SalesOrderDetail.[ProductID]
GROUP BY SalesLT.Product.[ProductID], SalesLT.Product.[Name]
ORDER BY SalesLT.Product.[ProductID];

--Con JOIN.

SELECT SalesLT.Product.[ProductID] IDProducto, SalesLT.Product.[Name] Producto, SUM(SalesLT.SalesOrderDetail.[LineTotal]) TotalVendido
FROM SalesLT.Product
INNER JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.[ProductID] = SalesLT.SalesOrderDetail.[ProductID]
GROUP BY SalesLT.Product.[ProductID], SalesLT.Product.[Name]
ORDER BY TotalVendido;

--7. Filtrar aquellos productos que hayan vendido mas de $20000 en total.

SELECT SalesLT.Product.[ProductID] IDProducto, SalesLT.Product.[Name] Producto, SUM(SalesLT.SalesOrderDetail.[LineTotal]) TotalVendido
FROM SalesLT.Product
INNER JOIN SalesLT.SalesOrderDetail
ON SalesLT.Product.[ProductID] = SalesLT.SalesOrderDetail.[ProductID]
GROUP BY SalesLT.Product.[ProductID], SalesLT.Product.[Name]
HAVING SUM(SalesLT.SalesOrderDetail.[LineTotal]) > 20000
ORDER BY TotalVendido;

--8. La empresa desea realizar descuentos de fin de año sobre los productos, en particular quiere rebajar un 10% todos los productos que comiencen con HL. Cuanto le representa a la empresa el total descontado sobre las ventas existentes.

SELECT [ProductID] IDProducto, [Name] Producto, [ListPrice] Precio, [ListPrice] - ([ListPrice] * 0.10) 'Precio con Descuento'
FROM SalesLT.Product
WHERE [Name] LIKE 'HL%';

SELECT P.[ProductID] IDProducto, P.[Name] Producto, SUM(O.[LineTotal]) 'Ventas Totales', SUM(O.[LineTotal] - (P.[ListPrice] * 0.10)) 'Ventas Totales con Descuento'
FROM SalesLT.Product P
INNER JOIN SalesLT.SalesOrderDetail O
ON P.[Name] LIKE 'HL%' AND P.[ProductID] = O.[ProductID]
GROUP BY P.[ProductID], P.[Name]
ORDER BY 'Ventas Totales';

--9. Obtener los productos que valen $1000 o mas y pertenecen a una categoria con mas de 10 productos.

SELECT C.[ProductCategoryID] IDCategoria, C.[Name] Categoria, COUNT(*) CantidadProductos
FROM SalesLT.Product P
INNER JOIN SalesLT.ProductCategory C
ON P.[ProductCategoryID] = C.[ProductCategoryID]
GROUP BY C.[ProductCategoryID], C.[Name]
HAVING COUNT(*) > 10
ORDER BY CantidadProductos;

--10. Obtener los productos que nunca se vendieron (plantearlo con una clausula EXISTS).

--Sin EXISTS.
SELECT P.[ProductID] ID, D.[SalesOrderID] IDVenta
FROM SalesLT.Product P
LEFT OUTER JOIN SalesLT.SalesOrderDetail D
ON P.[ProductID] = D.[ProductID]
WHERE D.[SalesOrderID] IS NULL
ORDER BY ID;

--Con EXISTS.
SELECT P.[ProductID] ID
FROM SalesLT.Product P
WHERE NOT EXISTS
(
SELECT D.[ProductID]
FROM SalesLT.SalesOrderDetail D
WHERE D.[ProductID] = P.[ProductID]
) --Correlacionada Escalar.
ORDER BY ID;

--11. Filtar los productos que contengan 'Frame' en el nombre.

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] LIKE '%Frame%';

--12. Mantener lo anterior y agregar que el numero de producto contenga 'M' despues del tercer caracter.

--Sin especificar el case sencitive.

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] LIKE '%Frame%' AND [ProductNumber] LIKE '___M%';

--Especificando el case sencitive y modificando 'Frame' por 'frame'.

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] COLLATE SQL_Latin1_General_CP1_CS_AS LIKE '%frame%' AND [ProductNumber] LIKE '___M%';

--Especificando el case insencitive y modificando 'Frame' por 'frame'.

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] COLLATE SQL_Latin1_General_CP1_CI_AS LIKE '%frame%' AND [ProductNumber] LIKE '___M%';

--13. Mantener lo anterior y agregar que el numero de producto no contenga 'M63' despues del tercer caracter.

--Con NOT LIKE.

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] LIKE '%Frame%' AND [ProductNumber] LIKE '___M%' AND [ProductNumber] NOT LIKE '___M63%';

--Con [^].

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [Name] LIKE '%Frame%' AND [ProductNumber] LIKE '___M%' AND [ProductNumber] LIKE '____[^6][^3]%';

--14. Filtrar aquellos numeros de producto que terminen con un guion y dos numeros (0-9).

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [ProductNumber] LIKE '%-[0-9][0, 1, 2, 3, 4, 5, 6, 7, 8, 9]';

--15. Filtrar aquellos numeros de producto que terminen con un guion, un numero (0-9) y un numero (distinto de 0-7).

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [ProductNumber] LIKE '%-[0-9][^0-7]';

--16. Filtrar aquellos numeros de producto que terminen con un guion, un numero (0-9) y un numero(8).

SELECT [Name] Producto, [ProductNumber]
FROM SalesLT.Product
WHERE [ProductNumber] LIKE '%-[0-9][8]';

--17. Obtener los ID de las categorias padres distintas de 1.

SELECT [ProductCategoryID] ID, [ParentProductCategoryID] IDPadre
FROM SalesLT.ProductCategory
WHERE [ParentProductCategoryID] != 1 OR [ParentProductCategoryID] IS NULL; --El IS sirve para hacer operaciones de comparacion con los NULL. Existe una logica Ternaria para un bool (FALSE, TRUE o UNKNOWN) o bit (0, 1 o NULL).

--18. Obtener los apellidos ordenados por grupo, mas su respectiva cantidad.

SELECT [LastName] Apellido, COUNT(*) Cantidad --HAVING sirve para aplicar una condicion a los grupos.
FROM SalesLT.Customer
GROUP BY [LastName]
HAVING COUNT(*) > 4
ORDER BY Cantidad DESC;

--19. Obtener los apellidos ordenados por grupo, mas su respectiva cantidad (sin el apellido Miller).

SELECT [LastName] Apellido, COUNT(*) Cantidad --HAVING sirve para aplicar una condicion a los grupos.
FROM SalesLT.Customer
WHERE [LastName] <> 'Miller'
GROUP BY [LastName]
HAVING COUNT(*) > 4
ORDER BY Cantidad DESC;

--20. Obtener las ventas realizadas de los productos que se comenzaron a vender a partir del 2006.

SELECT O.[SalesOrderID] IDVenta, P.[Name] NombreProducto, YEAR(P.[SellStartDate]) FechaInicio
FROM SalesLT.SalesOrderHeader O
LEFT JOIN SalesLT.SalesOrderDetail L
ON O.[SalesOrderID] = L.[SalesOrderID]
INNER JOIN SalesLT.Product P
ON L.[ProductID] = P.[ProductID]
WHERE P.[SellStartDate] >= '2006'
ORDER BY IDVenta;

--21. Obtener el porcentaje de una linea respecto a la orden total.

SELECT [SalesOrderID] OrdenID, [ProductID] ProductoID, [LineTotal] TolalLinea,
CAST ( 100 * [LineTotal] /
(
SELECT SUM(B.LineTotal)
FROM SalesLT.SalesOrderDetail B
WHERE B.SalesOrderID = A.SalesOrderID
) --Correlacionada Escalar.
AS NUMERIC (5, 2) ) Porcentaje, --NUMERIC (5, 2): En total puede tener 5 numeros, 2 dps de la coma y 3 antes (0,00 a 999,99).
(
SELECT SUM(B.LineTotal)
FROM SalesLT.SalesOrderDetail B
WHERE B.SalesOrderID = A.SalesOrderID
) TotalOrden --Correlacionada Escalar.
FROM SalesLT.SalesOrderDetail A
ORDER BY OrdenID;

--Funciones de tipo Escalar (Matematicas) incluidas en SQL.

SELECT ABS(-3); --Valor absoluto.

SELECT POWER(2, 3); --Potencia.

SELECT SQRT(4); --Raiz cuadrada.

SELECT COS(0) '0g', COS(PI() / 2) '90g', COS(PI()) '180g', COS(PI() * 1.5) '270g'; --Coceno.

SELECT ROUND(COS(PI() / 2), 0) '90g', ROUND(COS(PI() * 1.5), 0) '270g'; --Redondeo.

SELECT RAND(); --Numero random de 0 a 1.

SELECT RAND(100), RAND(); --Numero random con semilla, es fijo.

SELECT ROUND(RAND() * 100, 0); --Numero aleatorio entre 0 y 100. Se redondea el resultado.

SELECT ROUND(RAND() * 50 + 50, 0); --Numero aleatorio entre 50 y 100. Se redondea el resultado.

SELECT CAST(RAND() * 50 + 50 AS INT); --Numero aleatorio entre 50 y 99. Se trunca el resultado.

SELECT ROUND(99.4, 0); --No tira error.

SELECT ROUND(99.5, 0); --Tira error.

SELECT ROUND(CAST(99.5 AS FLOAT), 0); --No tira error.

SELECT CEILING(99.5); --Redondea hacia arriba.

--Funciones de tipo Escalar (de Cadena) incluidas en SQL.

SELECT 'Hola ' + 'Mundo' + NULL; --Arroja NULL.

SELECT CONCAT('Hola ', 'Mundo', NULL); --Suma la parte no NULL.

SELECT SUBSTRING('abcde', 1, 4); --El 1er elemento es 1. Devuelve del caracter 1 al 4.

SELECT RIGHT('abcde', 3), LEFT('abcde', 3); --Toma caracteres especificos de uno de los lados del string.

SELECT LEN('abcde'), LEN('abcde '); --Devuelve la longitud del string, no cuenta los espacios.

SELECT DATALENGTH('abcde '), DATALENGTH('abcde'), DATALENGTH(N'abcde'); --Devuelve la longitud del string en bytes, toma en cuenta los espacios. La N en el ultimo punto representa el almacenamiento de un string unicode por lo que utiliza dos bytes por caracter.

SELECT CHARINDEX('M', 'Hola Mundo'); --Devuelve el elemento en el cual se da la 1er ocurrencia. El 1er elemento es 1.

SELECT PATINDEX('%[0-9]%', 'PIes3.1416'); --Devuelve el elemento en el cual se da la 1er ocurrencia. El 1er elemento es 1.

SELECT REPLACE('1-a 2-b', '-', '*'); --Reemplaza los valores '-' por '*'.

SELECT LOWER('HOLAMUNDO'); --Pone en minusculas al string.

SELECT RTRIM(LTRIM(' abc ')); --Saca los espacios en blanco de los extremos.

SELECT FORMAT(123, '00000'); --Cambia el formato.

--Funciones de tipo Escalar (de Fecha) incluidas en SQL.

SELECT GETDATE() FechaActual; --Fecha actual.

SELECT DATEPART(MONTH, GETDATE()); --Obtiene el YEAR, MONTH o DAY de una fecha.

SELECT MONTH(GETDATE()); --Obtiene el YEAR, MONTH o DAY de una fecha.

SELECT EOMONTH(GETDATE()); --Obtiene la ultima fecha del mes.

SELECT ISDATE('20231121 20:00:00'); --Valida una fecha.

SELECT DATENAME(MONTH, GETDATE()); --Obtiene el nombre del mes.

SELECT CAST(GETDATE() AS DATE); --Obtiene solo la fecha.

SELECT CAST(GETDATE() AS TIME); --Obtiene solo el tiempo.

SELECT DATEADD(DAY, 10, GETDATE()); --Suma 10 dias a la fecha acual.

SELECT DATEDIFF(DAY, GETDATE(), '20231119'); --Resta dos fechas, se obtiene un periodo.

--Funciones de tipo Escalar (de Conversion) incluidas en SQL.

SELECT CONVERT(VARCHAR(50), GETDATE(), 103); --Convierte la fecha en un string con un formato especifico (103).

--Tipos de JOIN.

--CROSS JOIN.

SELECT *
FROM SalesLT.Customer C
CROSS JOIN SalesLT.SalesOrderHeader D
ORDER BY D.[SalesOrderID];

--INNER JOIN (THETA JOIN (EQUIJOIN)): Trae las filas en las cuales coincide la condicion de busqueda, se realiza mediante un operador de igualdad (=).

SELECT *
FROM SalesLT.Customer C
INNER JOIN SalesLT.SalesOrderHeader D
ON C.[CustomerID] = D.[CustomerID]
ORDER BY D.[SalesOrderID];

--OUTER JOIN (LEFT).

SELECT *
FROM SalesLT.Customer C
LEFT OUTER JOIN SalesLT.SalesOrderHeader D
ON C.[CustomerID] = D.[CustomerID]
ORDER BY D.[SalesOrderID];

--OUTER JOIN (RIGHT).

SELECT *
FROM SalesLT.Customer C
RIGHT OUTER JOIN SalesLT.SalesOrderHeader D
ON C.[CustomerID] = D.[CustomerID]
ORDER BY C.[CustomerID];

SELECT [CustomerID]
FROM SalesLT.SalesOrderHeader; --Todas las ordenes tienen un cliente.

--OUTER JOIN (FULL).

SELECT *
FROM SalesLT.Customer C
FULL OUTER JOIN SalesLT.SalesOrderHeader D
ON C.[CustomerID] = D.[CustomerID]
ORDER BY D.[SalesOrderID];

--Funciones de Agregacion incluidas en SQL.

SELECT * FROM SalesLT.Product;

SELECT COUNT(*), AVG(ListPrice) --Cuenta la cantidad de productos y saca el promedio del precio.
FROM SalesLT.Product;

SELECT COUNT(*), MAX(ProductID) --Cuenta la cantidad de productos y obtiene el ID mayor.
FROM SalesLT.Product;

--CASE opcion 1.

SELECT [ProductID],
CASE [ProductID]
WHEN 
(
SELECT TOP 1 [ProductID]
FROM SalesLT.Product
ORDER BY [ProductID]
) --Autocontenida Escalar.
THEN 'Primer Producto'
WHEN 
(
SELECT TOP 1 [ProductID]
FROM SalesLT.Product
ORDER BY [ProductID] DESC
) --Autocontenida Escalar.
THEN 'Ultimo Producto'
ELSE 'Producto Intermedio'
END OrdenProducto
FROM SalesLT.Product
ORDER BY [ProductID];

--CASE opcion 2.

SELECT [ID],
CASE
WHEN [IDVenta] IS NOT NULL THEN 'Tiene una venta'
ELSE 'No tiene una venta'
END TieneUnaVenta
FROM
(
SELECT P.[ProductID] ID, D.[SalesOrderID] IDVenta
FROM SalesLT.Product P
LEFT OUTER JOIN SalesLT.SalesOrderDetail D
ON P.[ProductID] = D.[ProductID]
) TablaResultante --Autocontenida Multivaluada Tabular.
ORDER BY [ID]; --695.

SELECT COUNT(*)
FROM SalesLT.SalesOrderDetail; --542.

SELECT P.[ProductID] ID, D.[SalesOrderID] IDVenta
FROM SalesLT.Product P
LEFT OUTER JOIN SalesLT.SalesOrderDetail D
ON P.[ProductID] = D.[ProductID]
WHERE D.[SalesOrderID] IS NULL; --153.

--ALL, SOME o ANY: Permite comparar (<, >, <=, >=, =, <>) un escalar con una lista.

--ALL: Se tiene que cumplir la condicion en todos los elementos de la lista. ¿Que pasa si se usa un igual?

--SOME o ANY (son iguales): Se tiene que cumplir la condicion en almenos un elemento de la lista. ¿Como asemejarlo a un IN?

--EXISTS: Devuelve verdadero si por lo menos hay una fila.