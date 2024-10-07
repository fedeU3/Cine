USE Cine;

-- Insertar datos en la tabla Salas
INSERT INTO Salas (idSala, Sala, TipoSala, Direccion, Observaciones)
VALUES
(1, 'Sala 1', '3D', 'Calle Falsa 123', 'Sala principal'),
(2, 'Sala 2', 'IMAX', 'Avenida Siempre Viva 742', NULL),
(3, 'Sala 3', '2D', 'Calle Verdadera 456', 'Sala pequeña');

-- Insertar datos en la tabla Peliculas
INSERT INTO Peliculas (idPelicula, Pelicula, Sinopsis, Actores, Duracion, Estado, Observaciones)
VALUES
(1, 'Película A', 'Una película de acción increíble.', 'Actor 1, Actriz 1', 120, 'A', NULL),
(2, 'Película B', 'Una historia de amor conmovedora.', 'Actor 2, Actriz 2', 100, 'A', 'Recomendada para mayores de 12 años'),
(3, 'Película C', 'Una comedia para toda la familia.', 'Actor 3, Actriz 3', 90, 'I', NULL);

-- Insertar datos en la tabla Generos
INSERT INTO Generos (idGenero, Genero, Estado)
VALUES
(1, 'Acción', 'A'),
(2, 'Comedia', 'A'),
(3, 'Drama', 'A');

-- Insertar datos en la tabla Butacas
INSERT INTO Butacas (idButaca, idSala, Fila, Columna, Estado, Observaciones)
VALUES
(1, 1, 'A', 1, 'A', NULL),
(2, 1, 'A', 2, 'A', NULL),
(3, 1, 'A', 3, 'I', 'Butaca rota'),
(4, 2, 'B', 1, 'A', NULL),
(5, 2, 'B', 2, 'A', NULL),
(6, 3, 'C', 1, 'A', NULL);

-- Insertar datos en la tabla Funciones
INSERT INTO Funciones (idSala, idPelicula, FechaProbableInicio, FechaInicio, FechaFin, Precio, Estado, Observaciones)
VALUES
(1, 1, '2024-10-05 14:00:00', '2024-10-05 15:00:00', '2024-10-05 17:00:00', 1200, 'A', NULL),
(2, 2, '2024-10-05 16:00:00', '2024-10-05 17:00:00', '2024-10-05 19:00:00', 1500, 'A', 'Promoción especial'),
(3, 3, '2024-10-06 18:00:00', '2024-10-06 19:00:00', '2024-10-06 21:00:00', 1000, 'I', NULL);

-- Insertar datos en la tabla Reservas
INSERT INTO Reservas (idFuncion, idPelicula, idButaca, Fecha, EstaPagada, Observaciones)
VALUES
(1, 1, 1, '2024-10-01 12:00:00', 'A', NULL),
(1, 1, 2, '2024-10-01 12:05:00', 'A', NULL),
(2, 2, 4, '2024-10-02 14:00:00', 'I', 'Pendiente de confirmación'),
(2, 2, 5, '2024-10-02 14:10:00', 'A', NULL),
(3, 3, 6, '2024-10-03 16:00:00', 'A', NULL);

