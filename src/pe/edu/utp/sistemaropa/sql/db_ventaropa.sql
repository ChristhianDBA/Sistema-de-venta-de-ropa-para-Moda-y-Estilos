-- MySQL Script generated by MySQL Workbench
-- Thu May 16 23:50:46 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Rol` INT NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendedor` (
  `IdVendedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Telefono` INT NOT NULL,
  `Dni` INT NOT NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdVendedor`),
  CONSTRAINT `fk_Vendedor_Usuario1`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `mydb`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Vendedor_Usuario1_idx` ON `mydb`.`Vendedor` (`IdUsuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Administrador` (
  `IdAdministrador` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Telefono` INT NOT NULL,
  `Dni` INT NOT NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdAdministrador`),
  CONSTRAINT `fk_Administrador_Usuario1`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `mydb`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Administrador_Usuario1_idx` ON `mydb`.`Administrador` (`IdUsuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveedor` (
  `IdProveedor` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Telefono` INT NOT NULL,
  `Direccion` VARCHAR(200) NOT NULL,
  `Razon` VARCHAR(200) NOT NULL,
  `Ruc` INT NOT NULL,
  `IdAdministrador` INT NOT NULL,
  PRIMARY KEY (`IdProveedor`),
  CONSTRAINT `fk_Proveedor_Administrador1`
    FOREIGN KEY (`IdAdministrador`)
    REFERENCES `mydb`.`Administrador` (`IdAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Proveedor_Administrador1_idx` ON `mydb`.`Proveedor` (`IdAdministrador` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT,
  `Dni` INT NOT NULL,
  `Nombre` VARCHAR(150) NOT NULL,
  `Apellido` VARCHAR(150) NOT NULL,
  `Telefono` INT NOT NULL,
  `Direccion` VARCHAR(200) NOT NULL,
  `Ruc` INT NOT NULL,
  PRIMARY KEY (`IdCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoDePago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoDePago` (
  `IdTipoDePago` INT NOT NULL AUTO_INCREMENT,
  `NombreTipoDePago` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`IdTipoDePago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venta` (
  `IdVenta` INT NOT NULL AUTO_INCREMENT,
  `Pago` DECIMAL(10,2) NOT NULL,
  `Vuelto` DECIMAL(10,2) NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `IdCliente` INT NOT NULL,
  `IdTipoDePago` INT NOT NULL,
  `IdVendedor` INT NOT NULL,
  PRIMARY KEY (`IdVenta`),
  CONSTRAINT `fk_Venta_Cliente`
    FOREIGN KEY (`IdCliente`)
    REFERENCES `mydb`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_TipoDePago1`
    FOREIGN KEY (`IdTipoDePago`)
    REFERENCES `mydb`.`TipoDePago` (`IdTipoDePago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Vendedor1`
    FOREIGN KEY (`IdVendedor`)
    REFERENCES `mydb`.`Vendedor` (`IdVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Venta_Cliente_idx` ON `mydb`.`Venta` (`IdCliente` ASC) VISIBLE;

CREATE INDEX `fk_Venta_TipoDePago1_idx` ON `mydb`.`Venta` (`IdTipoDePago` ASC) VISIBLE;

CREATE INDEX `fk_Venta_Vendedor1_idx` ON `mydb`.`Venta` (`IdVendedor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `IdProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Stock` INT NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `IdProveedor` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`IdProducto`),
  CONSTRAINT `fk_Producto_Proveedor1`
    FOREIGN KEY (`IdProveedor`)
    REFERENCES `mydb`.`Proveedor` (`IdProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Producto_Proveedor1_idx` ON `mydb`.`Producto` (`IdProveedor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`DetalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetalleVenta` (
  `IdDetalle` INT NOT NULL AUTO_INCREMENT,
  `Detalles` VARCHAR(200) NOT NULL,
  `IdVenta` INT NOT NULL,
  `IdProducto` INT NOT NULL,
  PRIMARY KEY (`IdDetalle`),
  CONSTRAINT `fk_Detalle_Venta1`
    FOREIGN KEY (`IdVenta`)
    REFERENCES `mydb`.`Venta` (`IdVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Producto1`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`IdProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Detalle_Venta1_idx` ON `mydb`.`DetalleVenta` (`IdVenta` ASC) VISIBLE;

CREATE INDEX `fk_Detalle_Producto1_idx` ON `mydb`.`DetalleVenta` (`IdProducto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial` (
  `idHistorial` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Dni` INT NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `Vuelto` DECIMAL(10,2) NOT NULL,
  `IdVenta` INT NOT NULL,
  PRIMARY KEY (`idHistorial`),
  CONSTRAINT `fk_Historial_Venta1`
    FOREIGN KEY (`IdVenta`)
    REFERENCES `mydb`.`Venta` (`IdVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Historial_Venta1_idx` ON `mydb`.`Historial` (`IdVenta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Dni` INT NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `Vuelto` DECIMAL(10,2) NOT NULL,
  `Venta_IdVenta` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `fk_Factura_Venta1`
    FOREIGN KEY (`Venta_IdVenta`)
    REFERENCES `mydb`.`Venta` (`IdVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Factura_Venta1_idx` ON `mydb`.`Factura` (`Venta_IdVenta` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
