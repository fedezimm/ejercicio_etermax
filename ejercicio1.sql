-- En este archivo SQL están las consignas del ejercicio 1. Lo hago en SQL, supongo que la sintaxis Redshift
-- es SQL o parecido.

-- Ejercicio 1.a

SELECT dm.fecha AS Fecha,
       dc.descripcion AS Descripcion_de_cliente,
       dpr.descripcion AS Descripcion_de_proveedor,
       dp.descripcion AS Descripcion_de_producto,
       dma.descripcion AS Descripcion_de_marca,
       dm.cantidad AS Cantidad,
       dm.costo AS Costo,
       dm.venta AS Venta,
       dm.venta - dm.costo AS Ganancia_neta
FROM Data_Movimientos dm INNER JOIN
     Data_Clientes dc ON dm.cod_cliente = dc.cod_cliente INNER JOIN
     Data_Productos dp ON dm.cod_prod = dp.cod_prod INNER JOIN
     Data_Marcas dma ON dma.cod_marca = dp.cod_marca INNER JOIN
     Data_Proveedores dpr ON dpr.cod_proveedor = dp.cod_proveedor

-- Ejercicio 1.b
SELECT DISTINCT dma.descripcion AS Marca_No_Vendida
FROM Data_Productos dp LEFT JOIN
	 Data_Movimientos dm ON dp.cod_prod=dm.cod_prod LEFT JOIN
     Data_Marcas dma ON dma.cod_marca=dp.cod_marca
WHERE dm.cod_prod IS NULL

-- Ejercicio 1.c

SELECT temp.Fecha AS Fecha,
       temp.Descripcion_de_cliente AS Cliente,
       SUM(temp.Ganancia_Neta) OVER (PARTITION BY temp.Descripcion_de_cliente ORDER BY temp.Fecha,temp.Descripcion_de_cliente
									 ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Ganancia_Neta_Acumulada_7 
FROM (SELECT dm.fecha AS Fecha,
             dc.descripcion AS Descripcion_de_cliente,
             dpr.descripcion AS Descripcion_de_proveedor,
             dp.descripcion AS Descripcion_de_producto,
             dma.descripcion AS Descripcion_de_marca,
             dm.cantidad AS Cantidad,
             dm.costo AS Costo,
             dm.venta AS Venta,
             dm.venta - dm.costo AS Ganancia_neta
      FROM Data_Movimientos dm INNER JOIN
           Data_Clientes dc ON dm.cod_cliente = dc.cod_cliente INNER JOIN
           Data_Productos dp ON dm.cod_prod = dp.cod_prod INNER JOIN
           Data_Marcas dma ON dma.cod_marca = dp.cod_marca INNER JOIN
           Data_Proveedores dpr ON dpr.cod_proveedor = dp.cod_proveedor) temp
ORDER BY Fecha, Cliente

    
