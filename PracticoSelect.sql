
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
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;