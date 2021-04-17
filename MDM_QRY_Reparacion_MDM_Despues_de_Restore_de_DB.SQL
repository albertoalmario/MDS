/*SINCRONIZACION DE APLICACION MDM CON LA BASE DE DATOS*/


/*
ERROR
"The client version is incompatible with the database version. 
Ask your administrator to upgrade the client components, the database components, or both. 
Run the Master Data Services Configuration Manager on the server for more information."

cuando se presenta el mensaje anterior en la aplicacion web de MDM microsoft informa que se debe correr la reparacion de la base de datos
a traves del Master Data Service Configuration Manager, el cual queda bloqueado al lanzar la reparacion y no funciona.

Para reparar la configuracion se debe correr el siguiente script el cual realiza la reparacion de la comunicacion entre la aplicacion y la base de datos, 
para ejecutar el script se debe seguir los siguientes pasos:

1. El usuario de base de datos con el cual se corre el siguiente script debe tener privilegios sysAdmin
2. La base de datos debe estar en single user

*/

--USE [master]
--GO
--ALTER DATABASE [DB NAME] SET  SINGLE_USER WITH NO_WAIT
----ALTER DATABASE [DB NAME] set multi_user
--GO


--MS "Repair" Code
use [ReferenceData_ApplicationMDS]
go
select getdate()
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();

IF (DB_ID(@dbName) IS NOT NULL
    AND DATABASEPROPERTYEX(@dbName,'Status') <> N'ONLINE')
BEGIN
    RAISERROR(N'The state of the target database, %s, is not set to ONLINE. To deploy to this database, its state must be set to ONLINE.',
	 16, 127,@dbName) WITH NOWAIT
    RETURN
END
go
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();

PRINT N'Repairing ' + @dbName + N'...'

EXECUTE sp_dbcmptlevel @dbName, 110;
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = @dbName)
    BEGIN
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
            SET AUTO_CLOSE OFF
            WITH ROLLBACK IMMEDIATE;
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = @dbName)
    BEGIN
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = @dbName)
    BEGIN
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
            SET READ_COMMITTED_SNAPSHOT ON;
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = @dbName)
    BEGIN
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY TORN_PAGE_DETECTION,
                DATE_CORRELATION_OPTIMIZATION OFF,
                PARAMETERIZATION FORCED,
                SUPPLEMENTAL_LOGGING OFF
            WITH ROLLBACK IMMEDIATE;
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
DECLARE @IsAlwaysOnSupported BIT = CASE WHEN OBJECT_ID(N'[master].[sys].[availability_databases_cluster]') IS NULL THEN 0 ELSE 1 END;

set @execSQL = N'
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();

IF EXISTS (SELECT 1
            FROM   [master].[dbo].[sysdatabases]
            WHERE  [name] = @dbName)
BEGIN ' + CASE @IsAlwaysOnSupported WHEN 1 THEN N'
    IF NOT EXISTS (SELECT 1
            FROM   [master].[sys].[availability_databases_cluster]
            WHERE  [database_name] = @dbName)
    BEGIN ' ELSE N'' END + N'
        ALTER DATABASE '+ QUOTENAME(db_name()) +'
        SET NEW_BROKER
        WITH ROLLBACK IMMEDIATE;

        ALTER DATABASE '+ QUOTENAME(db_name()) +'
        SET ENABLE_BROKER
        WITH ROLLBACK IMMEDIATE;' +
        CASE @IsAlwaysOnSupported WHEN 1 THEN N'
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT 1
                FROM   [master].[sys].[databases]
                WHERE  [name] = @dbName AND [is_broker_enabled] = 1)
        BEGIN
            RAISERROR(N''Cannot enable the service broker because the database is in an availability group. You must remove the DB from the availability group and run repair before joining the DB to the group.'', 16, 127,@dbName);
            RETURN;
        END
    END ' ELSE N'' END + N'
END
';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF IS_SRVROLEMEMBER(N''sysadmin'') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = @dbName)
            BEGIN
                EXECUTE sp_executesql N''ALTER DATABASE '+ QUOTENAME(REPLACE(db_name(), '''', '''''')) +'
    SET TRUSTWORTHY ON,
        DB_CHAINING OFF
    WITH ROLLBACK IMMEDIATE'';
            END
    END
ELSE
    BEGIN
        PRINT N''The database settings cannot be modified. You must be a SysAdmin to apply these settings.'';
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '
DECLARE @dbName NVARCHAR(128);
SELECT @dbName= db_name();


IF IS_SRVROLEMEMBER(N''sysadmin'') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = @dbName)
            BEGIN
                EXECUTE sp_executesql N''ALTER DATABASE '+ QUOTENAME(REPLACE(db_name(), '''', '''''')) +'
    SET HONOR_BROKER_PRIORITY OFF
    WITH ROLLBACK IMMEDIATE'';
            END
    END
ELSE
    BEGIN
        PRINT N''The database settings cannot be modified. You must be a SysAdmin to apply these settings.'';
    END



';
EXEC (@execSQL)
go
DECLARE @execSQL NVARCHAR(MAX);
 set @execSQL = '


USE '+ QUOTENAME(db_name()) +'


';
EXEC (@execSQL)
go
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';
go
/*------------------------------------------------------------------------------------------------------------
Make database TRUSTWORTHY in a safe manner
--------------------------------------------------------------------------------------------------------------*/



--Immediately disable & assign a random password to the login to mitigate it being used as an attack vector.
ALTER LOGIN [mds_dlp_login] DISABLE;
DECLARE @sql NVARCHAR(MAX) = N'
    ALTER LOGIN [mds_dlp_login]
        WITH PASSWORD = N' + QUOTENAME(NEWID(), N'''') + N';';
--PRINT @sql;
EXEC sp_executesql @sql;

--Grant ownership of the database to the disabled low-privileged login.
SET @sql = N'
    ALTER AUTHORIZATION ON DATABASE::' + QUOTENAME(db_name()) + N'
        TO [mds_dlp_login];';
--PRINT @sql;
EXEC sp_executesql @sql;


--Finally, flip the trusthworthy bit and we are done.
SET @sql = N'
    ALTER DATABASE ' + QUOTENAME(db_name()) + N'
        SET TRUSTWORTHY ON;';
--PRINT @sql;
EXEC sp_executesql @sql;


/*******************************************************************************************************************/
/**********ESTA PARTE DEL SCRIPT NO SIRVIO PORQUE EL DATA BASE MAIL ACOUNT NO ESTA CORRECTAMENTE FUNCIONAL**********/
/*******************************************************************************************************************/



/*------------------------------------------------------------------------------------------------------------
Configure database to safely handle unsafe assemblies
--------------------------------------------------------------------------------------------------------------*/

--Any DB owned by mds_dlp_login marked as TRUSTWORTHY can host unsafe assemblies
DECLARE @sql NVARCHAR(MAX) = N'
    USE master;
    GRANT UNSAFE ASSEMBLY TO [mds_dlp_login];';
EXEC sp_executesql @sql;
go
--Tell msdb that it can trust any user impersonated as secure when coming from db owned by mds_lp_login
DECLARE @sql NVARCHAR(MAX) = N'
    USE msdb;
    IF NOT EXISTS(SELECT 1 FROM sys.sysusers WHERE [name] = N''mds_clr_user'') BEGIN
        CREATE USER [mds_clr_user]
            FOR LOGIN [mds_dlp_login];
    END; --if
    GRANT AUTHENTICATE
        TO [mds_clr_user];
';
--PRINT @sql;
EXEC sp_executesql @sql;
go
/*------------------------------------------------------------------------------------------------------------
Configure security for database mail
--------------------------------------------------------------------------------------------------------------*/


--Immediately assign a random password to the login to mitigate it being used as an attack vector.
DECLARE @sql NVARCHAR(MAX) = N'
    ALTER LOGIN [mds_email_login]
        WITH PASSWORD = N' + QUOTENAME(NEWID(), N'''') + N';';
--PRINT @sql;
EXEC sp_executesql @sql;

--Make sure local USER is able to EXECUTE email stored procedure
GRANT EXECUTE
    ON SCHEMA::[mdm]
    TO [mds_email_user];
GRANT SELECT
    ON SCHEMA::[mdm]
    TO [mds_email_user];
GRANT UPDATE
    ON SCHEMA::[mdm]
    TO [mds_email_user];

--Give public role select permission on system version view for SQL telemetry
GRANT SELECT ON OBJECT::[mdm].[viw_SYSTEM_VERSION] TO public

--Ensure activated email stored procedure runs under USERs context
ALTER QUEUE mdm.[microsoft/mdm/queue/notification]
WITH ACTIVATION
(
    STATUS = ON,
    PROCEDURE_NAME = [mdm].[udpNotificationQueueActivate],
    MAX_QUEUE_READERS = 1,
    --In the original queue declaration we used the standard mds_ssb_user context
    --since the appropriate login/user we needed did not exist yet.
    --So here we execute using the context we actually require.
    EXECUTE AS N'mds_email_user'
);

--Finally, create & associate a user in MSDB for the login
--Then add the new user to the email role in msdb
SET @sql = N'
    USE msdb;

    IF NOT EXISTS (SELECT 1 FROM sys.sysusers WHERE [name]=N''mds_email_user'') BEGIN
        CREATE USER [mds_email_user] FOR LOGIN [mds_email_login];
    END; --if

    EXEC sp_addrolemember N''DatabaseMailUserRole'', N''mds_email_user'';
    ';
--PRINT @sql;
EXEC sp_executesql @sql;
go
/*------------------------------------------------------------------------------------------------------------
Enable advanced configurations
--------------------------------------------------------------------------------------------------------------*/

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE WITH OVERRIDE;
go
--Switch on Database Mail
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE WITH OVERRIDE;
go
--Switch on CLR
EXEC sp_configure 'clr_enable', 1;
RECONFIGURE WITH OVERRIDE;
go
sp_configure 'show advanced options', 0;
RECONFIGURE WITH OVERRIDE;
go
/*------------------------------------------------------------------------------------------------------------
Ensure the Service Broker timers are running. When changing this code be sure to likewise change the corresponding code in SystemData.sql
--------------------------------------------------------------------------------------------------------------*/
DECLARE @handle UNIQUEIDENTIFIER;

--Script to start the member security message queue conversation, if it not already running.
SET @handle = mdm.udfServiceGetConversationHandle(N'microsoft/mdm/service/system', N'microsoft/mdm/service/securitymember');
IF @handle IS NULL
BEGIN
    BEGIN DIALOG CONVERSATION @handle
        FROM SERVICE [microsoft/mdm/service/system]
        TO SERVICE N'microsoft/mdm/service/securitymember'
        ON CONTRACT [microsoft/mdm/contract/securitymember]
        WITH ENCRYPTION=OFF; --is by default
END;

--Script to Start the member security timer, if it not already running.
SET @handle = mdm.udfServiceGetConversationHandle(N'microsoft/mdm/service/securitymembertimer', N'microsoft/mdm/service/system');
IF @handle IS NULL
BEGIN
    DECLARE @memberSecHandle UNIQUEIDENTIFIER;
    BEGIN DIALOG CONVERSATION @memberSecHandle
        FROM SERVICE [microsoft/mdm/service/securitymembertimer]
        TO SERVICE N'microsoft/mdm/service/system'
        WITH ENCRYPTION=OFF --is by default
    BEGIN CONVERSATION TIMER (@memberSecHandle) TIMEOUT = 30;
END;
go
--Script to Start the StagingBatch timer, if it not already running.
DECLARE @handle UNIQUEIDENTIFIER;
SET @handle = mdm.udfServiceGetConversationHandle(N'microsoft/mdm/service/stagingbatch', N'microsoft/mdm/service/system');
IF @handle IS NULL
BEGIN
    BEGIN DIALOG CONVERSATION @handle
        FROM SERVICE [microsoft/mdm/service/stagingbatch]
        TO SERVICE N'microsoft/mdm/service/system'
        WITH ENCRYPTION = OFF;
    BEGIN CONVERSATION TIMER (@handle) TIMEOUT = 30;
END;
go
--Script to Start the Notification timer, if it not already running.
DECLARE @handle UNIQUEIDENTIFIER;
SET @handle = mdm.udfServiceGetConversationHandle(N'microsoft/mdm/service/notification', N'microsoft/mdm/service/system');
IF @handle IS NULL
BEGIN
    BEGIN DIALOG CONVERSATION @handle
        FROM SERVICE [microsoft/mdm/service/notification]
        TO SERVICE N'microsoft/mdm/service/system'
        WITH ENCRYPTION = OFF;
    BEGIN CONVERSATION TIMER (@handle) TIMEOUT = 30;
END;
go
--Restore Maintenance Jobs
EXEC [mdm].[udpRestoreMaintenanceJobs];
go


--Update URL
update [mdm].[tblSystemSetting]
set settingvalue='http://blahblah/'
where settingName='MDMRootURL'