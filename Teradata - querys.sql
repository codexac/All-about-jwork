---QUERY PARA VER LOS VERBOS EN TERADATA--

SELECT	Event_Id, Party_Id, Party_Identification_Type_Cd, Party_Identification_Num,
		Party_Identification_CUIT_Num, Gender_Type_cd, Access_Device_Id,
		Access_Device_Means_Cd, Session_Id, Session_Anonymous_Id, Internet_Protocol_Address_Num,
		Backend_System_Cd, e.Access_Device_Transaction_Cd, Calendar_Month_Id,
		Event_Dt, Event_Tm, Effective_Dt, Geospatial_Locator_Val, Currency_Cd,
		Event_Amt, Install_Amt, Value_Amt, Other_Value_Amt, Account_Num,
		Account_Modifier_Num, From_Dt, Up_To_Dt, Source_Account_CBU_Num,
		Target_Account_Num, Target_Account_Modifier_Num, Target_Account_CBU_Num,
		Target_Identification_Num, CBU_Alias, Host_Financial_Event_Num,
		Card_Id, Ext_Business_Name, Ext_Business_Shipping_Name, Term_Qty,
		Price_Limit_Amt, Host_Product_Type_Cd, Electronic_Address_Txt,
		Telephone_Num, Cell_Phone_Num, Bitmap_Val, Application_Id, Login_User_Id,
		Product_Val, Subproduct_Val, Credit_Card_Name, Party_Name, Marital_Status_Cd,
		Birth_Dt, Referred_Val, Messagge_Val, Item_Qty, Credit_Card_Party_Role_Cd,
		Street_Name, House_Num, Floor_Num, Dept_Num, Postal_Code_Num,
		City_Name, Territory_Id, Citizenship_City_Name_Txt, Individual_Occupation_Cd,
		Party_Activity_Cd, Operation_Type_Val, Reference_Id, Financial_Institution_Bank_Num,
		Concept_Name, Second_Factor_Type_Name, Access_Device_Menu_Type_Cd,
		Online_Granted_Ind, Load_Id, a.*
FROM p_dw_tables.YOY_DEVICE_EVENT e
LEFT JOIN
(SELECT Access_Device_Transaction_Cd, Access_Device_Transaction_Desc
FROM p_dw_tables.ACCESS_DEVICE_TRANSACTION) a
ON e.Access_Device_Transaction_Cd= a.Access_Device_Transaction_Cd
WHERE Party_Id = 'AL006621321'

--QUERY PARA VER LOS VERBOS POR MARCA Y MODELO--
SELECT e.Event_Dt, e.Access_Device_Id, e.Session_Id, e.Session_Anonymous_Id,e.Backend_System_Cd, e.Access_Device_Means_Cd, e.Access_Device_Transaction_Cd,e.Party_Id,
		e.Bitmap_Val, e.Referred_Val, e.Concept_Name, a.*
FROM p_dw_tables.YOY_DEVICE_EVENT e
LEFT JOIN
(
							SELECT  Party_Id, Party_Access_Device_Desc, Screen_Resolution_Type_Num,Operating_System_Version_Num,Model_Device_Name,Party_Access_Device_Id
							FROM  p_dw_tables.PARTY_ACCESS_DEVICE 
							
) a
ON e.Access_Device_id =  a.Party_Access_Device_Id AND e.Party_Id = a.Party_Id
WHERE a.Party_Access_Device_Desc = 'Xiaomi M2010J19SG' AND e.Access_Device_Transaction_Cd = '268'  AND Bitmap_Val = 1

--QUERY PARA CHEQUEAR CASOS--
SELECT e.Party_id, Session_Anonymous_Id, Event_dt,Access_Device_Id, Concept_Name, event_dt,Bitmap_Val,Login_User_Id, Referred_VaL,Party_Identification_Num, Access_Device_Means_Cd, a.*
FROM p_dw_tables.YOY_DEVICE_EVENT e
LEFT JOIN
(
							SELECT  Party_Id, Party_Access_Device_Desc, Screen_Resolution_Type_Num,Operating_System_Version_Num,Model_Device_Name,Party_Access_Device_Id
							FROM  p_dw_tables.PARTY_ACCESS_DEVICE 
							
) a
ON e.Access_Device_id =  a.Party_Access_Device_Id AND e.Party_Id = a.Party_Id
WHERE  e.Access_Device_Transaction_Cd = '268' AND Party_Access_Device_Desc = 'WEB' AND Bitmap_Val = 1 AND event_dt BETWEEN '2024/02/01' AND '2024/03/25' 

--TERADATA--
Consulta pasos logs

SELECT * from P_DW_VIEWS.ONBOARDING_APPLICATION
WHERE BPM_Application_Num 

--SACAR LOS DNIS HASHEADO--
SELECT	Party_Identification_Num, hash_id
FROM p_dw_tables.DNI_HASH

--CUANDO NECESITO FILTRAR POR FECHA--
SELECT * FROM p_basel2.OB_PASOS_LOG
where Step_Val = 'ENVIO_A_BPM_SOLICITUD'  AND  Cast(Event_Dttm AS DATE) = '2023-11-24'

-OBTENER DNIS Y MAILS DE CLIENTES NUEVOS --
SELECT Access_Device_Id,Electronic_Address_Txt, Event_Dt, Party_Identification_Num, a.*
FROM p_dw_tables.YOY_DEVICE_EVENT e
LEFT JOIN
(
SELECT	NumDoc, Step_Val, Step_Result_Val, Comments_Txt, ONB_Flow_Val,
		Rechazo_Ind, Screen_Val, User_Val
FROM p_basel2.OB_PASOS_LOG
WHERE Step_Val = 'DNI/EMAIL'
) a
ON a.NumDoc = e.Party_Identification_Num
WHERE Access_Device_Transaction_Cd = 271  and Event_Dt >= '2024/04/01' 