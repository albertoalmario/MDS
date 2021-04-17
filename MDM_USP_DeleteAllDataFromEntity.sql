
/****** Object:  StoredProcedure [USPBR].[USP_DeleteAllDataFromEntity]    Script Date: 6/23/2020 8:34:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Alberto Almario Valbuena
-- Create date: 2016-01-08
-- Description:	SP que elimina toda la data (activa e inactiva) que existe para una entidad
-- como parametro debe recibir el nombre del modelo, nombre de entidad y nombre de version
-- ejemplo Modelo = 'MODEL NAME', Version = 'VERSION NAME' y Entidad = 'ENTITY NAME'
-- Nota: si no se quiere que se generen logs se debe cambiar el parematro @LogFlag = 1 por @LogFlag = 0
-- =============================================

ALTER PROCEDURE [USPBR].[USP_DeleteAllDataFromEntity]


--Declaracion variables de entrada
@MODEL_NAME NVARCHAR(100),--Nombre de un modelo que debe existir en la talba mdm.tblModel
@VERSION_NAME NVARCHAR(100),--Nombre de una version que debe existir en la talba mdm.tblModelVersion
@ENTITY_NAME NVARCHAR(200)--Nombre de una entidad que debe existir en la talba mdm.tblEntity

--EXEC [USPBR].[USP_DeleteAllDataFromEntity] 'MODEL NAME','VERSION NAME','ENTITY NAME'

AS

--Declaracion de variables de proceso
DECLARE @V_ISDATAVALID INT
DECLARE @V_QRY_SELECT NVARCHAR(1000)
DECLARE @V_QRY_SP NVARCHAR(1000)
DECLARE @V_ENTITY_TABLE NVARCHAR(500)
DECLARE @V_ENTITY_STAGING_TABLE NVARCHAR(500)
DECLARE @V_ERROR_MSG NVARCHAR(500)




--Inicializa variables
SET @V_ISDATAVALID = 0
SET @V_QRY_SELECT = NULL

--Obtiene cantidad de registros para el filtro solicitado
SELECT @V_ISDATAVALID = COUNT(*), @V_ENTITY_TABLE = E.EntityTable, @V_ENTITY_STAGING_TABLE = StagingBase
FROM mdm.tblModel AS M 
INNER JOIN mdm.tblModelVersion AS V
ON M.ID = V.Model_ID
INNER JOIN mdm.tblEntity AS E
ON M.ID = E.Model_ID
AND V.ID = E.EnterVersionID
WHERE M.Name = @MODEL_NAME
AND V.Name = @VERSION_NAME
AND E.Name = @ENTITY_NAME
GROUP BY E.EntityTable, StagingBase





--Valida que exista la entidad para el modelo y version enviado

IF @V_ISDATAVALID <> 1
BEGIN
	SET @V_ERROR_MSG = 'La entidad ' + @ENTITY_NAME + ' no existe para el modelo ' + @MODEL_NAME + ' ni version ' + @VERSION_NAME + ' ingresada, Por favor ingrese nuevamente los datos correctos'
	RAISERROR(@V_ERROR_MSG,11,1)
END

ELSE
BEGIN
	
	DECLARE @V_BATCHTAG AS NVARCHAR(50)
	SELECT @V_BATCHTAG = 'DEL-' + REPLACE(REPLACE(REPLACE(REPLACE(Convert(Nvarchar(50),Getdate(),121),'-',''),' ',''),':',''),'.','') 

	SET @V_QRY_SELECT = 'INSERT INTO [stg].[' + @V_ENTITY_STAGING_TABLE + '_Leaf] (BatchTag, ImportType, Code) SELECT ''' + @V_BATCHTAG + ''' as BatchTag, ''6'' AS ImportType, Code FROM mdm.' + @V_ENTITY_TABLE
	EXEC(@V_QRY_SELECT)

	SET @V_QRY_SP = 'exec [stg].[udp_' + @V_ENTITY_STAGING_TABLE + '_Leaf] @VersionName = N''' + @VERSION_NAME + ''', @LogFlag = 1, @BatchTag = ''' + @V_BATCHTAG + ''', @Batch_ID = NULL'
	EXEC(@V_QRY_SP)

END
GO


