SELECT t.Model_Name, t.EntityTable, t.StagingLeafTable, c.Attribute_Name , c.Attribute_Column, c.Attribute_Type_Name, Attribute_DBAEntity_Name
FROM MDM.viw_SYSTEM_SCHEMA_ENTITY AS t INNER JOIN MDM.viw_SYSTEM_SCHEMA_ATTRIBUTES AS c
ON t.Model_ID = c.Model_ID
AND t.Entity_ID = c.Entity_ID
WHERE t.Name = 'ENTITY NAME'

