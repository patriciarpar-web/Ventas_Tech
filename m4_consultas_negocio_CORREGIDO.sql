-- ============================================================
-- M4 - CONSULTAS SQL DE NEGOCIO
-- Base: Ventas_Tech_DB
-- ============================================================

-- ============================================================
-- CONSULTA 1 - RESUMEN EJECUTIVO MENSUAL
-- Total facturado, cantidad de órdenes y ticket promedio por mes.
-- ============================================================

SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_ordenes,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;


-- ============================================================
-- CONSULTA 2 - TOP 5 PRODUCTOS POR FACTURACIÓN
-- ============================================================

SELECT
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;


-- ============================================================
-- CONSULTA 3 - CLIENTES RECURRENTES
-- Clientes con más de una orden.
-- ============================================================

SELECT
    id_cliente,
    COUNT(*) AS cantidad_ordenes,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY cantidad_ordenes DESC, total_gastado DESC;


-- ============================================================
-- CONSULTA 4 - MESES POR ENCIMA / POR DEBAJO DEL PROMEDIO
-- ============================================================

WITH facturacion_mensual AS (
    SELECT
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM facturacion_mensual)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_con_promedio
FROM facturacion_mensual
ORDER BY mes;


-- ============================================================
-- HALLAZGOS DE NEGOCIO
-- ============================================================
-- 1. El producto 1 fue el de mayor facturación, con $3.600 sobre un total
--    de $6.424 del período, representando el 56,04% de la facturación total.
--
-- 2. Los 5 clientes registrados realizaron más de un pedido, por lo que
--    todos califican como clientes recurrentes según el criterio de la consulta.
--    El cliente 1 registró el mayor gasto, con 2 pedidos por un total de $2.640.
--
-- 3. El promedio de facturación mensual fue de $1.284,80. Enero fue el mes
--    de mayor facturación, con $2.540, mientras que abril alcanzó $1.424.
--    Ambos meses quedaron por encima del promedio mensual; los otros tres
--    meses quedaron por debajo.
