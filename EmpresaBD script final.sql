-- ============================================================================
-- PRUEBA TÉCNICA - ANALISTA DE SISTEMAS (KAOSTECHNOLOGY)
-- SCRIPT CONSOLIDADO FINAL - CREACIÓN DE BASE DE DATOS, TABLAS Y PROCEDIMIENTOS
-- BASE DE DATOS: EmpresaDB
-- ============================================================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EmpresaDB')
BEGIN
    ALTER DATABASE EmpresaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmpresaDB;
END
GO

CREATE DATABASE EmpresaDB;
GO

USE EmpresaDB;
GO

-- ============================================================================
-- 1. TABLAS Y RELACIONES (LLAVES FORÁNEAS)
-- ============================================================================

CREATE TABLE EstadosPedido (
    EstadoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreEstado VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200) NULL
);

CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NULL,
    DocumentoIdentidad VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(150) NOT NULL,
    Telefono VARCHAR(20) NULL,
    Direccion VARCHAR(250) NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Empleados (
    EmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cargo VARCHAR(100) NULL,
    Email VARCHAR(150) NOT NULL,
    Salario DECIMAL(18,2) NOT NULL DEFAULT 0,
    FechaContratacion DATE NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCategoria VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Proveedores (
    ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    NombreComercial VARCHAR(150) NOT NULL,
    ContactoNombre VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    Email VARCHAR(150) NULL,
    Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(150) NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL CHECK (PrecioUnitario >= 0),
    Stock INT NOT NULL DEFAULT 0 CHECK (Stock >= 0),
    CategoriaID INT NOT NULL,
    ProveedorID INT NOT NULL,
    Activo BIT DEFAULT 1,
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    FechaPedido DATETIME NOT NULL DEFAULT GETDATE(),
    ClienteID INT NOT NULL,
    EmpleadoID INT NOT NULL,
    EstadoID INT NOT NULL,
    MontoTotal DECIMAL(18,2) NOT NULL DEFAULT 0.00 CHECK (MontoTotal >= 0),
    CONSTRAINT FK_Pedidos_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    CONSTRAINT FK_Pedidos_Empleados FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID),
    CONSTRAINT FK_Pedidos_EstadosPedido FOREIGN KEY (EstadoID) REFERENCES EstadosPedido(EstadoID)
);

CREATE TABLE DetallePedido (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(18,2) NOT NULL CHECK (PrecioUnitario >= 0),
    Subtotal AS (Cantidad * PrecioUnitario),
    CONSTRAINT FK_DetallePedido_Pedidos FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID) ON DELETE CASCADE,
    CONSTRAINT FK_DetallePedido_Productos FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO

-- ============================================================================
-- 2. DATOS SEMILLA (INSERCIONES INICIALES DE PRUEBA)
-- ============================================================================

INSERT INTO EstadosPedido (NombreEstado, Descripcion) VALUES 
('Pendiente', 'Pedido registrado sin procesar'),
('Procesado', 'Pedido verificado y pagado'),
('Enviado', 'Pedido en ruta de entrega'),
('Cancelado', 'Pedido anulado');

INSERT INTO Categorias (NombreCategoria, Descripcion) VALUES 
('Tecnología', 'Equipos de cómputo y electrónica'),
('Hogar', 'Artículos para la casa');

INSERT INTO Proveedores (NombreComercial, ContactoNombre, Telefono, Email) VALUES 
('Tech Supplier Corp', 'Carlos Mendoza', '555-0101', 'contacto@techsupplier.com'),
('Hogar Express', 'Ana Gómez', '555-0202', 'ventas@hogarexpress.com');

INSERT INTO Empleados (Nombre, Apellido, Cargo, Email, Salario, FechaContratacion) VALUES 
('Laura', 'Ríos', 'Analista de Ventas', 'laura.rios@empresa.com', 2500000.00, '2023-01-15'),
('David', 'García', 'Gestor de Logística', 'david.garcia@empresa.com', 2800000.00, '2023-05-10');

INSERT INTO Clientes (Nombre, Apellido, DocumentoIdentidad, Email, Telefono, Direccion) VALUES 
('Juan', 'Pérez', '10203040', 'juan.perez@gmail.com', '3001234567', 'Calle 10 # 40-20'),
('María', 'Torres', '50607080', 'maria.torres@hotmail.com', '3109876543', 'Carrera 15 # 8-30');

INSERT INTO Productos (NombreProducto, PrecioUnitario, Stock, CategoriaID, ProveedorID, Activo) VALUES 
('Laptop Laptop Pro 15', 1200.00, 15, 1, 1, 1),
('Mouse Inalámbrico', 25.00, 50, 1, 1, 1),
('Cafetera Automática', 80.00, 20, 2, 2, 1);
GO

-- ============================================================================
-- 3. PROCEDIMIENTOS ALMACENADOS DE CRUD (4 POR TABLA)
-- ============================================================================

-- ----- 3.1. TABLA: EstadosPedido -----
CREATE PROCEDURE sp_EstadosPedido_Insert
    @NombreEstado VARCHAR(50),
    @Descripcion VARCHAR(200)
AS
BEGIN
    INSERT INTO EstadosPedido (NombreEstado, Descripcion)
    VALUES (@NombreEstado, @Descripcion);
    SELECT SCOPE_IDENTITY() AS EstadoID;
END;
GO

CREATE PROCEDURE sp_EstadosPedido_SelectAll
AS
BEGIN
    SELECT EstadoID, NombreEstado, Descripcion FROM EstadosPedido;
END;
GO

CREATE PROCEDURE sp_EstadosPedido_Update
    @EstadoID INT,
    @NombreEstado VARCHAR(50),
    @Descripcion VARCHAR(200)
AS
BEGIN
    UPDATE EstadosPedido
    SET NombreEstado = @NombreEstado, Descripcion = @Descripcion
    WHERE EstadoID = @EstadoID;
END;
GO

CREATE PROCEDURE sp_EstadosPedido_Delete
    @EstadoID INT
AS
BEGIN
    DELETE FROM EstadosPedido WHERE EstadoID = @EstadoID;
END;
GO

-- ----- 3.2. TABLA: Categorias -----
CREATE PROCEDURE sp_Categorias_Insert
    @NombreCategoria VARCHAR(100),
    @Descripcion VARCHAR(250)
AS
BEGIN
    INSERT INTO Categorias (NombreCategoria, Descripcion)
    VALUES (@NombreCategoria, @Descripcion);
    SELECT SCOPE_IDENTITY() AS CategoriaID;
END;
GO

CREATE PROCEDURE sp_Categorias_SelectAll
AS
BEGIN
    SELECT CategoriaID, NombreCategoria, Descripcion FROM Categorias WHERE Activo = 1;
END;
GO

CREATE PROCEDURE sp_Categorias_SelectById
    @CategoriaID INT
AS
BEGIN
    SELECT CategoriaID, NombreCategoria, Descripcion 
    FROM Categorias WHERE CategoriaID = @CategoriaID;
END;
GO

CREATE PROCEDURE sp_Categorias_Update
    @CategoriaID INT,
    @NombreCategoria VARCHAR(100),
    @Descripcion VARCHAR(250)
AS
BEGIN
    UPDATE Categorias
    SET NombreCategoria = @NombreCategoria, Descripcion = @Descripcion
    WHERE CategoriaID = @CategoriaID;
END;
GO

-- Eliminación lógica (soft delete): preserva la integridad de Productos
-- que ya referencian esta categoría, y evita errores de llave foránea.
CREATE PROCEDURE sp_Categorias_Delete
    @CategoriaID INT
AS
BEGIN
    UPDATE Categorias SET Activo = 0 WHERE CategoriaID = @CategoriaID;
END;
GO

-- ----- 3.3. TABLA: Proveedores -----
CREATE PROCEDURE sp_Proveedores_Insert
    @NombreComercial VARCHAR(150),
    @ContactoNombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Email VARCHAR(150)
AS
BEGIN
    INSERT INTO Proveedores (NombreComercial, ContactoNombre, Telefono, Email)
    VALUES (@NombreComercial, @ContactoNombre, @Telefono, @Email);
    SELECT SCOPE_IDENTITY() AS ProveedorID;
END;
GO

CREATE PROCEDURE sp_Proveedores_SelectAll
AS
BEGIN
    SELECT ProveedorID, NombreComercial, ContactoNombre, Telefono, Email FROM Proveedores WHERE Activo = 1;
END;
GO

CREATE PROCEDURE sp_Proveedores_SelectById
    @ProveedorID INT
AS
BEGIN
    SELECT ProveedorID, NombreComercial, ContactoNombre, Telefono, Email 
    FROM Proveedores WHERE ProveedorID = @ProveedorID;
END;
GO

CREATE PROCEDURE sp_Proveedores_Update
    @ProveedorID INT,
    @NombreComercial VARCHAR(150),
    @ContactoNombre VARCHAR(100),
    @Telefono VARCHAR(20),
    @Email VARCHAR(150)
AS
BEGIN
    UPDATE Proveedores
    SET NombreComercial = @NombreComercial, ContactoNombre = @ContactoNombre,
        Telefono = @Telefono, Email = @Email
    WHERE ProveedorID = @ProveedorID;
END;
GO

-- Eliminación lógica (soft delete): preserva la integridad de Productos
-- que ya referencian este proveedor.
CREATE PROCEDURE sp_Proveedores_Delete
    @ProveedorID INT
AS
BEGIN
    UPDATE Proveedores SET Activo = 0 WHERE ProveedorID = @ProveedorID;
END;
GO

-- ----- 3.4. TABLA: Empleados -----
CREATE PROCEDURE sp_Empleados_Insert
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Email VARCHAR(150),
    @Salario DECIMAL(18,2),
    @FechaContratacion DATE
AS
BEGIN
    INSERT INTO Empleados (Nombre, Apellido, Cargo, Email, Salario, FechaContratacion)
    VALUES (@Nombre, @Apellido, @Cargo, @Email, @Salario, @FechaContratacion);
    SELECT SCOPE_IDENTITY() AS EmpleadoID;
END;
GO

CREATE PROCEDURE sp_Empleados_SelectAll
AS
BEGIN
    SELECT EmpleadoID, Nombre, Apellido, Cargo, Email, Salario, FechaContratacion 
    FROM Empleados WHERE Activo = 1;
END;
GO

CREATE PROCEDURE sp_Empleados_SelectById
    @EmpleadoID INT
AS
BEGIN
    SELECT EmpleadoID, Nombre, Apellido, Cargo, Email, Salario, FechaContratacion 
    FROM Empleados WHERE EmpleadoID = @EmpleadoID;
END;
GO

CREATE PROCEDURE sp_Empleados_Update
    @EmpleadoID INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Email VARCHAR(150),
    @Salario DECIMAL(18,2),
    @FechaContratacion DATE
AS
BEGIN
    UPDATE Empleados
    SET Nombre = @Nombre, Apellido = @Apellido, Cargo = @Cargo,
        Email = @Email, Salario = @Salario, FechaContratacion = @FechaContratacion
    WHERE EmpleadoID = @EmpleadoID;
END;
GO

-- Eliminación lógica (soft delete): preserva la integridad de Pedidos
-- que ya referencian este empleado.
CREATE PROCEDURE sp_Empleados_Delete
    @EmpleadoID INT
AS
BEGIN
    UPDATE Empleados SET Activo = 0 WHERE EmpleadoID = @EmpleadoID;
END;
GO

-- ----- 3.5. TABLA: Clientes -----
CREATE PROCEDURE sp_Clientes_Insert
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DocumentoIdentidad VARCHAR(20),
    @Email VARCHAR(150),
    @Telefono VARCHAR(20),
    @Direccion VARCHAR(250)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Apellido, DocumentoIdentidad, Email, Telefono, Direccion)
    VALUES (@Nombre, @Apellido, @DocumentoIdentidad, @Email, @Telefono, @Direccion);
    SELECT SCOPE_IDENTITY() AS ClienteID;
END;
GO

CREATE PROCEDURE sp_Clientes_SelectAll
AS
BEGIN
    SELECT ClienteID, Nombre, Apellido, DocumentoIdentidad, Email, Telefono, Direccion, FechaRegistro 
    FROM Clientes WHERE Activo = 1;
END;
GO

CREATE PROCEDURE sp_Clientes_SelectById
    @ClienteID INT
AS
BEGIN
    SELECT ClienteID, Nombre, Apellido, DocumentoIdentidad, Email, Telefono, Direccion, FechaRegistro 
    FROM Clientes WHERE ClienteID = @ClienteID;
END;
GO

CREATE PROCEDURE sp_Clientes_Update
    @ClienteID INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DocumentoIdentidad VARCHAR(20),
    @Email VARCHAR(150),
    @Telefono VARCHAR(20),
    @Direccion VARCHAR(250)
AS
BEGIN
    UPDATE Clientes
    SET Nombre = @Nombre, Apellido = @Apellido, DocumentoIdentidad = @DocumentoIdentidad,
        Email = @Email, Telefono = @Telefono, Direccion = @Direccion
    WHERE ClienteID = @ClienteID;
END;
GO

-- Eliminación lógica (soft delete): preserva la integridad de Pedidos
-- que ya referencian este cliente.
CREATE PROCEDURE sp_Clientes_Delete
    @ClienteID INT
AS
BEGIN
    UPDATE Clientes SET Activo = 0 WHERE ClienteID = @ClienteID;
END;
GO

-- ----- 3.6. TABLA: Productos -----
CREATE PROCEDURE sp_Productos_Insert
    @NombreProducto VARCHAR(150),
    @PrecioUnitario DECIMAL(18,2),
    @Stock INT,
    @CategoriaID INT,
    @ProveedorID INT,
    @Activo BIT = 1
AS
BEGIN
    INSERT INTO Productos (NombreProducto, PrecioUnitario, Stock, CategoriaID, ProveedorID, Activo)
    VALUES (@NombreProducto, @PrecioUnitario, @Stock, @CategoriaID, @ProveedorID, @Activo);
    SELECT SCOPE_IDENTITY() AS ProductoID;
END;
GO

CREATE PROCEDURE sp_Productos_SelectAll
AS
BEGIN
    SELECT P.ProductoID, P.NombreProducto, P.PrecioUnitario, P.Stock, 
           P.CategoriaID, C.NombreCategoria, P.ProveedorID, PR.NombreComercial AS Proveedor, P.Activo
    FROM Productos P
    INNER JOIN Categorias C ON P.CategoriaID = C.CategoriaID
    INNER JOIN Proveedores PR ON P.ProveedorID = PR.ProveedorID
    WHERE P.Activo = 1;
END;
GO

CREATE PROCEDURE sp_Productos_SelectById
    @ProductoID INT
AS
BEGIN
    SELECT ProductoID, NombreProducto, PrecioUnitario, Stock, CategoriaID, ProveedorID, Activo 
    FROM Productos WHERE ProductoID = @ProductoID;
END;
GO

CREATE PROCEDURE sp_Productos_Update
    @ProductoID INT,
    @NombreProducto VARCHAR(150),
    @PrecioUnitario DECIMAL(18,2),
    @Stock INT,
    @CategoriaID INT,
    @ProveedorID INT,
    @Activo BIT
AS
BEGIN
    UPDATE Productos
    SET NombreProducto = @NombreProducto, PrecioUnitario = @PrecioUnitario, Stock = @Stock,
        CategoriaID = @CategoriaID, ProveedorID = @ProveedorID, Activo = @Activo
    WHERE ProductoID = @ProductoID;
END;
GO

CREATE PROCEDURE sp_Productos_Delete
    @ProductoID INT
AS
BEGIN
    UPDATE Productos SET Activo = 0 WHERE ProductoID = @ProductoID;
END;
GO

-- ----- 3.7. TABLA: Pedidos -----
CREATE PROCEDURE sp_Pedidos_Insert
    @ClienteID INT,
    @EmpleadoID INT,
    @EstadoID INT,
    @MontoTotal DECIMAL(18,2) = 0.00
AS
BEGIN
    INSERT INTO Pedidos (ClienteID, EmpleadoID, EstadoID, MontoTotal)
    VALUES (@ClienteID, @EmpleadoID, @EstadoID, @MontoTotal);
    SELECT SCOPE_IDENTITY() AS PedidoID;
END;
GO

CREATE PROCEDURE sp_Pedidos_SelectAll
AS
BEGIN
    SELECT P.PedidoID, P.FechaPedido, P.MontoTotal,
           C.ClienteID, (C.Nombre + ' ' + ISNULL(C.Apellido, '')) AS ClienteNombre,
           E.EmpleadoID, (E.Nombre + ' ' + E.Apellido) AS EmpleadoNombre,
           EP.EstadoID, EP.NombreEstado
    FROM Pedidos P
    INNER JOIN Clientes C ON P.ClienteID = C.ClienteID
    INNER JOIN Empleados E ON P.EmpleadoID = E.EmpleadoID
    INNER JOIN EstadosPedido EP ON P.EstadoID = EP.EstadoID;
END;
GO

-- Listado resumido a nivel de Pedido (usado por la pantalla de Pedidos):
-- un renglón por pedido con el conteo de productos y el total, en vez
-- de un renglón por cada producto del detalle.
CREATE PROCEDURE sp_Pedidos_SelectAllResumen
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.PedidoID, c.Nombre AS Cliente, e.Nombre AS Empleado,
           COUNT(dp.DetalleID) AS CantidadProductos, p.MontoTotal AS Total, p.FechaPedido
    FROM Pedidos p
    INNER JOIN Clientes c ON p.ClienteID = c.ClienteID
    LEFT JOIN Empleados e ON p.EmpleadoID = e.EmpleadoID
    LEFT JOIN DetallePedido dp ON p.PedidoID = dp.PedidoID
    GROUP BY p.PedidoID, c.Nombre, e.Nombre, p.MontoTotal, p.FechaPedido
    ORDER BY p.PedidoID DESC;
END;
GO

-- Cabecera simple de un pedido (ClienteID/EmpleadoID), usada al editar
-- un pedido en la pantalla de carrito de productos.
CREATE PROCEDURE sp_Pedidos_SelectCabeceraById
    @PedidoID INT
AS
BEGIN
    SELECT PedidoID, ClienteID, EmpleadoID FROM Pedidos WHERE PedidoID = @PedidoID;
END;
GO

CREATE PROCEDURE sp_Pedidos_Update
    @PedidoID INT,
    @ClienteID INT,
    @EmpleadoID INT,
    @EstadoID INT,
    @MontoTotal DECIMAL(18,2)
AS
BEGIN
    UPDATE Pedidos
    SET ClienteID = @ClienteID, EmpleadoID = @EmpleadoID, 
        EstadoID = @EstadoID, MontoTotal = @MontoTotal
    WHERE PedidoID = @PedidoID;
END;
GO

CREATE PROCEDURE sp_Pedidos_Delete
    @PedidoID INT
AS
BEGIN
    DELETE FROM Pedidos WHERE PedidoID = @PedidoID;
END;
GO

-- ----- 3.8. TABLA: DetallePedido -----
CREATE PROCEDURE sp_DetallePedido_Insert
    @PedidoID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(18,2)
AS
BEGIN
    INSERT INTO DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (@PedidoID, @ProductoID, @Cantidad, @PrecioUnitario);
    
    -- Actualizar el total en el Encabezado del Pedido
    UPDATE Pedidos 
    SET MontoTotal = (SELECT SUM(Subtotal) FROM DetallePedido WHERE PedidoID = @PedidoID)
    WHERE PedidoID = @PedidoID;

    -- Descontar el Stock del producto
    UPDATE Productos
    SET Stock = Stock - @Cantidad
    WHERE ProductoID = @ProductoID;

    SELECT SCOPE_IDENTITY() AS DetalleID;
END;
GO

CREATE PROCEDURE sp_DetallePedido_SelectByPedido
    @PedidoID INT
AS
BEGIN
    SELECT D.DetalleID, D.PedidoID, D.ProductoID, P.NombreProducto, D.Cantidad, D.PrecioUnitario, D.Subtotal
    FROM DetallePedido D
    INNER JOIN Productos P ON D.ProductoID = P.ProductoID
    WHERE D.PedidoID = @PedidoID;
END;
GO

CREATE PROCEDURE sp_DetallePedido_Update
    @DetalleID INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(18,2)
AS
BEGIN
    DECLARE @PedidoID INT;
    SELECT @PedidoID = PedidoID FROM DetallePedido WHERE DetalleID = @DetalleID;

    UPDATE DetallePedido
    SET Cantidad = @Cantidad, PrecioUnitario = @PrecioUnitario
    WHERE DetalleID = @DetalleID;

    -- Recalcular el total del Pedido
    UPDATE Pedidos 
    SET MontoTotal = ISNULL((SELECT SUM(Subtotal) FROM DetallePedido WHERE PedidoID = @PedidoID), 0)
    WHERE PedidoID = @PedidoID;
END;
GO

CREATE PROCEDURE sp_DetallePedido_Delete
    @DetalleID INT
AS
BEGIN
    DECLARE @PedidoID INT;
    SELECT @PedidoID = PedidoID FROM DetallePedido WHERE DetalleID = @DetalleID;

    DELETE FROM DetallePedido WHERE DetalleID = @DetalleID;

    -- Recalcular el total del Pedido tras la eliminación
    UPDATE Pedidos 
    SET MontoTotal = ISNULL((SELECT SUM(Subtotal) FROM DetallePedido WHERE PedidoID = @PedidoID), 0)
    WHERE PedidoID = @PedidoID;
END;
GO

-- Elimina todo el detalle de un pedido de una sola vez. Se usa al Editar
-- un pedido existente: se limpia el detalle viejo y se reinserta el
-- nuevo dentro de una transacción (ver PedidoDAL.ActualizarPedidoConDetalle).
CREATE PROCEDURE sp_DetallePedido_DeleteByPedido
    @PedidoID INT
AS
BEGIN
    DELETE FROM DetallePedido WHERE PedidoID = @PedidoID;
    UPDATE Pedidos SET MontoTotal = 0 WHERE PedidoID = @PedidoID;
END;
GO

-- ============================================================================
-- 4. PROCEDIMIENTO ALMACENADO AVANZADO (REPORTE CON JOIN DE 7 TABLAS)
-- Requisito de la prueba: Cruzar un mínimo de 4 tablas
-- ============================================================================

CREATE PROCEDURE sp_ReporteConsolidadoPedidos
    @FechaInicio DATETIME = NULL,
    @FechaFin DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.PedidoID,
        P.FechaPedido,
        (C.Nombre + ' ' + ISNULL(C.Apellido, '')) AS NombreCliente,
        C.DocumentoIdentidad AS DocumentoCliente,
        C.Email AS EmailCliente,
        (E.Nombre + ' ' + E.Apellido) AS NombreEmpleado,
        EP.NombreEstado AS EstadoPedido,
        PR.NombreProducto,
        CAT.NombreCategoria,
        DP.Cantidad,
        DP.PrecioUnitario AS PrecioVentaUnitario,
        DP.Subtotal AS SubtotalProducto,
        P.MontoTotal AS TotalPedido
    FROM Pedidos P
    INNER JOIN Clientes C ON P.ClienteID = C.ClienteID
    INNER JOIN Empleados E ON P.EmpleadoID = E.EmpleadoID
    INNER JOIN EstadosPedido EP ON P.EstadoID = EP.EstadoID
    INNER JOIN DetallePedido DP ON P.PedidoID = DP.PedidoID
    INNER JOIN Productos PR ON DP.ProductoID = PR.ProductoID
    INNER JOIN Categorias CAT ON PR.CategoriaID = CAT.CategoriaID
    WHERE (@FechaInicio IS NULL OR P.FechaPedido >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaPedido <= @FechaFin)
    ORDER BY P.PedidoID DESC, DP.DetalleID ASC;
END;
GO