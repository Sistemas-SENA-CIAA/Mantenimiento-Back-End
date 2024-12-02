-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema railway
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema railway
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `railway` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `railway` ;

-- -----------------------------------------------------
-- Table `railway`.`sedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`sedes` (
  `id_sede` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_sede`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`subsedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`subsedes` (
  `id_subsede` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `id_sede` INT NULL DEFAULT '1',
  PRIMARY KEY (`id_subsede`),
  INDEX `FK_76141927b1a2bb3525a7aa43f16` (`id_sede` ASC),
  CONSTRAINT `FK_76141927b1a2bb3525a7aa43f16`
    FOREIGN KEY (`id_sede`)
    REFERENCES `railway`.`sedes` (`id_sede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`dependencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`dependencias` (
  `id_dependencia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `id_subsede` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_dependencia`),
  INDEX `FK_7d4b8ad59d53adc39f6023f10d7` (`id_subsede` ASC),
  CONSTRAINT `FK_7d4b8ad59d53adc39f6023f10d7`
    FOREIGN KEY (`id_subsede`)
    REFERENCES `railway`.`subsedes` (`id_subsede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`ambientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`ambientes` (
  `id_ambiente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `id_dependencia` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_ambiente`),
  INDEX `FK_7094040f559cc6d87bfa00ce896` (`id_dependencia` ASC),
  CONSTRAINT `FK_7094040f559cc6d87bfa00ce896`
    FOREIGN KEY (`id_dependencia`)
    REFERENCES `railway`.`dependencias` (`id_dependencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`estados` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`usuarios` (
  `documento` INT NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `observaciones` TEXT NOT NULL,
  `correo` VARCHAR(80) NOT NULL,
  `contrasenia` VARCHAR(255) NOT NULL,
  `tokenRestablecerContrasenia` VARCHAR(255) NULL,
  `tokenRestablecerExpiracion` DATE NULL,
  `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `estado_id` INT NULL DEFAULT '1',
  PRIMARY KEY (`documento`),
  INDEX `FK_4200e8e20ae3c566e215e61baf4` (`estado_id` ASC),
  CONSTRAINT `FK_4200e8e20ae3c566e215e61baf4`
    FOREIGN KEY (`estado_id`)
    REFERENCES `railway`.`estados` (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`mantenimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`mantenimientos` (
  `id_mantenimiento` INT NOT NULL AUTO_INCREMENT,
  `objetivo` TEXT NOT NULL,
  `tipoMantenimiento` VARCHAR(50) NOT NULL,
  `fecha_prox_mantenimiento` DATE NOT NULL,
  `fecha_ultimo_mantenimiento` DATE NOT NULL,
  `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `usuario_documento` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_mantenimiento`),
  INDEX `FK_f15893a3657c9249fdf9d0187e4` (`usuario_documento` ASC),
  CONSTRAINT `FK_f15893a3657c9249fdf9d0187e4`
    FOREIGN KEY (`usuario_documento`)
    REFERENCES `railway`.`usuarios` (`documento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`cuentadantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`cuentadantes` (
  `documento` INT NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `dependencia` VARCHAR(30) NOT NULL,
  `departamento` VARCHAR(30) NOT NULL,
  `tipo_contrato` VARCHAR(30) NOT NULL,
  `estado_id` INT NULL DEFAULT '1',
  PRIMARY KEY (`documento`),
  INDEX `FK_b4b264001e9075df4a6bfa33612` (`estado_id` ASC),
  CONSTRAINT `FK_b4b264001e9075df4a6bfa33612`
    FOREIGN KEY (`estado_id`)
    REFERENCES `railway`.`estados` (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`tipo_equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`tipo_equipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`equipos` (
  `serial` VARCHAR(255) NOT NULL,
  `marca` VARCHAR(60) NOT NULL,
  `referencia` VARCHAR(100) NOT NULL,
  `fecha_compra` DATE NOT NULL,
  `placa_sena` VARCHAR(30) NOT NULL,
  `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `tipo_id` INT NULL DEFAULT NULL,
  `cuentadante_documento` INT NULL DEFAULT NULL,
  `estado_id` INT NULL DEFAULT '1',
  `sede_id` INT NULL DEFAULT NULL,
  `subsede_id` INT NULL DEFAULT NULL,
  `dependencia_id` INT NULL DEFAULT NULL,
  `ambiente_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`serial`),
  INDEX `FK_d1afbbe5151cc8c209aa9d8b0e7` (`tipo_id` ASC),
  INDEX `FK_4dda5f6ce77f10ae229ae5a88b9` (`cuentadante_documento` ASC),
  INDEX `FK_77156d30242ebf5df5ec212cfeb` (`estado_id` ASC),
  INDEX `FK_af395b18ce1e1c26a2717b3de06` (`sede_id` ASC),
  INDEX `FK_cc29dec97a2a571df23049ff9cd` (`subsede_id` ASC),
  INDEX `FK_406546b415d0c475a59d666ebb8` (`dependencia_id` ASC),
  INDEX `FK_e0d63e3fc46e92ae98824d4258e` (`ambiente_id` ASC),
  CONSTRAINT `FK_406546b415d0c475a59d666ebb8`
    FOREIGN KEY (`dependencia_id`)
    REFERENCES `railway`.`dependencias` (`id_dependencia`),
  CONSTRAINT `FK_4dda5f6ce77f10ae229ae5a88b9`
    FOREIGN KEY (`cuentadante_documento`)
    REFERENCES `railway`.`cuentadantes` (`documento`),
  CONSTRAINT `FK_77156d30242ebf5df5ec212cfeb`
    FOREIGN KEY (`estado_id`)
    REFERENCES `railway`.`estados` (`id_estado`),
  CONSTRAINT `FK_af395b18ce1e1c26a2717b3de06`
    FOREIGN KEY (`sede_id`)
    REFERENCES `railway`.`sedes` (`id_sede`),
  CONSTRAINT `FK_cc29dec97a2a571df23049ff9cd`
    FOREIGN KEY (`subsede_id`)
    REFERENCES `railway`.`subsedes` (`id_subsede`),
  CONSTRAINT `FK_d1afbbe5151cc8c209aa9d8b0e7`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `railway`.`tipo_equipos` (`id`),
  CONSTRAINT `FK_e0d63e3fc46e92ae98824d4258e`
    FOREIGN KEY (`ambiente_id`)
    REFERENCES `railway`.`ambientes` (`id_ambiente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`chequeos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`chequeos` (
  `id_chequeo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  `observaciones` VARCHAR(150) NOT NULL,
  `equipo_serial` VARCHAR(255) NULL DEFAULT NULL,
  `mantenimiento_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_chequeo`),
  INDEX `FK_abc379a3c80c0a9d031d214e5ad` (`equipo_serial` ASC),
  INDEX `FK_7c76cfa7a670b16d74a83e4ffab` (`mantenimiento_id` ASC),
  CONSTRAINT `FK_7c76cfa7a670b16d74a83e4ffab`
    FOREIGN KEY (`mantenimiento_id`)
    REFERENCES `railway`.`mantenimientos` (`id_mantenimiento`),
  CONSTRAINT `FK_abc379a3c80c0a9d031d214e5ad`
    FOREIGN KEY (`equipo_serial`)
    REFERENCES `railway`.`equipos` (`serial`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`mantenimientos_equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`mantenimientos_equipos` (
  `equipo_serial` VARCHAR(255) NOT NULL,
  `mantenimiento_id` INT NOT NULL,
  PRIMARY KEY (`equipo_serial`, `mantenimiento_id`),
  INDEX `IDX_247937ec9d54921ab44b51ff80` (`equipo_serial` ASC),
  INDEX `IDX_fe904f917f91d85eb3de4134fb` (`mantenimiento_id` ASC),
  CONSTRAINT `FK_247937ec9d54921ab44b51ff806`
    FOREIGN KEY (`equipo_serial`)
    REFERENCES `railway`.`equipos` (`serial`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_fe904f917f91d85eb3de4134fbd`
    FOREIGN KEY (`mantenimiento_id`)
    REFERENCES `railway`.`mantenimientos` (`id_mantenimiento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `railway`.`roles_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `railway`.`roles_usuarios` (
  `usuario_documento` INT NOT NULL,
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`usuario_documento`, `rol_id`),
  INDEX `IDX_c07731303027ebe99490e9b429` (`usuario_documento` ASC),
  INDEX `IDX_854ba38c5dd2d031578675a012` (`rol_id` ASC),
  CONSTRAINT `FK_854ba38c5dd2d031578675a0120`
    FOREIGN KEY (`rol_id`)
    REFERENCES `railway`.`roles` (`id`),
  CONSTRAINT `FK_c07731303027ebe99490e9b429c`
    FOREIGN KEY (`usuario_documento`)
    REFERENCES `railway`.`usuarios` (`documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- CONFIGURACIONES POR DEFECTO EN LA DB
-- -----------------------------------------------------
INSERT INTO estados VALUES (1, 1);
INSERT INTO estados VALUES (2, 0);
INSERT INTO sedes VALUES (1, 'CIAA');
INSERT INTO roles (id, nombre) VALUES (1, 'ADMINISTRADOR');
INSERT INTO roles (id, nombre) VALUES (2, 'TÉCNICO EN CAMPO');
INSERT INTO roles (id, nombre) VALUES (3, 'USUARIO DE CONSULTA');

ALTER TABLE usuarios ALTER COLUMN estado_id SET DEFAULT 1;
ALTER TABLE cuentadantes ALTER COLUMN estado_id SET DEFAULT 1;
ALTER TABLE equipos ALTER COLUMN estado_id SET DEFAULT 1;
ALTER TABLE equipos ALTER COLUMN sede_id SET DEFAULT 1;

