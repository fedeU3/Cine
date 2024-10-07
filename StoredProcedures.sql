Use cine;

-- Primer Stored procedure. Consultar peliculas proyectadas

DELIMITER //

CREATE PROCEDURE ConsultarPeliculasPorFecha(IN fechaConsulta DATE)
BEGIN

    SELECT f.idFuncion, f.idPelicula,f.idSala, p.Pelicula AS nombrePelicula, s.Sala AS nombreSala, f.FechaInicio AS horaInicio, f.Precio FROM Funciones f
	JOIN Peliculas p ON f.idPelicula = p.idPelicula
	JOIN Salas s ON f.idSala = s.idSala
    WHERE DATE(f.FechaInicio) = fechaConsulta AND f.Estado = 'A';

END //

DELIMITER ;


-- Segundo Stored procedure. Consultar peliculas por ID

DELIMITER //

CREATE PROCEDURE ConsultarPeliculaPorId(IN peliculaID INTEGER)
BEGIN

    SELECT Pelicula,Sinopsis, Actores, Duracion, Estado, Observaciones FROM Peliculas
    WHERE idPelicula = peliculaID;
    
END //

DELIMITER ;


-- Tercer Stored procedure. Reservar funciones

DELIMITER $$

CREATE PROCEDURE sp_ReservarFuncion(IN p_IdFuncion INTEGER, IN p_Cantidad INTEGER)
BEGIN
    DECLARE v_Disponibles INT;
    
    -- Paso 1: Contamos las butacas disponibles para la función especificada (no reservadas)
    SELECT COUNT(b.idButaca) INTO v_Disponibles
    FROM Butacas b
    LEFT JOIN Reservas r ON b.idButaca = r.idButaca
    WHERE b.idSala IN (
        SELECT f.idSala 
        FROM Funciones f 
        WHERE f.idFuncion = p_IdFuncion
    )
    AND (r.idReserva IS NULL OR r.EstaPagada = 'I'); -- 'I' = Inactiva (sin pagar)

    -- Paso 2: Si hay suficientes butacas disponibles, realizamos la reserva
    IF v_Disponibles >= p_Cantidad THEN
        -- Insertamos las reservas (aquí deberías tener un DNI o ID de cliente)
        -- Para este ejemplo, usa 'DNI de prueba'
        INSERT INTO Reservas (idFuncion, idPelicula, idButaca, Fecha, EstaPagada, Observaciones) 
        SELECT p_IdFuncion, f.idPelicula, b.idButaca, NOW(), 'A', 'Reservado' -- 'A' = Activa (pagada)
        FROM Butacas b
        LEFT JOIN Reservas r ON b.idButaca = r.idButaca
        JOIN Funciones f ON b.idSala = f.idSala
        WHERE f.idFuncion = p_IdFuncion
        AND (r.idReserva IS NULL OR r.EstaPagada = 'I') -- Solo selecciona butacas libres o inactivas
        LIMIT p_Cantidad;

        -- Paso 3: Mensaje de éxito
        SELECT 'OK' AS Resultado;
    ELSE
        -- Paso 4: Si no hay suficientes butacas, devuelve un mensaje de error
        SELECT 'Error: No hay suficientes butacas disponibles.' AS Resultado;
    END IF;
END $$ 

DELIMITER ;

