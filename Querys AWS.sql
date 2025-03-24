SELECT * FROM "standarized"."evento_aplicacion"
WHERE nu_anio = 2024 AND nu_mes = 3 AND nu_dia = 27
AND cd_evento = 'ingresoReferido'

SELECT * FROM "standarized"."evento_aplicacion"
WHERE nu_anio = 2024 AND nu_mes = 2 
AND cd_evento = 'encuestaAbandonoOnboarding'
OR cd_evento = 'OnboardingYoY'
OR cd_evento = 'cierroOnboarding'

--QUERY PARA SACAR LAS INSTALACIONES ANUALES--
SELECT count(*) as count, substring(dt_instalacion, 1,10) as fecha 
FROM standarized.evento_instalacion
WHERE nu_anio = 2024 AND nu_mes >= 01
GROUP BY substring(dt_instalacion, 1,10) 

dsn=Athena_Prod

--QUERY PARA KPIS POWER BI--
SELECT
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.user_response') AS user_response
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1


--
SELECT
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.step_onboarding') AS step_onboarding,
 json_extract(val_evento, '$.status') AS status,
 json_extract(val_evento, '$.motive') AS motive,
 json_extract(val_evento, '$.timestamp') AS timestamp
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2023 AND nu_mes >= 12
AND cd_evento =  'onboardingYoY'

---
METRICA CONTINUAR INVERSION

SELECT
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.party_id') AS party_id
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'continuarInversion'

Activar Inversion

SELECT
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.button_name') AS button_name,
 json_extract(val_evento, '$.party_id') AS party_id
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'activarInversion'

TiposDeOperacion

SELECT
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.button_name') AS button_name,
 json_extract(val_evento, '$.party_id') AS party_id
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'tiposDeOperacion'

subscripcion

SELECT
cd_evento,
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.party_id') AS party_id
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'tiposDeOperacion'

rescate exitoso

SELECT
cd_evento,
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.is_connected') AS is_connected,
 json_extract(val_evento, '$.party_id') AS party_id
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'rescateExitoso'

--PARA FILTRAR POR ALGUN VALOR DENTRO DEL VAL EVENTO--
SELECT json_extract(val_evento, '$.device_id') AS id_dispositivo,
json_extract(val_evento, '$.income_stream') AS income_stream
FROM "standarized"."evento_aplicacion" 
where nu_anio = 2024 AND nu_mes = 4 AND cd_evento = 'finalizoOnboarding'
AND json_extract_scalar(val_evento, '$.income_stream') IN ('TC', 'CS', 'CA')

--FILTRAR POR DISPOSITIVO--
SELECT * FROM "standarized"."evento_aplicacion"
where nu_anio=2024
and nu_mes = 4
and nu_dia >=20
and json_extract_scalar(val_evento,'$.device_id') = '0475816D-58F5-4478-9A07-EE5BE665CB63'

--STEP DE UN DISPOSITIVO--

SELECT cd_evento,
json_extract_scalar(val_evento,'$.sessionID') id_session_anonimo,
json_extract_scalar(val_evento,'$.device_id') device_id, 
json_extract_scalar(val_evento,'$.step_onboarding') step, 
json_extract_scalar(val_evento,'$.timestamp') fecha_dia_hora,
json_extract_scalar(val_evento,'$.motive') motivo
FROM "standarized"."evento_aplicacion"
where nu_anio=2024
and nu_mes = 4
and nu_dia >=20
and json_extract_scalar(val_evento,'$.device_id') = '2163f3e2dc76139e'

--METRICA DE QUIERO SUSCRIBIR DINERO--

SELECT
cd_evento,
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.is_connected') AS is_connected,
 json_extract(val_evento, '$.party_id') AS party_id,
 json_extract(val_evento, '$.is_first_time') AS is_firtst_time,
 json_extract(val_evento, '$.button_name') AS button_name,
 json_extract(val_evento, '$.to_invest') AS to_invest
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'quieroSuscribitDinero'

--METRICA DE QUIERO RESCATAR DINERO--
SELECT
cd_evento,
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.is_connected') AS is_connected,
 json_extract(val_evento, '$.party_id') AS party_id,
 json_extract(val_evento, '$.is_first_time') AS is_firtst_time,
 json_extract(val_evento, '$.button_name') AS button_name,
 json_extract(val_evento, '$.to_rescue') AS to_rescue
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 1
AND cd_evento =  'quieroRescatarDinero'

--METRICA DE OPERACION FALLIDA--
SELECT
cd_evento,
 json_extract(val_evento, '$.device_id') AS id_dispositivo,
 json_extract(val_evento, '$.sessionID') AS session_anonimo,
 json_extract(val_evento, '$.screen_class') AS screen_class,
 json_extract(val_evento, '$.timestamp') AS timestamp,
 json_extract(val_evento, '$.is_connected') AS is_connected,
 json_extract(val_evento, '$.party_id') AS party_id,
 json_extract(val_evento, '$.operation_type') AS operation_type
 FROM "standarized"."evento_aplicacion"
WHERE  nu_anio = 2024 AND nu_mes >= 4
AND cd_evento =  'operacionFallida'

--PARA SACAR POR MOTIVO--
SELECT count(*),  json_extract(val_evento, '$.motive') as motive
FROM "standarized"."evento_aplicacion"   
WHERE  nu_anio=2024
AND nu_mes = 5
AND nu_dia in (16, 17, 18, 19, 20)
AND cd_evento = 'onboardingYoY'
AND json_extract_scalar(val_evento, '$.previous_step') IN ('P-3-buscoMiDNI')
GROUP BY json_extract(val_evento, '$.motive') 

