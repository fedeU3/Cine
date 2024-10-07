CREATE DATABASE IF NOT EXISTS Cine;
USE Cine;

DROP TABLE IF EXISTS Salas;
DROP TABLE IF EXISTS Butacas;
DROP TABLE IF EXISTS Generos;
DROP TABLE IF EXISTS Peliculas;
DROP TABLE IF EXISTS Funciones;
DROP TABLE IF EXISTS Reservas;

START TRANSACTION;

-- Tabla: Salas
CREATE TABLE Salas (
    idSala SMALLINT NOT NULL PRIMARY KEY,
    Sala VARCHAR(40) NOT NULL,
    TipoSala CHAR(10) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Observaciones VARCHAR(255) NULL
);

-- Tabla: Peliculas
CREATE TABLE Peliculas (
    idPelicula INTEGER NOT NULL PRIMARY KEY,
    Pelicula VARCHAR(100) NOT NULL,
    Sinopsis TEXT NULL,
    Actores VARCHAR(255) NULL,
    Duracion SMALLINT NOT NULL,
    Estado CHAR(1) NOT NULL CHECK (Estado IN ('A', 'I')),
    Observaciones VARCHAR(255) NULL
);

-- Tabla: Generos
CREATE TABLE Generos (
    idGenero SMALLINT NOT NULL PRIMARY KEY,
    Genero VARCHAR(40) NOT NULL,
    Estado CHAR(1) NOT NULL CHECK (Estado IN ('A', 'I'))
);

-- Tabla: Butacas
CREATE TABLE Butacas (
    idButaca INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSala SMALLINT NOT NULL,
    Fila CHAR(1) NOT NULL,
    Columna SMALLINT NOT NULL,
    Estado CHAR(1) NOT NULL CHECK (Estado IN ('A', 'I')),
    Observaciones VARCHAR(255) NULL,
    CONSTRAINT FK_Butacas_Salas FOREIGN KEY (idSala) REFERENCES Salas(idSala),
    CONSTRAINT AK_Butaca UNIQUE (idSala, Fila, Columna)
);

-- Tabla: Funciones
CREATE TABLE Funciones (
    idFuncion INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idSala SMALLINT NOT NULL,
    idPelicula INTEGER NOT NULL,
    FechaProbableInicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NULL,
    Precio DECIMAL(12,2) NOT NULL DEFAULT 1000 CHECK (Precio > 0),
    Estado CHAR(1) NOT NULL CHECK (Estado IN ('A', 'I')),
    Observaciones VARCHAR(255) NULL,
    CONSTRAINT FK_Funciones_Salas FOREIGN KEY (idSala) REFERENCES Salas(idSala),
    CONSTRAINT FK_Funciones_Peliculas FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula),
    CONSTRAINT AK_Funciones UNIQUE (idSala, idPelicula, FechaInicio)
);

-- Tabla: Reservas
CREATE TABLE Reservas (
    idReserva BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idFuncion INTEGER NOT NULL,
    idPelicula INTEGER NOT NULL,
    idButaca INTEGER NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EstaPagada CHAR(1) NOT NULL CHECK (EstaPagada IN ('A', 'I')),
    Observaciones VARCHAR(255) NULL,
    CONSTRAINT FK_Reservas_Funciones FOREIGN KEY (idFuncion) REFERENCES Funciones(idFuncion),
    CONSTRAINT FK_Reservas_Peliculas FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula),
    CONSTRAINT FK_Reservas_Butacas FOREIGN KEY (idButaca) REFERENCES Butacas(idButaca),
    CONSTRAINT AK_Reservas UNIQUE (idFuncion, idPelicula, idButaca)
);