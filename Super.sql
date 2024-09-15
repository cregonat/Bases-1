CREATE DATABASE `Super` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `Cond_IVA` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Provincias` (
  `Id` int NOT NULL,
  `NProvincia` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Clientes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombres` varchar(50) NOT NULL,
  `Apellidos` varchar(50) NOT NULL,
  `Id_CondIva` int NOT NULL,
  `Domicilio` varchar(50) DEFAULT NULL,
  `Localidad` varchar(50) DEFAULT NULL,
  `Id_Provincia` int DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Clientes_Cond_IVA_FK` (`Id_CondIva`),
  KEY `Clientes_Provincias_FK` (`Id_Provincia`),
  CONSTRAINT `Clientes_Cond_IVA_FK` FOREIGN KEY (`Id_CondIva`) REFERENCES `Cond_IVA` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Clientes_Provincias_FK` FOREIGN KEY (`Id_Provincia`) REFERENCES `Provincias` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Roles` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `NRol` varchar(30) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `RolesCliente` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `IdCliente` int NOT NULL,
  `IdRol` int NOT NULL,
  `FechaAlta` date NOT NULL,
  `FechaBaja` date DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `RolesCliente_Clientes_FK` (`IdCliente`),
  KEY `RolesCliente_Roles_FK` (`IdRol`),
  CONSTRAINT `RolesCliente_Clientes_FK` FOREIGN KEY (`IdCliente`) REFERENCES `Clientes` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RolesCliente_Roles_FK` FOREIGN KEY (`IdRol`) REFERENCES `Roles` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Categorias` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `NCategoria` varchar(60) NOT NULL,
  `FechaAlta` date NOT NULL,
  `FechaBaja` date DEFAULT NULL,
  `IdCatPadre` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Categorias_Categorias_FK` (`IdCatPadre`),
  CONSTRAINT `Categorias_Categorias_FK` FOREIGN KEY (`IdCatPadre`) REFERENCES `Categorias` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Productos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(100) NOT NULL,
  `Presentacion` varchar(60) DEFAULT NULL,
  `IdCategoria` int DEFAULT NULL,
  `Alic_IVA` decimal(8,2) NOT NULL DEFAULT '21.00',
  PRIMARY KEY (`Id`),
  KEY `Productos_Categorias_FK` (`IdCategoria`),
  CONSTRAINT `Productos_Categorias_FK` FOREIGN KEY (`IdCategoria`) REFERENCES `Categorias` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Ventas` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `IdCliente` int NOT NULL,
  `Fecha` date NOT NULL,
  `Tipo` char(5) NOT NULL,
  `Numero` char(14) NOT NULL,
  `NetoGravado` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Iva` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Impuestos` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Total` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Observaciones` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Ventas_Clientes_FK` (`IdCliente`),
  CONSTRAINT `Ventas_Clientes_FK` FOREIGN KEY (`IdCliente`) REFERENCES `Clientes` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ItemsVenta` (
  `IdVenta` int NOT NULL,
  `Item` int NOT NULL,
  `IdProducto` int NOT NULL,
  `Cantidad` decimal(12,2) NOT NULL DEFAULT '0.00',
  `Precio` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Impuestos` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `Subtotal` decimal(18,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`IdVenta`,`Item`),
  KEY `ItemsVenta_Productos_FK` (`IdProducto`),
  CONSTRAINT `ItemsVenta_Productos_FK` FOREIGN KEY (`IdProducto`) REFERENCES `Productos` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ItemsVenta_Ventas_FK` FOREIGN KEY (`IdVenta`) REFERENCES `Ventas` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;