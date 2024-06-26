CREATE TABLE Municipio (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Provincia VARCHAR(100)
);
CREATE TABLE Tipo_delito (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE Subtipo_delito (
    ID SERIAL PRIMARY KEY,
    Nombre_subtipo VARCHAR(100),
    FK_tipo INT REFERENCES Tipo_delito(ID)
);

CREATE TABLE Fecha (
    ID SERIAL PRIMARY KEY,
    Numero_mes INT,
    Nombre_mes VARCHAR(50),
    Año INT
);

CREATE TABLE Cobertura (
    ID SERIAL PRIMARY KEY,
    Agua BOOLEAN,
    Gas BOOLEAN,
    Cloaca BOOLEAN,
    Electricidad BOOLEAN
);

CREATE TABLE Comuna (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Numero INT
);

CREATE TABLE Barrio (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Cantidad_de_Habitantes INT,
    Extension FLOAT,
    FK_Cobertura INT REFERENCES Cobertura(ID),
    FK_Comuna INT REFERENCES Comuna(ID),
    FK_Municipio INT REFERENCES Municipio(ID)
);

CREATE TABLE Ingreso_Salarial (
    ID SERIAL PRIMARY KEY,
    Salario_minimo FLOAT,
    Salario_maximo FLOAT,
    FK_Barrio INT REFERENCES Barrio(ID),
    FK_Fecha INT REFERENCES Fecha(ID)
);

CREATE TABLE Infraestructura (
    ID SERIAL PRIMARY KEY,
    Tipo_infraestructura VARCHAR(100)
);

CREATE TABLE Establecimiento (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    Estado VARCHAR(100),
    Tipo VARCHAR(100)
);

CREATE TABLE Obra (
    ID SERIAL PRIMARY KEY,
    Inversion FLOAT,
    Publica_Privada VARCHAR(50),
    FK_Barrio INT REFERENCES Barrio(ID),
    FK_Establecimiento INT REFERENCES Establecimiento(ID),
    FK_Infraestructura INT REFERENCES Infraestructura(ID),
    CHECK (
        (FK_Establecimiento IS NOT NULL AND FK_Infraestructura IS NULL) OR
        (FK_Establecimiento IS NULL AND FK_Infraestructura IS NOT NULL)
    )
);

CREATE TABLE Delito (
    ID SERIAL PRIMARY KEY,
    Cantidad_de_victimas INT,
    Cantidad_de_Delitos INT,
    FK_Barrio INT REFERENCES Barrio(ID),
    FK_Fecha INT REFERENCES Fecha(ID),
    FK_Subtipo INT REFERENCES Subtipo_delito(ID)
);

-- Insertar datos en la tabla Municipio
INSERT INTO Municipio (Nombre, Provincia) VALUES
('Buenos Aires', 'Buenos Aires'),
('Avellaneda', 'Buenos Aires'),
('La Matanza', 'Buenos Aires'),
('Morón', 'Buenos Aires'),
('Lomas de Zamora', 'Buenos Aires'),
('Quilmes', 'Buenos Aires');

-- Insertar datos en la tabla Comuna (sólo para CABA)
INSERT INTO Comuna (Nombre, Numero) VALUES
('Comuna 1', 1),
('Comuna 2', 2),
('Comuna 3', 3),
('Comuna 4', 4),
('Comuna 5', 5),
('Comuna 6', 6);

-- Insertar datos en la tabla Cobertura
INSERT INTO Cobertura (Agua, Gas, Cloaca, Electricidad) VALUES
(TRUE, TRUE, TRUE, TRUE),
(TRUE, TRUE, FALSE, TRUE),
(TRUE, FALSE, FALSE, TRUE),
(TRUE, TRUE, TRUE, FALSE),
(TRUE, FALSE, TRUE, TRUE),
(FALSE, TRUE, TRUE, TRUE);

-- Insertar datos en la tabla Barrio
INSERT INTO Barrio (Nombre, Cantidad_de_Habitantes, Extension, FK_Cobertura, FK_Comuna, FK_Municipio) VALUES
('Palermo', 200000, 15.9, 1, 1, NULL),
('Recoleta', 150000, 5.9, 1, 2, NULL),
('Flores', 120000, 8.1, 2, 3, NULL),
('Lanús', 500000, 45.0, 3, NULL, 2),
('San Justo', 300000, 25.0, 4, NULL, 3),
('Morón', 400000, 30.0, 5, NULL, 4),
('Lomas de Zamora', 600000, 50.0, 6, NULL, 5),
('Quilmes', 350000, 40.0, 1, NULL, 6),
('Almagro', 120000, 6.0, 2, 4, NULL),
('Caballito', 180000, 7.5, 3, 5, NULL);

-- Insertar datos en la tabla Tipo_delito
INSERT INTO Tipo_delito (Nombre) VALUES
('Robo'),
('Homicidio'),
('Hurto'),
('Fraude');

-- Insertar datos en la tabla Subtipo_delito
INSERT INTO Subtipo_delito (Nombre_subtipo, FK_tipo) VALUES
('Robo con violencia', 1),
('Robo sin violencia', 1),
('Homicidio doloso', 2),
('Homicidio culposo', 2),
('Hurto simple', 3),
('Hurto agravado', 3),
('Fraude financiero', 4),
('Fraude de identidad', 4);

-- Insertar datos en la tabla Fecha
INSERT INTO Fecha (Numero_mes, Nombre_mes, Año) VALUES
(1, 'Enero', 2023),
(2, 'Febrero', 2023),
(3, 'Marzo', 2023),
(4, 'Abril', 2023),
(5, 'Mayo', 2023),
(6, 'Junio', 2023),
(7, 'Julio', 2023),
(8, 'Agosto', 2023),
(9, 'Septiembre', 2023),
(10, 'Octubre', 2023),
(11, 'Noviembre', 2023),
(12, 'Diciembre', 2023);

-- Insertar datos en la tabla Infraestructura
INSERT INTO Infraestructura (Tipo_infraestructura) VALUES
('Agua'),
('Gas'),
('Cloaca'),
('Electricidad'),
('Internet'),
('Alumbrado público');

-- Insertar datos en la tabla Establecimiento
INSERT INTO Establecimiento (Nombre, Estado, Tipo) VALUES
('Hospital Fernández', 'Activo', 'Hospital'),
('Escuela Nro 1', 'Activo', 'Escuela'),
('Comisaría 10', 'Activo', 'Comisaría'),
('Club Social Buenos Aires', 'Activo', 'Club Social'),
('Biblioteca Nacional', 'Activo', 'Biblioteca'),
('Centro Cultural Recoleta', 'Activo', 'Centro Cultural');

-- Insertar datos en la tabla Ingreso_Salarial
INSERT INTO Ingreso_Salarial (Salario_minimo, Salario_maximo, FK_Barrio, FK_Fecha) VALUES
(30000.00, 50000.00, 1, 1),
(35000.00, 55000.00, 2, 2),
(25000.00, 45000.00, 3, 3),
(40000.00, 60000.00, 4, 4),
(20000.00, 40000.00, 5, 5),
(45000.00, 65000.00, 6, 6),
(50000.00, 70000.00, 7, 7),
(38000.00, 58000.00, 8, 8),
(32000.00, 52000.00, 9, 9),
(37000.00, 57000.00, 10, 10);

-- Insertar datos en la tabla Obra
INSERT INTO Obra (Inversion, Publica_Privada, FK_Barrio, FK_Establecimiento, FK_Infraestructura) VALUES
(1500000.00, 'Publica', 1, NULL, 1),
(500000.00, 'Publica', 2, NULL, 2),
(2000000.00, 'Privada', 3, NULL, 3),
(2500000.00, 'Publica', 4, NULL, 4),
(300000.00, 'Privada', 5, NULL, 5),
(1800000.00, 'Publica', 6, NULL, 6),
(750000.00, 'Privada', 7, 1, NULL),
(900000.00, 'Publica', 8, 2, NULL),
(1200000.00, 'Privada', 9, 3, NULL),
(1300000.00, 'Publica', 10, 4, NULL);

-- Insertar datos en la tabla Delito
INSERT INTO Delito (Cantidad_de_victimas, Cantidad_de_Delitos, FK_Barrio, FK_Fecha, FK_Subtipo) VALUES
(5, 10, 1, 1, 1),
(2, 4, 2, 2, 2),
(1, 1, 3, 3, 3),
(8, 15, 4, 4, 4),
(3, 6, 5, 5, 5),
(6, 9, 6, 6, 6),
(4, 7, 7, 7, 7),
(7, 8, 8, 8, 8),
(5, 11, 9, 9, 1),
(3, 5, 10, 10, 2),
(2, 3, 1, 11, 3),
(9, 14, 2, 12, 4),
(4, 6, 3, 1, 5),
(7, 10, 4, 2, 6),
(5, 8, 5, 3, 7),
(6, 9, 6, 4, 8),
(3, 5, 7, 5, 1),
(8, 12, 8, 6, 2),
(1, 2, 9, 7, 3),
(4, 6, 10, 8, 4);
