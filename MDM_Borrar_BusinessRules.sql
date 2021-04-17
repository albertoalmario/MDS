--UPDATE ALL BUSINESSRULES OF A MODEL TO Delete Pending, after that is necesary ejecute the delete from the master data WEB.

DECLARE @V_ModelName NVARCHAR(500) = 'Your Model Name' -- Change Model Name accordingly

UPDATE Br
SET BusinessRule_StatusID = 6 -- 6:Delete Pending, 2:Excluded, 1:Active
FROM mdm.viw_SYSTEM_SCHEMA_BUSINESSRULES Br
WHERE Model_Name = @V_ModelName
GO


/* ESTOS SON LOS SP QUE SE EJECUTAN DESDE LA WEB AL DAR CLICK EN PUBLICAR, PENDIENTE CREAR PROCESO AUTOMATICO
exec mdm.udpBusinessRulesGetPublishInfo @UserId=1,@ModelMuid='E233AC63-B0B5-42AB-A1BB-54186EE39320',@ModelName=N'ACE Master Data',@EntityMuid='BAC8EC60-7FCA-4AA1-AE9C-E697F36E37F9',@EntityName=N'RCC - Multinational',@MemberType=1
exec mdm.udpBusinessRulesGetPublishInfo @UserId=1,@ModelMuid='E233AC63-B0B5-42AB-A1BB-54186EE39320',@ModelName=N'ACE Master Data',@EntityMuid='8541CA25-4B83-4519-B5CB-8997A06DF9E6',@EntityName=N'Genisys Class of Business',@MemberType=1


declare @p4 bit set @p4=0 exec mdm.udpValidationIsRunning @Model_ID=NULL,@Version_ID=NULL,@Entity_ID=1503,@IsRunning=@p4 output select @p4
declare @p4 bit set @p4=0 exec mdm.udpValidationIsRunning @Model_ID=NULL,@Version_ID=NULL,@Entity_ID=1528,@IsRunning=@p4 output select @p4


declare @p3 nvarchar(200) set @p3=N'udp_SYSTEM_9_1503_CHILDATTRIBUTES_ProcessRules' exec mdm.udpBusinessRuleAttributeMemberControllerNameGetByID @Entity_ID=1503,@MemberType_ID=1,@BRControllerName=@p3 output select @p3
declare @p3 nvarchar(200) set @p3=N'udp_SYSTEM_9_1528_CHILDATTRIBUTES_ProcessRules' exec mdm.udpBusinessRuleAttributeMemberControllerNameGetByID @Entity_ID=1528,@MemberType_ID=1,@BRControllerName=@p3 output select @p3

exec mdm.udpBusinessRuleGetMetadata @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1503
exec mdm.udpBusinessRuleGetMetadata @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1528

declare @p3 nvarchar(200) set @p3=N'udp_SYSTEM_9_1503_CHILDATTRIBUTES_ProcessRules' exec mdm.udpBusinessRuleAttributeMemberControllerNameGetByID @Entity_ID=1503,@MemberType_ID=1,@BRControllerName=@p3 output select @p3
declare @p3 nvarchar(200) set @p3=N'udp_SYSTEM_9_1528_CHILDATTRIBUTES_ProcessRules' exec mdm.udpBusinessRuleAttributeMemberControllerNameGetByID @Entity_ID=1528,@MemberType_ID=1,@BRControllerName=@p3 output select @p3

exec mdm.udpExecuteScript @SqlScript=N' IF EXISTS(SELECT * FROM sys.procedures WHERE [object_id] = OBJECT_ID(N''mdm.[udp_SYSTEM_9_1503_CHILDATTRIBUTES_ProcessRules]'')) DROP PROCEDURE mdm.[udp_SYSTEM_9_1503_CHILDATTRIBUTES_ProcessRules]; '
exec mdm.udpExecuteScript @SqlScript=N' IF EXISTS(SELECT * FROM sys.procedures WHERE [object_id] = OBJECT_ID(N''mdm.[udp_SYSTEM_9_1528_CHILDATTRIBUTES_ProcessRules]'')) DROP PROCEDURE mdm.[udp_SYSTEM_9_1528_CHILDATTRIBUTES_ProcessRules]; '

exec mdm.udpMembersValidationStatusUpdate @Entity_ID=1503,@MemberType_ID=1,@ValidationStatus_ID=4
exec mdm.udpMembersValidationStatusUpdate @Entity_ID=1528,@MemberType_ID=1,@ValidationStatus_ID=4

exec mdm.udpValidationLogClearForBusinessRules @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1503,@ExcludedRulesOnly=0
exec mdm.udpValidationLogClearForBusinessRules @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1528,@ExcludedRulesOnly=0

exec mdm.udpBusinessRuleMarkAsPublished @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1503
exec mdm.udpBusinessRuleMarkAsPublished @BRType_ID=1,@BRSubType_ID=1,@Foreign_ID=1528

exec mdm.udpBusinessRulesAPIGet @UserId=1,@AttributeMuid=NULL,@AttributeName=NULL,@EntityMuid=NULL,@EntityName=NULL,@ModelMuid=NULL,@ModelName=NULL,@BusinessRuleIdentifiers=NULL,@MemberType=NULL,@ActionResultType=1,@ConditionResultType=1,@ConditionTreeNodeResultType=1,@BusinessRulesResultType=1
exec mdm.udpBusinessRulesAPIGet @UserId=1,@AttributeMuid=NULL,@AttributeName=NULL,@EntityMuid=NULL,@EntityName=NULL,@ModelMuid=NULL,@ModelName=NULL,@BusinessRuleIdentifiers=NULL,@MemberType=NULL,@ActionResultType=1,@ConditionResultType=1,@ConditionTreeNodeResultType=1,@BusinessRulesResultType=1

exec mdm.udpBusinessRulesAPIGet @UserId=1,@AttributeMuid=NULL,@AttributeName=NULL,@EntityMuid='BAC8EC60-7FCA-4AA1-AE9C-E697F36E37F9',@EntityName=N'RCC - Multinational',@ModelMuid=NULL,@ModelName=NULL,@BusinessRuleIdentifiers=NULL,@MemberType=1,@ActionResultType=0,@ConditionResultType=0,@ConditionTreeNodeResultType=0,@BusinessRulesResultType=2
exec mdm.udpBusinessRulesAPIGet @UserId=1,@AttributeMuid=NULL,@AttributeName=NULL,@EntityMuid='8541CA25-4B83-4519-B5CB-8997A06DF9E6',@EntityName=N'Genisys Class of Business',@ModelMuid=NULL,@ModelName=NULL,@BusinessRuleIdentifiers=NULL,@MemberType=1,@ActionResultType=0,@ConditionResultType=0,@ConditionTreeNodeResultType=0,@BusinessRulesResultType=2
*/
