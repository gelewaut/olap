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
