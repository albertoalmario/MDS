
DECLARE @MUID NVARCHAR(1000)
SET @MUID = 'e6ec8059-96f9-47fd-9afb-9ffdc642f70f'

SELECT 'mdm.tblAttribute', * FROM mdm.tblAttribute WHERE MUID = @MUID
SELECT 'mdm.tblAttributeGroup', * FROM mdm.tblAttributeGroup WHERE MUID = @MUID
SELECT 'mdm.tblAttributeGroupDetail', * FROM mdm.tblAttributeGroupDetail WHERE MUID = @MUID
SELECT 'mdm.tblBRBusinessRule', * FROM mdm.tblBRBusinessRule WHERE MUID = @MUID
SELECT 'mdm.tblBRItem', * FROM mdm.tblBRItem WHERE MUID = @MUID
SELECT 'mdm.tblBRItemProperties', * FROM mdm.tblBRItemProperties WHERE MUID = @MUID
SELECT 'mdm.tblBRItemType', * FROM mdm.tblBRItemType WHERE MUID = @MUID
SELECT 'mdm.tblBRLogicalOperatorGroup', * FROM mdm.tblBRLogicalOperatorGroup WHERE MUID = @MUID
SELECT 'mdm.tblDerivedHierarchy', * FROM mdm.tblDerivedHierarchy WHERE MUID = @MUID
SELECT 'mdm.tblDerivedHierarchyDetail', * FROM mdm.tblDerivedHierarchyDetail WHERE MUID = @MUID
SELECT 'mdm.tblEntity', * FROM mdm.tblEntity WHERE MUID = @MUID
SELECT 'mdm.tblEvent', * FROM mdm.tblEvent WHERE MUID = @MUID
SELECT 'mdm.tblExternalSystem', * FROM mdm.tblExternalSystem WHERE MUID = @MUID
SELECT 'mdm.tblFile', * FROM mdm.tblFile WHERE MUID = @MUID
SELECT 'mdm.tblHierarchy', * FROM mdm.tblHierarchy WHERE MUID = @MUID
SELECT 'mdm.tblModel', * FROM mdm.tblModel WHERE MUID = @MUID
SELECT 'mdm.tblModelVersion', * FROM mdm.tblModelVersion WHERE MUID = @MUID
SELECT 'mdm.tblModelVersionFlag', * FROM mdm.tblModelVersionFlag WHERE MUID = @MUID
SELECT 'mdm.tblNavigationSecurity', * FROM mdm.tblNavigationSecurity WHERE MUID = @MUID
SELECT 'mdm.tblSecurityAccessControl', * FROM mdm.tblSecurityAccessControl WHERE MUID = @MUID
SELECT 'mdm.tblSecurityRole', * FROM mdm.tblSecurityRole WHERE MUID = @MUID
SELECT 'mdm.tblSecurityRoleAccess', * FROM mdm.tblSecurityRoleAccess WHERE MUID = @MUID
SELECT 'mdm.tblSecurityRoleAccessMember', * FROM mdm.tblSecurityRoleAccessMember WHERE MUID = @MUID
SELECT 'mdm.tblStgBatch', * FROM mdm.tblStgBatch WHERE MUID = @MUID
SELECT 'mdm.tblSubscriptionView', * FROM mdm.tblSubscriptionView WHERE MUID = @MUID
SELECT 'mdm.tblSystemSetting', * FROM mdm.tblSystemSetting WHERE MUID = @MUID
SELECT 'mdm.tblSystemSettingGroup', * FROM mdm.tblSystemSettingGroup WHERE MUID = @MUID
SELECT 'mdm.tblUser', * FROM mdm.tblUser WHERE MUID = @MUID
SELECT 'mdm.tblUserGroup', * FROM mdm.tblUserGroup WHERE MUID = @MUID
SELECT 'mdm.tblUserGroupAssignment', * FROM mdm.tblUserGroupAssignment WHERE MUID = @MUID
