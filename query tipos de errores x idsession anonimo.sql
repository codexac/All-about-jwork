--CANTIDAD DE CAPTURAS DE DNI X ID SESSION ANONIMO--

select sum(t.result) as result,t.fecha,t.entity
from (
----- Query of prueba_vida
SELECT 1 as result,fecha, id_session_anonimo_edw,
case when bitmap_edw=0 then 'Q de intentos de selfie exitosos'
when bitmap_edw= 1 then 'Q de intentos de selfie fallidos' end 
as entity
FROM p_trusted.entity_onb
    WHERE evento_edw = 'prueba_vida' and fecha between 20230508 and 20230605
) as t
group by fecha, entity

---LISTAR LOS DISTINTOS TIPOS DE ERRORES EN SELFIE O PRUEBA VIDA--
select sum(t.result) as result,t.fecha,t.entity
from (
SELECT 1 as result,fecha, id_session_anonimo_edw, 
case when cod_referido_edw='OPRES100' then 'Captura de selfie Exitosa' 
when cod_referido_edw= 'OPRES300' then 'Renaper no identifico un rostro' 
when cod_referido_EDW = 'BUS00214' then 'Acepto el producto ofrecido' 
when cod_referido_edw = 'BUS00206' then 'Caido servicio de Renaper'
when cod_referido_Edw = 'BUS00211' then 'Renaper no identifico un rostro y supero los 3 intentos' 
when cod_referido_edw = 'BUS00108' then 'Timeout de Renaper' 
when cod_referido_edw = 'OPRES700' then 'Se rechaza la solicitud por intento de fraude' 
when cod_referido_edw = 'OPRES200' then 'Flujo finalizado con exito y notificación al usuario'
when cod_referido_edw = 'OPRES100' then 'Firma digital del contrato con el banco'
when cod_referido_edw = 'BUS00208' then 'La firma digital no pudo ser registrada'
when cod_referido_Edw = 'BUS00212' then 'Renaper no pudo evaluar' 
when cod_referido_Edw = 'EXC00207' then 'Error interno del servidor' 
when cod_referido_edw is null then 'No obtuvo respuesta del servicio'
when cod_referido_edw = 0 then 'No se puedo identificar un rostro por baja calidad en la foto' 
when cod_referido_edw = 999 then 'Falla en la conexión con MIDD'
else 'otros errores de captura' 
END as entity 
FROM p_trusted.entity_onb 
WHERE evento_edw = 'prueba_vida' and fecha between 20230508 and 20230605) as t
group by fecha, entity


