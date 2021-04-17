
/****** Object:  StoredProcedure [USPBR].[USP_AssignPermissions]    Script Date: 6/24/2020 4:37:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Alberto Almario Valbuena
-- Create date: 2020-06-23
-- Description:	SP que asigna permisos a un usuario o grupo
-- =============================================

CREATE PROCEDURE [USPBR].[USP_AssignPermissions]


--Declaracion variables de entrada
 @UserType NVARCHAR(5)			--Nombre tipo de usuario al que se le van a asignar los permisos (User o Group)
,@UserGroupName NVARCHAR(100)	--Nombre del usuario o grupo al cual se le van a asignar los permisos NOTA: este usuario debe existir previamente
,@ObjectType NVARCHAR(10)		--Nombre del tipo de objeto al cual se le van a asignar los permisos (Model o Entity)
,@PermissionType NVARCHAR(15)	--Nombre del tipo de permiso que se quiere asignar (DenyAccess, Update, ReadOnly o Delete "este borra el permiso existente")
,@ModelName NVARCHAR(100)		--Nombre del Modelo donde se encuentra el objeto al cual se le va a asignar los permisos
,@ObjectName NVARCHAR(200)		--Nombre del Objeto al cual se le va a asignar los permisos

--EXEC [USPBR].[USP_AssignPermissions] 'User','aceina\aaalma','Entity','Update','ace latam','PegRate'

AS

--Declaracion de variables de proceso
DECLARE @V_ERROR_MSG NVARCHAR(500)
DECLARE @V_ERROR_CODE INT

--Declaracion de variables del SP
DECLARE @V_SystemUser_ID      INT,
        @V_Principal_MUID     UNIQUEIDENTIFIER,
        @V_PrincipalType_ID   INT,
        @V_Principal_Name     NVARCHAR(50) = NULL,
        @V_PrincipalType_Name NVARCHAR(20) = NULL,
        @V_RoleAccess_MUID    UNIQUEIDENTIFIER = NULL,
        @V_Object_ID          INT,
        @V_Privilege_ID       INT,
        @V_Model_MUID         UNIQUEIDENTIFIER,
        @V_Model_Name         NVARCHAR(100) = NULL,
        @V_Securable_MUID     UNIQUEIDENTIFIER,
        @V_Securable_Name     NVARCHAR(100)=NULL,
        @V_Status_ID          INT = 0,
		@V_RoleAccess_ID	  INT

--Inicializa variables
SET @V_ERROR_CODE = 50000
SET @V_ERROR_MSG = ''

--********************************--
--***********VALIDACIONES*********--
--********************************--
--Valida que el tipo de usuario sea uno permitido
IF @UserType NOT IN ('User','Group')
BEGIN
	SET @V_ERROR_MSG = 'El UserType ingresado "' + @UserType + '" no es correcto, solo estan permitidas las siguientes opciones: User o Group'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END

--Valida que el Usuario ingresado existan
IF @UserType = 'User' AND NOT EXISTS (SELECT ID FROM mdm.tblUser WHERE UserName = @UserGroupName)
BEGIN
	SET @V_ERROR_MSG = 'El Usuario ingresado "' + @UserGroupName + '" no existe, por favor cree el Usuario desde la aplicacion web o puede consultar los usuarios en la tabla mdm.tblUser'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END
--Valida que el Grupo ingresado existan
IF @UserType = 'Group' AND NOT EXISTS (SELECT ID FROM mdm.tblUserGroup WHERE Name = @UserGroupName)
BEGIN
	SET @V_ERROR_MSG = 'El Grupo ingresado "' + @UserGroupName + '" no existe, por favor cree el Grupo desde la aplicacion web o puede consultar los grupos en la tabla mdm.tblUserGroup'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END

--Valida que el tipo de Objeto sea uno permitido
IF @ObjectType NOT IN ('Model','Entity')
BEGIN
	SET @V_ERROR_MSG = 'El ObjectType ingresado "' + @ObjectType + '" no es correcto, solo estan permitidas las siguientes opciones: Model o Entity'-- pendiente desarrollar Attribute
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END

--Valida que el tipo de Permiso sea uno permitido
IF @PermissionType NOT IN ('DenyAccess', 'Update', 'ReadOnly', 'Delete')
BEGIN
	SET @V_ERROR_MSG = 'El PermissionType ingresado "' + @PermissionType + '" no es correcto, solo estan permitidas las siguientes opciones: DenyAccess, Update, ReadOnly o Delete'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END

--Valida que el Modelo ingresado existan
IF NOT EXISTS (SELECT ID FROM mdm.tblModel WHERE NAME = @ModelName)
BEGIN
	SET @V_ERROR_MSG = 'El Modelo ingresado "' + @ModelName + '" no existe'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END

--Valida que el Objeto ingresado existan cuando es un Modelo
IF @ObjectType = 'Model' AND NOT EXISTS (SELECT ID FROM mdm.tblModel WHERE NAME = @ObjectName)
BEGIN
	SET @V_ERROR_MSG = 'El ObjectName ingresado "' + @ObjectName + '" no existe para el ObjectType "' + @ObjectType + '"'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END
--Valida que el Objeto ingresado existan cuando es una Entidad
IF @ObjectType = 'Entity' AND NOT EXISTS (SELECT ID FROM mdm.tblEntity WHERE NAME = @ObjectName AND Model_ID = (SELECT ID FROM mdm.tblModel WHERE NAME = @ModelName))
BEGIN
	SET @V_ERROR_MSG = 'El ObjectName ingresado "' + @ObjectName + '" de tipo Entity no existe para el Modelo ingresado "' + @ModelName + '"'
	;THROW @V_ERROR_CODE, @V_ERROR_MSG,1
END



--********************************--
--****ASIGNACION DE VARIABLES*****--
--********************************--
SET @V_SystemUser_ID = 1
SET @V_Principal_Name = @UserGroupName
SET @V_PrincipalType_Name = @UserType
SET @V_RoleAccess_MUID = '00000000-0000-0000-0000-000000000000'
SET @V_Object_ID = (SELECT ID FROM mdm.tblSecurityObject WHERE Name = @ObjectType)
SET @V_Privilege_ID = (SELECT ID FROM mdm.tblSecurityPrivilege WHERE Name = @PermissionType)
SET @V_Model_MUID = (SELECT MUID FROM mdm.tblModel WHERE NAME = @ModelName)
SET @V_Model_Name = @ModelName
SET @V_Securable_Name = @ObjectName
SET @V_Status_ID = 0

IF @UserType = 'User'
BEGIN
	SET @V_Principal_MUID = (SELECT MUID FROM mdm.tblUser WHERE UserName = @UserGroupName)
	SET @V_PrincipalType_ID = 1
END
ELSE
BEGIN
	SET @V_Principal_MUID = (SELECT MUID FROM mdm.tblUserGroup WHERE Name = @UserGroupName)
	SET @V_PrincipalType_ID = 2
END

IF @ObjectType = 'Model'
BEGIN
	SET @V_Securable_MUID = (SELECT MUID FROM mdm.tblModel WHERE NAME = @ObjectName)
END
ELSE
BEGIN
	SET @V_Securable_MUID = (SELECT MUID FROM mdm.tblEntity WHERE NAME = @ObjectName AND Model_ID = (SELECT ID FROM mdm.tblModel WHERE NAME = @ModelName))
END

SET @V_RoleAccess_ID = (SELECT RoleAccess_ID FROM mdm.viw_SYSTEM_SECURITY_ROLE_ACCESSCONTROL WHERE PrincipalType_ID = @V_PrincipalType_ID AND Principal_Name = @V_Principal_Name AND Object_ID = @V_Object_ID AND Model_MUID = @V_Model_MUID AND Securable_MUID = @V_Securable_MUID)


--********************************--
--*************LOGICA*************--
--********************************--

IF @PermissionType IN ('DenyAccess', 'Update', 'ReadOnly')
BEGIN
	--Ejecuta sp que crea el permiso
	EXEC mdm.udpSecurityPrivilegesSaveByMUID
		@SystemUser_ID		= @V_SystemUser_ID,
		@Principal_MUID		= @V_Principal_MUID,
		@PrincipalType_ID	= @V_PrincipalType_ID,
		@Principal_Name		= @V_Principal_Name,
		@PrincipalType_Name	= @V_PrincipalType_Name,
		@RoleAccess_MUID	= @V_RoleAccess_MUID,
		@Object_ID			= @V_Object_ID,
		@Privilege_ID		= @V_Privilege_ID,
		@Model_MUID			= @V_Model_MUID,
		@Model_Name			= @V_Model_Name,
		@Securable_MUID		= @V_Securable_MUID,
		@Securable_Name		= @V_Securable_Name,
		@Status_ID			= @V_Status_ID
END
ELSE IF @PermissionType IN ('Delete')
BEGIN
	EXEC mdm.udpSecurityPrivilegesDeleteByRoleAccessID
		@RoleAccess_ID = @V_RoleAccess_ID
END

GO


