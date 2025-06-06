DROP DATABASE pizza_fiesta;
CREATE DATABASE IF NOT EXISTS pizza_fiesta;
SHOW DATABASES;
USE pizza_fiesta;
SHOW TABLES;

CREATE TABLE IF NOT EXISTS usuarios(
    usuario_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    telefono INT(14) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS pedidos(
    pedido_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cliente_id INT,
    producto_id INT,
    fecha_pedido DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES  usuarios(usuario_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; 

CREATE TABLE IF NOT EXISTS ingredientes(
    ingrediente_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS productos(
    producto_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ingredientes_id INT NULL ,
    nombre VARCHAR(40) NOT NULL,
    tamaño ENUM("grande","mediano","pequeño") NOT NULL DEFAULT "mediano",
    precio DECIMAL NOT NULL,
    FOREIGN KEY (ingredientes_id) REFERENCES ingredientes(ingrediente_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
    
CREATE TABLE IF NOT EXISTS detalle_pedido(
    detalle_pedido_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    pedido_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL NOT NULL,
    ingrediente_extra VARCHAR(40) NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS pago(
    pago_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    pedido_id INT NOT NULL,
    estado ENUM("espera","pago","cancelado") DEFAULT "espera",
    FOREIGN KEY (cliente_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS envio(
    envio_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    pago_id INT NOT NULL,
    cliente_id INT NOT NULL,
    estado_envio ENUM("espera", "cancelado","entregado"),
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id),
    FOREIGN KEY (cliente_id) REFERENCES  usuarios(usuario_id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SHOW TABLES;