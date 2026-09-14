# Ventas_Tech_DB - M3 y M4

## M3 - Script SQL de Ingeniería de Datos

Archivo principal: `ventas_tech_db.sql`

Incluye:
- DROP TABLES en orden inverso a las dependencias.
- Creación de las tablas `categorias`, `clientes`, `productos` y `ventas`.
- Claves primarias y foráneas.
- Restricciones `NOT NULL`, `UNIQUE` y valores `DEFAULT`.
- Carga inicial de datos.
- Consultas `SELECT *` para verificación.

## M4 - Consultas SQL de negocio

Archivo: `m4_consultas_negocio.sql`

Incluye las cuatro consultas solicitadas:
1. Resumen ejecutivo mensual.
2. Top 5 productos por facturación.
3. Clientes recurrentes.
4. Meses por encima o por debajo del promedio mensual.

Las consultas de M4 trabajan únicamente sobre `ventas`, utilizando los identificadores de cliente y producto, tal como indica la consigna.

## Nota

El esquema de M3 fue ajustado para trabajar con `Ventas_Tech_DB`, separándolo del esquema conceptual de RetailPro utilizado en el proyecto final.
