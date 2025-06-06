-- Active: 1749210588196@@127.0.0.1@3320@mysql
SHOW TABLES;
DESCRIBE detalle_pedido; 
DESCRIBE envio;
DESCRIBE ingredientes;
DESCRIBE pago;
DESCRIBE pedidos;
DESCRIBE productos;

DESCRIBE usuarios;



--1 registrar cliente
INSERT INTO usuarios(nombre,direccion,email,telefono) VALUES ("elsa pato","calle 24 #23-12","elsapatico@gmail.com",320123043);

--2 agregar producto(pizza)
INSERT INTO productos(ingredientes_id,nombre,tamaño,precio) VALUES (1,"de peperoni","grande",24000);

--3 registrar bebida
INSERT INTO productos(nombre,tamaño,precio) VALUES ("coca cola","mediano",3200.39);ç

--4 añadir ingrediente
INSERT INTO ingredientes(nombre) VALUES("pepperoni");

--5 crear pedido
INSERT INTO pedidos(cliente_id,producto_id,fecha_pedido) VALUES(1,1,NOW());

--6 añadir productos a pedido
INSERT INTO detalle_pedido(producto_id,pedido_id,cantidad,precio_unitario) VALUES (1,1,11,24000);


--7 Añadir ingredientes adicionales a una pizza en un pedido:
SELECT * FROM pedidos;
INSERT INTO pedidos(cliente_id,producto_id,fecha_pedido) VALUES(1,1,NOW());
INSERT INTO detalle_pedido(producto_id,pedido_id,cantidad,precio_unitario,ingrediente_extra) VALUES (1,2,1,24000,"piña");

-- 8 Consultar el detalle de un pedido (productos y sus ingredientes):
INSERT INTO ingredientes(nombre) VALUES ("salami");
INSERT INTO productos(ingredientes_id,nombre,tamaño,precio) VALUES (2,"pizza salamita","mediano",2043.34);
INSERT INTO pedidos(cliente_id,producto_id,fecha_pedido) VALUES(1,2,NOW());
SELECT pedidos.pedido_id, productos.nombre
FROM detalle_pedido
JOIN pedidos ON detalle_pedido.pedido_id = pedidos.pedido_id
JOIN productos ON pedidos.producto_id = productos.producto_id;


--9 actualizar el precio de una pizza 


--11 Eliminar un producto del menú (bebida):
SELECT * FROM productos;
DELETE FROM productos WHERE producto_id = 2;

--12 Eliminar un ingrediente
SELECT * FROM  ingredientes;
DELETE FROM ingredientes WHERE ingredientes.ingrediente_id = 1

--13 Seleccionar todos los pedidos de un cliente
SELECT  *
FROM pedidos
WHERE pedidos.cliente_id = 1

--14 Listar todos los productos disponibles en el menú (pizzas y bebidas):
SELECT * 
FROM productos;

--15. **Listar todos los ingredientes disponibles para personalizar una pizza:**

SELECT * FROM ingredientes;

--16 Calcular el costo total de un pedido (incluyendo ingredientes adicionales):
SELECT pedidos.pedido_id,SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
FROM pedidos 
JOIN detalle_pedido dp ON pedidos.pedido_id = dp.pedido_id
GROUP BY pedidos.pedido_id;

--17. **Listar los clientes que han hecho más de 5 pedidos:**

SELECT 
    usuarios.usuario_id,
    usuarios.nombre,
    COUNT(pedidos.pedido_id) AS cantidad_pedidos
FROM usuarios
JOIN pedidos ON usuarios.usuario_id = pedidos.cliente_id
GROUP BY usuarios.usuario_id, usuarios.nombre
HAVING COUNT(pedidos.pedido_id) > 5;

-- 18. **Buscar pedidos programados para recogerse después de una hora específica:**

SELECT 
    pedidos.pedido_id,
    usuarios.nombre AS cliente,
    pedidos.fecha_pedido
FROM pedidos
JOIN usuarios ON pedidos.cliente_id = usuarios.usuario_id
WHERE pedidos.fecha_pedido > '2025-06-06 14:00:00';

-- 19. **Listar todos los combos de pizzas con bebidas disponibles en el menú:**


SELECT 
    pizza.nombre AS pizza,
    bebida.nombre AS bebida
FROM productos AS pizza
JOIN productos AS bebida ON pizza.producto_id != bebida.producto_id
WHERE pizza.ingredientes_id IS NOT NULL
  AND bebida.ingredientes_id IS NULL;
