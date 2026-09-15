-- ============================================================
-- M5 - CONSULTAS CON JOINs
-- Base: Ventas_Tech_DB
-- ============================================================


-- ============================================================
-- CONSULTA 1 - VISTA BASE DEL PROYECTO
-- INNER JOIN
-- Ventas + Clientes + Productos + Categorías
-- ============================================================

SELECT
    v.fecha_venta AS fecha,
    v.id_cliente AS identificacion_cliente,
    c.nombre AS nombre_cliente,
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;


-- ============================================================
-- CONSULTA 2 - CLIENTES SIN VENTAS
-- LEFT JOIN + WHERE ... IS NULL
-- ============================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;


-- ============================================================
-- CONSULTA 3 - PRODUCTOS SIN VENTAS
-- LEFT JOIN + WHERE ... IS NULL
-- ============================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;


-- ============================================================
-- CONSULTA 4 - CONSOLIDADO POR CANAL
-- UNION ALL
--
-- La tabla ventas NO posee una columna canal.
-- El canal se crea mediante un valor literal.
--
-- Online: ventas de enero a marzo de 2024
-- Presencial: ventas de abril a mayo de 2024
-- ============================================================

WITH ventas_por_origen AS (

    SELECT
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-01-01'
      AND fecha_venta < '2024-04-01'

    UNION ALL

    SELECT
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-04-01'
      AND fecha_venta < '2024-06-01'
)

SELECT
    canal,
    SUM(total) AS total_facturado
FROM ventas_por_origen
GROUP BY canal
ORDER BY canal;


-- ============================================================
-- FIN M5
-- ============================================================