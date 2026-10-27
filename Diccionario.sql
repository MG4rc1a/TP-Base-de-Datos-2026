-- Creacion de Base de Datos (y establecer como activa)
DROP DATABASE IF EXISTS calzados_sa;
CREATE DATABASE IF NOT EXISTS calzados_sa;
USE calzados_sa;

-- Creacion de tablas independientes (sin FK)
-- Cliente / Vendedor / Dia / Zapato / Numero / Proveedor
CREATE TABLE cliente (
    DNI VARCHAR(9) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    CONSTRAINT pk_cliente PRIMARY KEY (DNI)
);
CREATE TABLE vendedor (
    -- Ver de generar numeros
    nro_vendedor INT NOT NULL AUTO_INCREMENT,
    DNI VARCHAR(9) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    CONSTRAINT pk_vendedor PRIMARY KEY (nro_vendedor),
    CONSTRAINT ck_vendedor UNIQUE (DNI)
);

CREATE TABLE dia (
    dia_semana VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dia PRIMARY KEY (dia_semana)
);

CREATE TABLE zapato(
    modelo VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    CONSTRAINT pk_zapato PRIMARY KEY (modelo, color),
    CONSTRAINT zapato_precio
        CHECK (precio > 0 AND precio < 200000)
);

CREATE TABLE numero (
    numero INTEGER NOT NULL,
    CONSTRAINT pk_numero PRIMARY KEY (numero),
    CONSTRAINT numero
        CHECK (numero > 13 AND numero <= 49)
);

CREATE TABLE proveedor(
    CUIT VARCHAR(13) NOT NULL,
    razon_social VARCHAR(100),
    direccion VARCHAR(100),
    telefono_fijo VARCHAR(15),
    CONSTRAINT pk_proveedor PRIMARY KEY (CUIT)
);

-- Creacion de tablas dependientes (con FK)
-- Mayorista / Minorista / Horario_Vendedor / Franco / Factura
-- Zapato_Numero / Celular_Proveedor / Provee
CREATE TABLE mayorista (
    DNI VARCHAR(9) NOT NULL,
    descuento_general DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_mayorista PRIMARY KEY (DNI),
    CONSTRAINT fk_mayorista_cliente FOREIGN KEY (DNI) REFERENCES cliente (DNI)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_descuento_general
        CHECK (descuento_general >= 0 AND descuento_general <= 100)
);

CREATE TABLE minorista (
    DNI VARCHAR(9) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    CONSTRAINT pk_minorista PRIMARY KEY (DNI),
    CONSTRAINT fk_minorista_cliente FOREIGN KEY (DNI) REFERENCES cliente (DNI)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horario_vendedor (
    nro_vendedor INT NOT NULL,
    dia_semana VARCHAR(15) NOT NULL,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    CONSTRAINT pk_horario_vendedor PRIMARY KEY (nro_vendedor, dia_semana),
    CONSTRAINT fk_horario_vendedor FOREIGN KEY (nro_vendedor) REFERENCES vendedor (nro_vendedor)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_horario_vendedor_d FOREIGN KEY (dia_semana) REFERENCES dia (dia_semana)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE franco (
    nro_franco INT NOT NULL,
    nro_vendedor INT NOT NULL,
    fecha DATE NOT NULL,
    observaciones VARCHAR(100),
    CONSTRAINT pk_nro_franco PRIMARY KEY(nro_franco),
    CONSTRAINT fk_franco FOREIGN KEY (nro_vendedor) REFERENCES vendedor (nro_vendedor)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE factura (
    nro_factura INT NOT NULL,
    fecha DATE NOT NULL,
    DNI VARCHAR(9) NOT NULL,
    nro_vendedor INT NOT NULL,
    CONSTRAINT pk_factura PRIMARY KEY (nro_factura),
    CONSTRAINT fk_factura_c FOREIGN KEY (DNI) REFERENCES cliente (DNI)
       ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_factura_v FOREIGN KEY (nro_vendedor) REFERENCES vendedor (nro_vendedor)
       ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE zapato_numero (
    modelo VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    numero INTEGER NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT pk_zapato_numero PRIMARY KEY (modelo, color, numero),
    CONSTRAINT fk_zapato_numero_z FOREIGN KEY (modelo, color) REFERENCES zapato (modelo, color)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_zapato_numero_n FOREIGN KEY (numero) REFERENCES numero (numero)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_stock
        CHECK (stock >= 0)
);

CREATE TABLE celular_proveedor (
    CUIT VARCHAR(13) NOT NULL,
    nro_celular VARCHAR(15) NOT NULL,
    CONSTRAINT pk_celular_proveedor PRIMARY KEY(CUIT, nro_celular),
    CONSTRAINT fk_celular_proveedor FOREIGN KEY (CUIT) REFERENCES proveedor (CUIT)
         ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE provee (
    CUIT VARCHAR(13) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    CONSTRAINT pk_provee PRIMARY KEY (CUIT, modelo, color),
    CONSTRAINT fk_provee FOREIGN KEY (modelo, color) REFERENCES zapato (modelo, color)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_provee_p FOREIGN KEY (CUIT) REFERENCES proveedor (CUIT)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE detalle_factura(
    nro_factura INT NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    numero INTEGER NOT NULL,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(20,2) NOT NULL,
    descuento_aplicado DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_detalle_factura PRIMARY KEY (nro_factura, modelo, color, numero),
    CONSTRAINT fk_detalle_factura FOREIGN KEY (modelo, color, numero) REFERENCES zapato_numero (modelo, color, numero)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_factura_f FOREIGN KEY (nro_factura) REFERENCES factura (nro_factura)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT cantidad
        CHECK (cantidad >= 1),
    CONSTRAINT check_descuento_venta
        CHECK (descuento_aplicado >= 0 AND descuento_aplicado <= 100)
);


-- Creacion de tabla de cambios de precio en los zapatos, está información deberá contener, fecha, precio anterior, precio nuevo y usuario que realizó el cambio
CREATE TABLE auditoria_precio_zapato (
    nro_auditoria INT NOT NULL AUTO_INCREMENT,
    modelo VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    precio_anterior DECIMAL(20,2) NOT NULL,
    precio_nuevo DECIMAL(20,2) NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    CONSTRAINT pk_auditoria_precio PRIMARY KEY (nro_auditoria),
    CONSTRAINT fk_audotoria_precio FOREIGN KEY (modelo, color) REFERENCES zapato (modelo, color)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER $$
CREATE TRIGGER trigger_update_auditoria_zapato
    AFTER UPDATE ON zapato
        FOR EACH ROW
            BEGIN
            IF OLD.precio <> NEW.precio THEN
                INSERT INTO auditoria_precio_zapato(
                    modelo, color, precio_anterior, precio_nuevo, usuario
                )
                VALUES (
                    OLD.modelo, OLD.color, OLD.precio, NEW.precio, USER() 
                );
            END IF;
    END $$
DELIMITER ;