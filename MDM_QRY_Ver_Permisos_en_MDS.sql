SELECT TOP 1000 
      sr.[Name] RoleName
	 ,sp.Name PrivilegeName
	 ,m.Name ModelName
	 ,Coalesce(a.[DisplayName],e.Name,mm.Name,ag.[Name]) SecurableObjectName
	 ,o.[Name] ObjectType
	 ,Coalesce(a.[DisplayName],e.Name,mm.Name,ag.[Name])+' '+o.[Name]+' ('+sp.Name+')' DescriptionName
	 ,sra.[ID]
      ,sra.[Role_ID]
      ,sra.[Privilege_ID]
      ,sra.[Model_ID]
      ,sra.[Securable_ID]
      ,sra.[Object_ID]
      ,sra.[Description]
      ,sra.[Status_ID]
      ,sra.[EnterDTM]
      ,sra.[EnterUserID]
      ,sra.[LastChgDTM]
      ,sra.[LastChgUserID]
      ,sra.[MUID]
  FROM [mdm].[tblSecurityRoleAccess] sra
  LEFT JOIN [mdm].[tblSecurityObject] o ON o.ID=sra.[Object_ID]
  LEFT JOIN [mdm].[tblAttribute] a ON a.ID=sra.Securable_ID AND o.[Name]='Attribute'
  LEFT JOIN [mdm].[tblEntity] e ON e.ID=sra.Securable_ID AND o.[Name]='Entity'
  LEFT JOIN [mdm].[tblModel] mm ON mm.ID=sra.Securable_ID AND o.[Name]='Model'
  LEFT JOIN [mdm].[tblAttributeGroup] ag ON ag.ID=sra.Securable_ID AND o.[Name]='Attribute Group'
  LEFT JOIN [mdm].[tblSecurityPrivilege] sp ON sp.ID=sra.[Privilege_ID]
  LEFT JOIN [mdm].[tblSecurityRole] sr ON sr.ID=sra.[Role_ID]
  LEFT JOIN [mdm].[tblModel] m ON m.ID=sra.[Model_ID]