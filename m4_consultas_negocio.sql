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
-- 1. El producto 1 presenta la mayor facturación acumulada del período analizado.
-- 2. Los clientes 1, 2, 3, 4 y 5 presentan distintos niveles de recurrencia,
--    permitiendo identificar clientes con más de una compra.
-- 3. La facturación mensual permite distinguir los meses que se encuentran
--    por encima o por debajo del promedio mensual del período.
