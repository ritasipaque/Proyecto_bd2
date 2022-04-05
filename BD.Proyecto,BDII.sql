CREATE DATABASE  IF NOT EXISTS `BD_PROYECTO`;
USE `BD_PROYECTO`;


-- -----------------------------------------------------
-- INICIO MANTENIMIENTOS
-- --------------------------------------------------

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_usuario` (
usunombre VARCHAR(20) ,
password VARCHAR(32) NOT NULL,
PRIMARY KEY (`usunombre`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;



CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_proveedor` (
`PK_codigo_proveedor` INT NOT NULL,
`nombre_proveedor` VARCHAR(35) NULL DEFAULT NULL,
`direccion_proveedor` VARCHAR(35) NULL DEFAULT NULL,
`telefono_proveedor` VARCHAR(35) NULL DEFAULT NULL,
`nit_proveedor` INT NOT NULL,
`email_proveedor` VARCHAR(35) NULL DEFAULT NULL,
`representante_proveedor` VARCHAR(35) NULL DEFAULT NULL,
`estatus_proveedor` TINYINT NOT NULL,
PRIMARY KEY (`PK_codigo_proveedor`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_cliente` (
`PK_codigo_cliente`  INT  NOT NULL ,
`nombre_cliente` VARCHAR(35) NULL ,
`direccion_cliente` VARCHAR(35) NULL DEFAULT NULL,
`telefono_cliente` VARCHAR(35) NULL DEFAULT NULL,
`nit_cliente` INT DEFAULT NULL,
`email_cliente` VARCHAR(35) NULL DEFAULT NULL,
`estatus_cliente` TINYINT NOT NULL,
PRIMARY KEY (`PK_codigo_cliente`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_producto` (
`PK_codigo_producto` INT NOT NULL,
`nombre_producto` VARCHAR(35) NULL DEFAULT NULL,
`cantidad_producto` INT NOT NULL,
`precio_producto` INT NOT NULL,
`stock_producto` INT NOT NULL,
`estatus_producto` TINYINT NOT NULL,
PRIMARY KEY (`PK_codigo_producto`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_metodo_de_pago` (
`PK_codigo_pago` INT NOT NULL,
`nombre_metodo` VARCHAR(50) NOT NULL,
`descripcion_metodo` VARCHAR(100) NOT NULL,
`estado_metodo` TINYINT NOT NULL,
PRIMARY KEY (`PK_codigo_pago`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- INICIO TRANSACCIONALES
-- --------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_compra` (
`PK_codigo_factura` INT NOT NULL,
`codigo_proveedor` INT NOT NULL,
`fecha_emision` DATE DEFAULT NULL,
`fecha_vencimiento` DATE DEFAULT NULL,
`codigo_pago` INT NOT NULL,
`estatus_factura` TINYINT NOT NULL,
PRIMARY KEY (
`PK_codigo_factura`

),
FOREIGN KEY (`codigo_proveedor`)
REFERENCES `BD_PROYECTO`.`tbl_proveedor` (`PK_codigo_proveedor`),
FOREIGN KEY (`codigo_pago`)
REFERENCES `BD_PROYECTO`.`tbl_metodo_de_pago` (`PK_codigo_pago`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_compra_detalle` (
`correlativo` INT AUTO_INCREMENT,
`PK_codigo_factura` INT NOT NULL,
`PK_codigo_producto` INT NOT NULL,
`cantidad_detalle` INT NOT NULL,
`costo_detalle` INT NOT NULL,
`total_detalle` INT NOT NULL,
PRIMARY KEY (
`correlativo`,
`PK_codigo_factura`,
`PK_codigo_producto` 

),
FOREIGN KEY (`Pk_codigo_factura`)
REFERENCES `BD_PROYECTO`.`tbl_compra` (`PK_codigo_factura`),
FOREIGN KEY (`Pk_codigo_producto`)
REFERENCES `BD_PROYECTO`.`tbl_producto` (`PK_codigo_producto`)

)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_ordencompra_encabezado` (
`PK_codigo_ordencompra` INT NOT NULL,
`codigo_proveedor` INT NOT NULL,
`fecha_emision` DATE DEFAULT NULL,
`fecha_entrega` DATE DEFAULT NULL,
`codigo_pago`INT NOT NULL,
`estatus_ordencompra` TINYINT NOT NULL,
PRIMARY KEY (
`PK_codigo_ordencompra`
),
FOREIGN KEY (`codigo_proveedor`)
REFERENCES `BD_PROYECTO`.`tbl_proveedor` (`PK_codigo_proveedor`),
FOREIGN KEY (`codigo_pago`)
REFERENCES `BD_PROYECTO`.`tbl_metodo_de_pago` (`PK_codigo_pago`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_ordencompra_detalle` (
`correlativo` INT AUTO_INCREMENT,
`PK_codigo_ordencompra` INT NOT NULL,
`PK_codigo_producto` INT NOT NULL,
`cantidad_detalle` INT NOT NULL,
`costo_detalle` INT NOT NULL,
`total_detalle` INT NOT NULL,
PRIMARY KEY (
`correlativo` ,
`PK_codigo_ordencompra`,
`PK_codigo_producto`),
FOREIGN KEY (`PK_codigo_ordencompra`)
REFERENCES `BD_PROYECTO`.`tbl_ordencompra_encabezado` (`PK_codigo_ordencompra`),
FOREIGN KEY (`Pk_codigo_producto`)
REFERENCES `BD_PROYECTO`.`tbl_producto` (`PK_codigo_producto`)
  )ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_devolucioncompra_encabezado` (
`PK_codigo_devolucioncompra` INT NOT NULL,
`PK_codigo_bodega` INT NOT NULL,
`codigo_proveedor` INT NOT NULL,
`fecha_emision` DATE DEFAULT NULL,
`fecha_entrega` DATE DEFAULT NULL,
`estatus_devolucion` TINYINT NOT NULL,
PRIMARY KEY (
`PK_codigo_devolucioncompra`
),
FOREIGN KEY (`codigo_proveedor`)
REFERENCES `empresarial`.`tbl_proveedor` (`PK_codigo_proveedor`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_devolucioncompra_detalle` (
`correlativo` INT AUTO_INCREMENT,
`PK_codigo_devolucioncompra` INT NOT NULL,
`PK_codigo_producto` INT NOT NULL,
`cantidad_detalle` INT NOT NULL,
`costo_detalle` INT NOT NULL,
`total_detalle` INT NOT NULL,
PRIMARY KEY (
`correlativo` ,
`PK_codigo_devolucioncompra`,
`PK_codigo_producto` 
),
FOREIGN KEY (`PK_codigo_devolucioncompra`)
REFERENCES `BD_PROYECTO`.`tbl_devolucioncompra_encabezado` (`PK_codigo_devolucioncompra`),
FOREIGN KEY (`Pk_codigo_producto`)
REFERENCES `BD_PROYECTO`.`tbl_producto` (`PK_codigo_producto`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_venta` (
`PK_codigo_factura` INT NOT NULL,
`codigo_cliente` INT NOT NULL,
`fecha_emision` DATE DEFAULT NULL,
`fecha_vencimiento` DATE DEFAULT NULL,
`codigo_pago` INT NOT NULL,
`estatus_factura` TINYINT NOT NULL,
PRIMARY KEY (
`PK_codigo_factura`

),
FOREIGN KEY (`codigo_cliente`)
REFERENCES `BD_PROYECTO`.`tbl_cliente` (`PK_codigo_cliente`),
FOREIGN KEY (`codigo_pago`)
REFERENCES `BD_PROYECTO`.`tbl_metodo_de_pago` (`PK_codigo_pago`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `BD_PROYECTO`.`tbl_venta_detalle` (
`correlativo` INT AUTO_INCREMENT,
`PK_codigo_factura` INT NOT NULL,
`PK_codigo_producto` INT NOT NULL,
`cantidad_detalle` INT NOT NULL,
`costo_detalle` INT NOT NULL,
`total_detalle` INT NOT NULL,
PRIMARY KEY (
`correlativo`,
`PK_codigo_factura`,
`PK_codigo_producto` 

),
FOREIGN KEY (`Pk_codigo_factura`)
REFERENCES `BD_PROYECTO`.`tbl_venta` (`PK_codigo_factura`),
FOREIGN KEY (`Pk_codigo_producto`)
REFERENCES `BD_PROYECTO`.`tbl_producto` (`PK_codigo_producto`)

)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;
