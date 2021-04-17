SELECT M.Name, E.Name, SUB.* FROM mdm.tblEntity AS E INNER JOIN mdm.tblModel AS M ON E.Model_ID = M.ID
RIGHT JOIN (
SELECT L1.Entity_ID, L1.DomainEntity_ID AS Level_1, L2.DomainEntity_ID AS Level_2, L3.DomainEntity_ID AS Level_3, L4.DomainEntity_ID AS Level_4
, L5.DomainEntity_ID AS Level_5, L6.DomainEntity_ID AS Level_6, L7.DomainEntity_ID AS Level_7, L8.DomainEntity_ID AS Level_8, L9.DomainEntity_ID AS Level_9
, L10.DomainEntity_ID AS Level_10, L11.DomainEntity_ID AS Level_11, L12.DomainEntity_ID AS Level_12, L13.DomainEntity_ID AS Level_13
, L14.DomainEntity_ID AS Level_14, L15.DomainEntity_ID AS Level_15, L16.DomainEntity_ID AS Level_16, L17.DomainEntity_ID AS Level_17
, L18.DomainEntity_ID AS Level_18, L19.DomainEntity_ID AS Level_19, L20.DomainEntity_ID AS Level_20
FROM	
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L1
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L2
ON L1.DomainEntity_ID = L2.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L3
ON L2.DomainEntity_ID = L3.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L4
ON L3.DomainEntity_ID = L4.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L5
ON L4.DomainEntity_ID = L5.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L6
ON L5.DomainEntity_ID = L6.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L7
ON L6.DomainEntity_ID = L7.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L8
ON L7.DomainEntity_ID = L8.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L9
ON L8.DomainEntity_ID = L9.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L10
ON L9.DomainEntity_ID = L10.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L11
ON L10.DomainEntity_ID = L11.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L12
ON L11.DomainEntity_ID = L12.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L13
ON L12.DomainEntity_ID = L13.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L14
ON L13.DomainEntity_ID = L14.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L15
ON L14.DomainEntity_ID = L15.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L16
ON L15.DomainEntity_ID = L16.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L17
ON L16.DomainEntity_ID = L17.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L18
ON L17.DomainEntity_ID = L18.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L19
ON L18.DomainEntity_ID = L19.Entity_ID
LEFT JOIN 
(SELECT DISTINCT Entity_ID, DomainEntity_ID FROM mdm.tblAttribute WHERE DomainEntity_ID IS NOT NULL AND Entity_ID <> DomainEntity_ID) AS L20
ON L19.DomainEntity_ID = L20.Entity_ID
WHERE 1=1
--AND L1.Entity_ID = 2635
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L2.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L3.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L11.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L12.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L13.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L14.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L15.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L16.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L17.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L18.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L19.DomainEntity_ID,0)
AND ISNULL(L1.Entity_ID,1) <> ISNULL(L20.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L2.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L3.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L11.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L12.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L13.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L14.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L15.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L16.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L17.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L18.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L19.DomainEntity_ID,0)
AND ISNULL(L1.DomainEntity_ID,1) <> ISNULL(L20.DomainEntity_ID,0)
--L2
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L3.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L2.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L3.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L2.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
--L3
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L3.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L4.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L3.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
--L4
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L4.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L5.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L4.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
--L5
AND ISNULL(L5.Entity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L5.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L5.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L5.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L5.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L5.DomainEntity_ID,1) <> ISNULL(L6.DomainEntity_ID,0)
AND ISNULL(L5.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L5.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L5.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L5.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
--L6
AND ISNULL(L6.Entity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L6.Entity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L6.Entity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L6.Entity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
AND ISNULL(L6.DomainEntity_ID,1) <> ISNULL(L7.DomainEntity_ID,0)
AND ISNULL(L6.DomainEntity_ID,1) <> ISNULL(L8.DomainEntity_ID,0)
AND ISNULL(L6.DomainEntity_ID,1) <> ISNULL(L9.DomainEntity_ID,0)
AND ISNULL(L6.DomainEntity_ID,1) <> ISNULL(L10.DomainEntity_ID,0)
) AS SUB
ON E.ID = SUB.Entity_ID
WHERE M.Name = 'MODEL NAME'