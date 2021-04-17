
SELECT * FROM mdm.tblUser ORDER BY ID ASC
SELECT * FROM mdm.tblUserGroup
SELECT * FROM mdm.tblSecurityRole WHERE Name LIKE '%USER OR GROUP%'
SELECT * FROM mdm.tblSecurityRoleAccess WHERE Role_ID = 29
SELECT * FROM mdm.tblSecurityRoleAccessMember
SELECT * from mdm.tblSecurityObject where Name IN ('Model','Entity')
SELECT * from mdm.tblSecurityPrivilege
SELECT * from mdm.tblModel
SELECT * from mdm.tblEntity WHERE Model_ID = 13
SELECT * FROM mdm.tblSecurityAccessControl WHERE Description LIKE '%USER OR GROUP%'
SELECT * FROM mdm.tblNavigationSecurity WHERE Foreign_ID = 34
SELECT * FROM mdm.tblNavigation
SELECT * FROM mdm.viw_SYSTEM_SECURITY_ROLE_ACCESSCONTROL WHERE Role_ID = 29

/*--Crear/actualiza Permiso
EXEC mdm.udpSecurityPrivilegesSaveByMUID
    @SystemUser_ID		= 1,--siempre 1 pues es el administrador
	@Principal_MUID		= 'A60448F6-4715-44B2-BE6E-6D2D612025E5',--Es el MUID del grupo o usuario (mdm.tblusergroup o mdm.tblUser) al cual se quiere asignar permisos
	@PrincipalType_ID	= 2,--especificar el tipo de usuario 1 para Usuario, 2 para Grupos
	@Principal_Name		= 'DOMAIN\USER OR GROUP NAME',--Nombre del usuario o grupo, Nota: este campo puede ir vacio si hay un @Principal_MUID
	@PrincipalType_Name	= N'Group',--especificar el tipo de usuario, Group para grupos o User para usuarios, Nota: este campo puede ir vacio si hay un @PrincipalType_ID
	@RoleAccess_MUID	= '00000000-0000-0000-0000-000000000000',--siempre el valor 00000000-0000-0000-0000-000000000000
	@Object_ID			= 3,--debe ir el ID del tipo de objeto sobre el cual se van a asignar permisos de la tabla mdm.tblSecurityObject: SELECT * from mdm.tblSecurityObject where Name IN ('Model','Entity','Attribute')
	@Privilege_ID		= 2,--debe ir el ID del permiso que se quiere asignar sobre el objeto, el id debe existir en la tabla mdm.tblSecurityPrivilege
	@Model_MUID			= '111C2557-699A-4D80-A39D-3A2D8D50C366',--debe ir el MUID correspondiente al modelo donde se encuentra el objeto, este debe existir en la tabla mdm.tblModel 
	@Model_Name			= 'MODEL NAME',--debe ir el Name del modelo correspondiente al modelo donde se encuentra el objeto, este debe existir en la tabla mdm.tblModel
	@Securable_MUID		= 'DD5F4C28-D773-43B4-924C-83FA2757D57F',--debe ir el MUID correspondiente al objeto al cual se le van a asignar los permisos, este debe existir en la tabla mdm.tblModel o mdm.tblEntity
	@Securable_Name		= 'OBJECT NAME',--debe ir el Name correspondiente al objeto al cual se le van a asignar los permisos, este debe existir en la tabla mdm.tblModel o mdm.tblEntity
	@Status_ID			= 0 --0=create permission, 1=Activate, 2 = delete, 3 = clone se debe usar solo la opcion 0 para crear, aun no estan habilitadas las otras opciones
*/

/*--Eliminar Permiso
EXEC mdm.udpSecurityPrivilegesDeleteByRoleAccessID
	@RoleAccess_ID = 1977 --se debe especificar el ID del permiso a eliminar, este debe existir en la tabla mdm.tblSecurityRoleAccess
*/
