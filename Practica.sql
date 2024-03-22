--MR Game of Thrones.

--Obtener la lista de casas que han participado en más de una guerra y mostrar la cantidad total
--de muertes que han causado en todas las guerras en las que participaron.

--SELECT Casa.[NombreCasa],
--       COUNT(*) CantidadGuerras,
--       SUM(Guerra.[CatidadMuertes]) TotalMuertesCausadas
--FROM Casa
--INNER JOIN Involucra ON Casa.[NombreCasa] = Involucra.[FK_NombreCasa]
--INNER JOIN Guerra ON Guerra.[Lugar] = Involucra.[FK_Lugar]
--AND Guerra.[Anio] = Involucra.[FK_Anio]
--GROUP BY Casa.[NombreCasa]
--HAVING COUNT(*) > 1
--ORDER BY [NombreCasa];

--Obtener los castillos en el continente 'Westeros' que tienen más de 100 sirvientes.

--SELECT Castillo.[NombreCastillo],
--       Castillo.[CantidadSirvientes]
--FROM Castillo
--INNER JOIN Hay ON Castillo.[NombreCastillo] = Hay.[FK_NombreCastillo]
--INNER JOIN Reino ON Reino.[NombreReino] = Hay.[FK_NombreReino]
--WHERE Castillo.[CantidadSirvientes] > 100
--  AND Reino.[Continente] = 'Westeros';

--Listar los personajes que tienen más de una profesión y mostrar sus nombres y las profesiones que desempeñan.

--SELECT Per.[NombrePer],
--       Per.[Nacimiento],
--       Pro.[NombrePro]
--FROM Personaje Per
--INNER JOIN Ejerce E ON Per.[NombrePer] = E.[FK_NombrePer]
--AND Per.[Nacimiento] = E.[FK_Nacimiento]
--INNER JOIN Profesion Pro ON Pro.[NombrePro] = E.[FK_NombrePro]
--WHERE EXISTS
--    (SELECT Per.[NombrePer],
--            Per.[Nacimiento]
--     FROM Ejerce
--     WHERE Per.[NombrePer] = Ejerce.[FK_NombrePer]
--       AND Per.[Nacimiento] = Ejerce.[FK_Nacimiento]
--     GROUP BY Ejerce.[FK_NombrePer],
--              Ejerce.[FK_Nacimiento]
--     HAVING COUNT(*) > 1);

--Obtener las especies que no tienen personajes y que son hostiles.

--SELECT Especie.[NombreCienti],
--       CASE Especie.[EsHostil]
--           WHEN 1 THEN 'Es Hostil'
--           ELSE 'No es Hostil'
--       END Hostilidad
--FROM Especie
--LEFT OUTER JOIN Personaje ON Especie.[NombreCienti] = Personaje.[FK_NombreCienti]
--WHERE Personaje.[FK_NombreCienti] IS NULL
--  AND Especie.[EsHostil] = 1
--ORDER BY Especie.[NombreCienti];

--Listar la casa que ha ganado más guerras y la cantidad total de muertes causadas en esas guerras.

--SELECT TOP 1 Casa.[NombreCasa],
--           COUNT(*) GuerrasGanadas,
--           SUM(Guerra.[CantidadMuertes]) CantidadTotalMuertes
--FROM Casa
--INNER JOIN Involucra ON Casa.[NombreCasa] = Involucra.[FK_NombreCasa]
--INNER JOIN Guerra ON Guerra.[Anio] = Involucra.[FK_Anio]
--AND Guerra.[Lugar] = Involucra.[FK_Lugar]
--WHERE Involucra.[CondicionVictoria] = 1
--GROUP BY Casa.[NombreCasa]
--ORDER BY GuerrasGanadas DESC;

--Obtener la lista de personajes que comparten el mismo nombre y año de nacimiento, mostrando sus nombres,
--años de nacimiento y las casas a las que pertenecen.

--SELECT P.[NombrePer],
--       P.[Nacimiento],
--       C.[NombreCasa]
--FROM Personaje P
--INNER JOIN Casa C ON P.[FK_NombreCasa] = C.[NombreCasa]
--WHERE EXISTS
--    (SELECT P.[NombrePer],
--            P.[Nacimiento]
--     FROM Personaje
--     WHERE P.[NombrePer] = Personaje.[NombrePer]
--       AND P.[Nacimiento] = Personaje.[Nacimiento]
--     GROUP BY Personaje.[NombrePer],
--              Personaje.[Nacimiento]
--     HAVING COUNT(*) > 1); --Teniendo en cuenta que la PK de Personaje se compone de Nombre y Nacimiento, esta consulta deberia arrojar 0 filas.

CREATE Table Casa (
NombreCasa VARCHAR(30) PRIMARY KEY NOT NULL
);

CREATE Table Personaje (
NombrePer VARCHAR(30) NOT NULL,
Nacimiento DATETIME2 NOT NULL,
FK_NombreCasa VARCHAR(30) NOT NULL,
FOREIGN KEY(FK_NombreCasa) REFERENCES Casa(NombreCasa)
);

INSERT INTO Casa (NombreCasa) VALUES
('Casa Stark'),
('Casa Lannister'),
('Casa Targaryen');

INSERT INTO Personaje (NombrePer, Nacimiento, FK_NombreCasa) VALUES
('Eddard Stark', '1980-01-01', 'Casa Stark'),
('Robb Stark', '1985-03-15', 'Casa Stark'),
('Robb Stark', '1985-03-15', 'Casa Stark'),
('Robb Stark', '1985-03-15', 'Casa Lannister'),
('Tyrion Lannister', '1980-02-10', 'Casa Lannister'),
('Cersei Lannister', '1982-07-22', 'Casa Lannister'),
('Daenerys Targaryen', '1986-11-30', 'Casa Targaryen'),
('Jon Snow', '1989-05-07', 'Casa Stark'),
('Jaime Lannister', '1980-02-10', 'Casa Lannister'),
('Jaime Lannister', '1980-02-10', 'Casa Lannister'),
('Sansa Stark', '1992-09-05', 'Casa Stark');

--MR Star Trek.

--Obtener todas las naves de un imperio en particular con sus respectivos capitanes y misiones.

DECLARE @IDImperioDesiado INT;

--SELECT Nave.[CodigoUnico] IDNave, Capitan.[NombreCap] Capitan, Mision.[NombreMision]
--FROM Nave
--INNER JOIN Capitan
--ON Nave.[FK_CodUnico] = Capitan.[CodUnico]
--INNER JOIN Mision
--ON Nave.[FK_CodGalactico] = Mision.[FK_CodGalactico] AND Nave.[FK_CodigoGalactico] = Mision.[FK_CododigoGalactico]
--WHERE Nave.[FK_CodGalactico] = @IDImperioDesiado;

--Obtener la lista de todas las maniobras disponibles y cuántas naves pueden realizar cada una.

--SELECT Maniobra.[NombreMan], COUNT(*) CantidadDeNaves
--FROM Maniobra
--INNER JOIN Realiza
--ON Maniobra.[NombreMan] = Realiza.[FK_NombreMan]
--INNER JOIN Nave
--ON Nave.[FK_CodGalactico] = Realiza.[FK_CodGalactico] AND Nave.[FK_CodigoGalactico] = Realiza.[FK_CododigoGalactico] AND Nave.[CodigoUnico] = Realiza.[FK_CodigoUnico]
--GROUP BY Maniobra.[NombreMan]
--ORDER BY Maniobra.[NombreMan];

--El imperio con la flota más grande en términos de número de naves.

--SELECT TOP 1 Imperio.[NombreImp], COUNT(*) CantidadDeNaves
--FROM Imperio
--INNER JOIN Flota
--ON Imperio.[CodGalactico] = Flota.[FK_CodGalactico]
--INNER JOIN Nave
--ON Nave.[FK_CodGalactico] = Flota.[FK_CodGalactico] AND Nave.[FK_CodigoGalactico] = Flota.[CododigoGalactico]
--GROUP BY Imperio.[NombreImp]
--ORDER BY CantidadDeNaves DESC;

--Obtener la población total de cada planeta y la cantidad de razas presentes en cada uno.

--SELECT Planeta.[NomCienti], Planeta.[PoblacionTotal], COUNT(*) CantidadDeRazas
--FROM Planeta
--INNER JOIN Divide
--ON Planeta.[NomCienti] = Divide.[FK_NomCienti]
--INNER JOIN Raza
--ON Raza.[NomRazaCienti] = Divide.[FK_NomRazaCienti]
--GROUP BY Planeta.[NomCienti], Planeta.[PoblacionTotal]
--ORDER BY Planeta.[NomCienti];

--Obtener todas las naves que pueden realizar una misión específica y el nombre de su imperio.

--SELECT Nave.[CodigoUnico] IDNave, Mision.[NombreMision], Imperio.[NombreImp] Imperio
--FROM Nave
--INNER JOIN Imperio
--ON Nave.[FK_CodGalactico] = Imperio.[CodGalactico]
--INNER JOIN Mision
--ON Nave.[FK_CodGalactico] = Mision.[FK_CodGalactico] AND Nave.[FK_CodigoGalactico] = Mision.[FK_CododigoGalactico] --Trae unicamenta las filas que coinciden.
--ORDER BY Imperio;

--Los capitanes que no tienen una nave asignada y los imperios a los que pertenecen.

--SELECT Capitan.[NombreCap], Imperio.[NombreImp]
--FROM Capitan
--LEFT JOIN Nave
--ON Nave.[FK_CodUnico] = Capitan.[CodUnico]
--INNER JOIN Imperio
--ON Capitan.[FK_CodGalactico] = Imperio.[CodGalactico]
--WHERE Nave.[CodigoUnico] IS NULL
--ORDER BY Capitan.[NombreCap];

--MR Policia.

--Listar todos los policías junto con la función que cumplen.

--SELECT Policia.[NombrePo], Funcion.[NombreFun]
--FROM Policia
--INNER JOIN Cumple
--ON Policia.[DNI] = Cumple.[FK_DNI]
--INNER JOIN Funcion
--ON Funcion.[NombreFun] = Cumple.[FK_NombreFun];

--Cuantas armas hay en la comisaria.

--SELECT COUNT(*) CantidadArmas
--FROM Arma;

--Cuantos delincuentes hay por calabozo.

--SELECT COUNT(*) DelincuentesPorCalabozo
--FROM Calabozo
--INNER JOIN Delincuente
--ON Calabozo.[CodigoCa] = Delincuente.[FK_CodigoCa]
--GROUP BY Calabozo.[CodigoCa];

--Listar todos los jefes de la comisaria.

--SELECT Policia.[NombrePo] Jefe
--FROM Policia
--WHERE Policia.[DNI] IN
--(
--SELECT Policia.[FK_DNIJefe]
--FROM Policia
--WHERE Policia.[FK_DNIJefe] IS NOT NULL
--);

--Listar los calabozos con más de 5 delincuentes.

--SELECT COUNT(*) DelincuentesPorCalabozo
--FROM Calabozo
--INNER JOIN Delincuente
--ON Calabozo.[CodigoCa] = Delincuente.[FK_CodigoCa]
--GROUP BY Calabozo.[CodigoCa]
--HAVING COUNT(*) > 5;

--El comisario desea saber cuántos delincuentes están detenidos por cada cargo.

--SELECT Delito.[NombreDelito], COUNT(*) CantidadDelincuentes
--FROM Delito
--INNER JOIN Comete
--ON Delito.[NombreDelito] = Comete.[FK_NombreDelito]
--INNER JOIN Delincuente
--ON Comete.[FK_DNIDelincuente] = Delincuente.[DNIDelincuente]
--GROUP BY Delito.[NombreDelito];

--Respecto de la anterior el porcentaje de cada cargo respecto del total de detenidos.

--SELECT Delito.[NombreDelito], COUNT(*) CantidadDelincuentes,
--CAST(100 * COUNT(*) / (
--SELECT COUNT(*) CantidadDelincuentes
--FROM Delincuente
--) AS NUMERIC(5, 2)) Porcentaje
--FROM Delito
--INNER JOIN Comete
--ON Delito.[NombreDelito] = Comete.[FK_NombreDelito]
--INNER JOIN Delincuente
--ON Comete.[FK_DNIDelincuente] = Delincuente.[DNIDelincuente]
--GROUP BY Delito.[NombreDelito];