
1) ejecutar CMD como administrador

2) ir a la siguiente ruta para realizar despliegues
 for creating a package from existing model with metadata and Data
 C:\Program Files\Microsoft SQL Server\110\Master Data Services\Configuration

3) crear paquetes, esta opcion crea un paquete con todas las entidades de un modelo
 MDSModelDeploy listservices
 MDSModelDeploy listmodels -service "SERVICE NAME"

-------------------------
--crea paquete con data--
-------------------------
 MDSModelDeploy createpackage -service "SERVICE NAME" -model "MODEL NAME" -version "VERSION NAME" -package "C:\FORDER TO EXPORT\FILE NAME.pkg" -includedata

-------------------------------------------
--crea paquetes sin data, solo estructura--
-------------------------------------------
4) MDSModelDeploy createpackage -service "SERVICE NAME" -model "MODEL NAME" -package "C:\FORDER TO EXPORT\FILE NAME.pkg"


5) realizar deploy de paquetes
--para desplegar si es la primera vez y el modelo no existe, esta opcion genera nuevos Identificadores
 MDSModelDeploy deploynew -package "C:\FORDER TO EXPORT\FILE NAME.pkg" -model "MODEL NAME" -service "SERVICE NAME"

--para desplegar sobre un modelo que ya existe se debe usar la opcion deployupdate 
 *SIN DATOS
 MDSModelDeploy deployupdate -package "C:\FORDER TO EXPORT\FILE NAME.pkg" -service "SERVICE NAME"
 *CON DATOS
 MDSModelDeploy deployupdate -service "SERVICE NAME" -package "C:\FORDER TO EXPORT\FILE NAME.pkg" -version "VERSION NAME"

--para desplegar un modelo cuando este no existe en MDM y se quiere que mantenga los Identificadores del modelo origen
 OJO NO RESTAURA PERMISOS
  MDSModelDeploy deployclone -service "SERVICE NAME" -package "C:\FORDER TO EXPORT\FILE NAME.pkg"


--Para ver los permisos que actualmente tiene una vista de suscripcion, pues al realizar deployupdate o deployclone se pierden los permisos existentes.
SELECT
  (
    dp.state_desc + ' ' +
    dp.permission_name collate latin1_general_cs_as + 
    ' ON ' + '[' + s.name + ']' + '.' + '[' + o.name + ']' +
    ' TO ' + '[' + dpr.name + ']'
  ) AS GRANT_STMT
FROM sys.database_permissions AS dp
  INNER JOIN sys.objects AS o ON dp.major_id=o.object_id
  INNER JOIN sys.schemas AS s ON o.schema_id = s.schema_id
  INNER JOIN sys.database_principals AS dpr ON dp.grantee_principal_id=dpr.principal_id
WHERE dpr.name NOT IN ('public','guest')
AND o.name IN ('SUSCRIPTION VIEW NAME')      -- Uncomment to filter to specific object(s)
--  AND dp.permission_name='EXECUTE'    -- Uncomment to filter to just the EXECUTEs


6) editor para generar un paquete con solo las entidades que se necesitan "Package Editor"
 C:\Program Files\Microsoft SQL Server\110\Master Data Services\Configuration\ModelPackageEditor.exe


7) Archivo de configuracion de MDM ".config"
 C:\Program Files\Microsoft SQL Server\110\Master Data Services\Configuration\MDSModelDeploy.exe.config


8) Archivo de log de despliege de MDM, se debe configurar en el archivo de configuracion de MDM "MDSModelDeploy.exe.config"
 C:\Program Files\Microsoft SQL Server\110\Master Data Services\Configuration\MdsModelDeployTrace
 se debe habilitar esta linea en el archivo de configuracion.
 <add name="LogFileListener" type="System.Diagnostics.TextWriterTraceListener" initializeData="MdsModelDeployTrace.log" traceOutputOptions="DateTime" />



-------------------------------
--BUSQUEDA DE MUID DIFERENTES--
-------------------------------
--BusinessRules--
use ReferenceData_MasterDataServices_DEV
go
select Model_Name + '_' + Entity_Name + '_' + BusinessRule_Name AS UnionDatos
,Model_Name,Entity_Name,BusinessRule_Name, BusinessRule_MUID, BusinessRule_ID
from mdm.viw_SYSTEM_SCHEMA_BUSINESSRULES
where Model_Name = 'MODEL NAME'
--UPDATE mdm.tblBRBusinessRule set MUID = '13E456DF-1FF9-407A-A56C-12F861B9EA66' WHERE MUID = '03489CC7-BEAD-44B7-B99A-0C815FB7FB58'

--Entities--
use ReferenceData_MasterDataServices_DEV
go
select Model_Name, Name, MUID from mdm.viw_SYSTEM_SCHEMA_ENTITY where Model_Name = 'MODEL NAME'
--update mdm.tblEntity SET MUID = '03e4c2dc-f1bf-44bf-b672-2148a1ecaa95' where MUID = '2B63E557-45DB-464E-A45A-29E98515CA0B'