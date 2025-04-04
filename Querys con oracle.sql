--PARA FILTRAR POR UNA FECHA MENOR A TANTO--
SELECT *
FROM EDW.REGISTRO_MARTES rm 
WHERE lower(verbo) = 'ingreso_dni' AND FECHA_INSERCION < TO_DATE('2023-05-30 12:49:00','yyyy/mm/dd hh24:mi:ss')

--PARA FILTRAR ENTRE DISTINTAS FECHAS--
SELECT FECHA_INSERCION 
FROM EDW.REGISTRO_LUNES 
WHERE lower(verbo) = 'ingreso_dni' 
AND FECHA_INSERCION 
BETWEEN TO_DATE('2023-05-29 00:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE('2023-05-29 00:04:00','yyyy/mm/dd hh24:mi:ss')

--PARA LIMITAR LA CANTIDAD DE COLUMNAS--
SELECT  *
FROM EDW.REGISTRO_MARTES rm 
WHERE lower(verbo) = 'ingreso_dni' AND ROWNUM <= 3;


--PARA HACER UN COUNT PARTICIONAD POR UN CAMPO--
SELECT COD_PRODUCTO , FECHA_DIA_HORA ,BITMAP ,count(*) OVER(partition by COD_PRODUCTO ) AS WIN
FROM EDW.REGISTRO_LUNES rl 
WHERE lower(verbo) = 'oferta_status' 

--PARA CHEQUEAR INGESTAS POR RANGO HORARI--
SELECT FECHA_DIA_HORA, BITMAP, BACKEND_OPERACION, COD_REFERIDO FROM edw.REGISTRO_LUNES rl 
WHERE lower(VERBO) = 'captura_dni' AND FECHA_DIA_HORA BETWEEN '2024/04/15 19:00:00' AND '2024/04/15 23:59:48'

-PARA CHEQUEAR COUNT DIFERENCIADO POR FECHA--
SELECT COUNT(*), substr(FECHA_DIA_HORA,1,10) fecha
FROM edw.REGISTRO_LUNES rl 
WHERE lower(VERBO) = 'captura_dni' AND BITMAP = 1 
GROUP BY substr(FECHA_DIA_HORA,1,10) 