/*
Script que Crea/Actualiza vistas de susbcripcion en MDM

@MDS:					Nombre MDS aplication
@Model:					Nombre modelo MDM
@Entity:				Nombre entidad MDM
@SubscriptionViewName:	Nombre vista de suscripcion MDM
@Action:				1: Create / Update (NOT NAME), 2 Delete
*/

DECLARE @MDS					NVARCHAR(10)		= N'Nombre MDS aplication'
	  , @Model					NVARCHAR(100)		= N'Nombre modelo MDM'
	  , @VersionName			NVARCHAR(100)		= N'VERSION_1'
	  , @Entity					NVARCHAR(100)		= N'Nombre entidad MDM'
	  , @SubscriptionViewName	NVARCHAR(128)		= N'Nombre vista de suscripcion MDM'
	  , @Action					INT					= 1

/*
	BEGIN PROCESS
	NOT CHANGE OR UPDATE HERE!
*/


/*********************************************
	@ViewFormatID: 
	Available view formats for Entity are:
				
	1 - Leaf
	2 - Consolidated
	3 - Collection Attributes
	4 - Collection
	5 - Parent Child
	6 - Levels
				
	Available view formats for Derived Hierarchy are:
				
	7 - Parent Child
	8 - Levels 
*********************************************/


DECLARE @SubscriptionView_ID	INT					= NULL
	  , @Entity_ID				INT					= NULL
	  , @Model_ID				INT					= NULL
	  , @DerivedHierarchy_ID	INT					= NULL
	  , @ModelVersion_ID		INT					= NULL
	  , @ModelVersionFlag_ID	INT					= NULL
	  , @ViewFormat_ID			INT					= 1
	  , @Levels					INT					= NULL

DECLARE @Return_ID			INT,
		@Return_MUID		NVARCHAR(250), 
		@return_value		NVARCHAR(250)

--@Object_ID
IF (@Action NOT IN (1,2))	-- 1: Create / Update (NOT NAME), 2 Delete
BEGIN
	RAISERROR('MDS Error | The subscription view cannot be saved. The action is not valid, should be 1: Create / Update (NOT NAME), 2 Delete', 16, 1);
	RETURN;
END


--@MDS
IF (@MDS NOT IN (N'AppMDS', N'MDS'))	-- MDS: Global, AppMDS: Regional
BEGIN
	RAISERROR('MDS Error | The subscription view cannot be saved. The MDS is not valid, should be MDS: Global, AppMDS: Regional', 16, 1);
	RETURN;
END

IF (@MDS = N'MDS')
	USE ReferenceData_MasterDataServices
ELSE
	USE ReferenceData_ApplicationMDS


--@Model_ID
SELECT @Model_ID = ID FROM mdm.tblModel WHERE Name = @Model
PRINT CONCAT('@Model = ', @Model, CHAR(10), '@Model_ID = ', @Model_ID)

IF (ISNULL(@Model_ID, 0) = 0 )
BEGIN		
	RAISERROR('MDS Error | The subscription view cannot be saved. The model name is not valid.', 16, 1);
	RETURN;
END


----@ModelVersion_ID
SELECT @ModelVersion_ID = ID FROM mdm.tblModelVersion WHERE name = @VersionName and Model_ID = @Model_ID 
PRINT CONCAT('@VersionName = ', @VersionName, CHAR(10), '@ModelVersion_ID = ', @ModelVersion_ID)

IF (ISNULL(@ModelVersion_ID, 0) = 0 )
BEGIN		
	RAISERROR('MDS Error | The subscription view cannot be saved. The version name is not valid.', 16, 1);
	RETURN;
END


--@Entity_ID
SELECT @Entity_ID = ID FROM mdm.tblEntity WHERE Name = @Entity AND Model_ID = @Model_ID
PRINT CONCAT('@Entity = ', @Entity, CHAR(10), '@Entity_ID = ', @Entity_ID)

IF (ISNULL(@Entity_ID, 0) = 0 )
BEGIN
	RAISERROR('MDS Error | The subscription view cannot be saved. The entity name is not valid.', 16, 1);
	RETURN;
END


--@SubscriptionView_ID
SELECT @SubscriptionView_ID = ID FROM mdm.tblSubscriptionView WHERE Name = @SubscriptionViewName AND Entity_ID = @Entity_ID AND Model_ID = @Model_ID
PRINT CONCAT('@SubscriptionViewName = ', @SubscriptionViewName, CHAR(10), '@SubscriptionView_ID = ', @SubscriptionView_ID)


IF (@Action = 2)	-- 1: Create / Update (NOT NAME), 2 Delete
BEGIN
	-- Delete Subscription View
	IF (ISNULL(@SubscriptionView_ID, 0) = 0 )
	BEGIN
		RAISERROR('MDS Error | The subscription view cannot be saved. The subscription view name is not valid.', 16, 1);
		RETURN;
	END

	EXEC mdm.udpSubscriptionViewDeleteByID 
		@ID = @SubscriptionView_ID, 
		@DeleteView = 1	
END

IF (@Action = 1)	-- 1: Create / Update (NOT NAME), 2 Delete
BEGIN
	EXEC @return_value = mdm.udpSubscriptionViewSave
			@SubscriptionView_ID = @SubscriptionView_ID,
			@Entity_ID = @Entity_ID,
			@Model_ID = @Model_ID,
			@DerivedHierarchy_ID = @DerivedHierarchy_ID,
			@ModelVersion_ID = @ModelVersion_ID,
			@ModelVersionFlag_ID = @ModelVersionFlag_ID,
			@ViewFormat_ID = @ViewFormat_ID, 
			@Levels = @Levels, 
			@SubscriptionViewName = @SubscriptionViewName,
			@Return_ID = @Return_ID OUTPUT,
			@Return_MUID = @Return_MUID OUTPUT
END


PRINT CONCAT('Return_ID = ', @Return_ID)
PRINT CONCAT('Return_MUID = ', @Return_MUID)
PRINT CONCAT('return_value = ', @return_value)

