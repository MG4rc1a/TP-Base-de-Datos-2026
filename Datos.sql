USE calzados_sa;

-- INSERTS de tablas independientes (sin FK)
-- Cliente / Vendedor / Dia / Zapato / Numero / Proveedor

INSERT INTO cliente (DNI, nombre, apellido, direccion) VALUES 
('11222333', 'Martín', 'Gómez', 'San Martín 123'),
('44555666', 'Laura', 'Pérez', 'Belgrano 456'),
('77888999', 'Fabio', 'Zorzan', 'Constitucion 111'),
('99888777', 'Sandra', 'Angeli', 'Alvear 222'),
('66555444', 'Guillermo', 'Fraschetti', 'Belgrano 333'),
('33222111', 'Mariana', 'Frutos', 'Pdte. Peron 444'),
('22211000', 'Gonzalo', 'García', 'Marcelo T. Alvear 1212');

INSERT INTO vendedor (nro_vendedor, DNI, nombre, apellido, direccion) VALUES
(1, '22111000', 'Juan' , 'Perez', 'Pdte. Peron 555'),
(2, '33444555', 'Pepe', 'Castillo', 'Alberdi 222'),
(3, '66777888', 'Marta', 'Diaz', 'Constitucion 444'),
(4, '99101111', 'Giovanni', 'Vásquez', 'Colombia 1212'),
(5, '11000222', 'Alejo', 'Rossaroli', 'Marcelo T. Alvear 2121');

INSERT INTO dia (dia_semana) VALUES 
('Lunes'), 
('Martes'), 
('Miércoles'),
('Jueves'),
('Viernes'),
('Sabado'),
('Domingo');

INSERT INTO zapato (modelo, color, precio) VALUES
('Addidas Samba', 'Negro', 129000.0),
('Vans Knu Skool', 'Celeste', 199000.0),
('Puma Speedcat', 'Verde', 169999.0),
('Nike Duke Low', 'Beige', 136999.0),
('Nike Duke Low', 'Verde', 136999.0),
('Addidas Samba', 'Marron', 129000.0),
('Vans Knu Skool', 'Negro', 199000.0),
('Nike Air Force', 'Blanco', 181000.0);

INSERT INTO numero (numero) VALUES
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44);

INSERT INTO proveedor (CUIT, razon_social, direccion, telefono_fijo) VALUES 
('30-65489123-8', 'Distribuidora Central de Calzados S.A.', 'Corrientes 1011', '01143715500'),
('30-71029384-5', 'Cueros y Suelas del Centro SRL', 'San Juan 828', '03514229010'),
('33-54981230-9', 'Manufacturas Industriales Calzarte', 'Colón 3232', '03584641122'),
('30-58963214-7', 'Importadora Deportiva Austral S.A.', 'Rivadavia 123', '01118627788'),
('30-69874125-3', 'Fábrica de Zapatillas del Sur SRL', 'Mitre 2345', '03584639900');

-- INSERTs de tablas dependientes (con FK)
-- Mayorista / Minorista / Horario_Vendedor / Franco / Factura
-- Zapato_Numero / Celular_Proveedor / Provee

INSERT INTO mayorista (DNI, descuento_general) VALUES
('99888777', 15.5),
('11222333', 20.0),
('22211000', 50.0);

INSERT INTO minorista (DNI, fecha_nacimiento) VALUES
('33222111', '1981-01-21'),
('66555444', '1982-02-22'),
('77888999', '1983-03-23'),
('44555666', '1984-04-24');

INSERT INTO horario_vendedor (nro_vendedor, dia_semana, hora_entrada, hora_salida) VALUES
(1, 'Lunes',     '08:00:00', '12:00:00'),
(2, 'Martes',    '09:00:00', '12:00:00'),
(3, 'Miércoles', '08:00:00', '12:00:00'),
(4, 'Jueves',    '08:00:00', '12:00:00'),
(5, 'Viernes',   '09:00:00', '12:00:00'),
(2, 'Lunes',     '14:00:00', '20:00:00'),
(3, 'Martes',    '14:00:00', '20:00:00'),
(4, 'Miércoles', '14:00:00', '20:00:00'),
(5, 'Jueves',    '14:00:00', '21:00:00'),
(1, 'Viernes',   '16:00:00', '22:00:00');

INSERT INTO franco (nro_franco, nro_vendedor, fecha, observaciones) VALUES 
(1, 1, '2025-01-19', 'Franco compensatorio'),
(2, 2, '2026-10-20', 'Franco semanal'),
(3, 3, '2026-10-21', 'Franco por dia festivo trabajado'),
(4, 4, '2026-01-22', 'Franco semanal'),
(5, 5, '2026-01-23', 'Franco por cambio de turno'),
(6, 1, '2026-10-26', 'Franco semanal');

INSERT INTO factura (nro_factura, fecha, DNI, nro_vendedor) VALUES 
(1, '2025-10-15', '11222333', 1),
(2, '2026-10-16', '44555666', 2),
(3, '2025-10-16', '77888999', 1),
(4, '2025-10-17', '99888777', 3),
(5, '2026-10-18', '66555444', 4),
(6, '2026-10-19', '33222111', 5),
(7, '2025-10-20', '22211000', 3),
(8, '2026-10-21', '11222333', 1);

INSERT INTO zapato_numero (modelo, color, numero, stock) VALUES 
-- Addidas Samba Negro
('Addidas Samba', 'Negro', 38, 12),
('Addidas Samba', 'Negro', 39, 15),
('Addidas Samba', 'Negro', 40, 8),
('Addidas Samba', 'Negro', 41, 5),
-- Addidas Samba Marron
('Addidas Samba', 'Marron', 39, 6),
('Addidas Samba', 'Marron', 40, 10),
('Addidas Samba', 'Marron', 42, 4),
-- Vans Knu Skool Celeste
('Vans Knu Skool', 'Celeste', 36, 7),
('Vans Knu Skool', 'Celeste', 37, 9),
('Vans Knu Skool', 'Celeste', 38, 11),
-- Vans Knu Skool Negro
('Vans Knu Skool', 'Negro', 39, 14),
('Vans Knu Skool', 'Negro', 40, 20),
('Vans Knu Skool', 'Negro', 41, 13),
-- Puma Speedcat Verde
('Puma Speedcat', 'Verde', 35, 3),
('Puma Speedcat', 'Verde', 36, 5),
('Puma Speedcat', 'Verde', 37, 8),
-- Nike Duke Low Beige
('Nike Duke Low', 'Beige', 38, 10),
('Nike Duke Low', 'Beige', 40, 6),
-- Nike Duke Low Verde
('Nike Duke Low', 'Verde', 41, 4),
('Nike Duke Low', 'Verde', 42, 7),
-- Nike Air Force Blanco
('Nike Air Force', 'Blanco', 39, 18),
('Nike Air Force', 'Blanco', 40, 25),
('Nike Air Force', 'Blanco', 41, 16),
('Nike Air Force', 'Blanco', 42, 10);


INSERT INTO celular_proveedor (CUIT, nro_celular) VALUES 
('30-69874125-3', '0112345678'),
('30-58963214-7', '0113456789'),
('33-54981230-9', '3584567890'),
('30-71029384-5', '3515678901'),
('30-65489123-8', '0116789012');

INSERT INTO provee (CUIT, modelo, color) VALUES
-- Distribuidora Central de Calzados S.A.
('30-65489123-8', 'Addidas Samba', 'Negro'),
('30-65489123-8', 'Addidas Samba', 'Marron'),
('30-65489123-8', 'Nike Air Force', 'Blanco'),
-- Cueros y Suelas del Centro SRL
('30-71029384-5', 'Addidas Samba', 'Marron'),
('30-71029384-5', 'Puma Speedcat', 'Verde'),
-- Manufacturas Industriales Calzarte
('33-54981230-9', 'Nike Duke Low', 'Beige'),
('33-54981230-9', 'Nike Duke Low', 'Verde'),
-- Importadora Deportiva Austral S.A.
('30-58963214-7', 'Vans Knu Skool', 'Celeste'),
('30-58963214-7', 'Vans Knu Skool', 'Negro'),
('30-58963214-7', 'Nike Air Force', 'Blanco'),
-- Fábrica de Zapatillas del Sur SRL
('30-69874125-3', 'Puma Speedcat', 'Verde'),
('30-69874125-3', 'Vans Knu Skool', 'Negro');

INSERT INTO detalle_factura (nro_factura, modelo, color, numero, cantidad, precio_venta, descuento_aplicado) VALUES
(1, 'Addidas Samba', 'Negro', 39, 2, 129000.00, 20.0),
(1, 'Addidas Samba', 'Marron', 40, 1, 129000.00, 20.0),
(2, 'Vans Knu Skool', 'Celeste', 37, 1, 199000.00, 25.0),
(3, 'Addidas Samba', 'Negro', 38, 1, 129000.00, 0.0),
(4, 'Vans Knu Skool', 'Negro', 39, 3, 199000.00, 15.5),
(4, 'Addidas Samba', 'Negro', 41, 2, 129000.00, 15.5),
(5, 'Vans Knu Skool', 'Celeste', 38, 1, 199000.00, 0.0),
(6, 'Vans Knu Skool', 'Negro', 40, 4, 199000.00, 50.0),
(7, 'Vans Knu Skool', 'Negro', 40, 4, 199000.00, 30.0),
(8, 'Addidas Samba', 'Negro', 40, 2, 129000.00, 10.0);

-- Actualizaciones de precios de zapatos
UPDATE zapato SET precio = 115000.00 WHERE modelo = 'Addidas Samba' AND color = 'Negro';
UPDATE zapato SET precio = 175000.00 WHERE modelo = 'Vans Knu Skool' AND color = 'Celeste';
UPDATE zapato SET precio = 149999.00 WHERE modelo = 'Puma Speedcat' AND color = 'Verde';
UPDATE zapato SET precio = 120000.00 WHERE modelo = 'Nike Duke Low' AND color = 'Verde';


