--Limpiesa de tablas stg MDM
 DECLARE @CleanupOlderThanDate date = '2017-10-25',  
@ModelID INT = 12
--Clean up Transaction Logs  
--EXEC mdm.udpTransactionsCleanup @ModelID, @CleanupOlderThanDate;  

--Clean up Validation History  
--EXEC mdm.udpValidationsCleanup @ModelID, @CleanupOlderThanDate;  

--Clean up EBS tables  
EXEC mdm.udpEntityStagingBatchTableCleanup @ModelID, @CleanupOlderThanDate;  


--Limpiar batch que se muestran en la web, se dejan en 4"QueuedToClear" para que pasen a 5"Cleared", con esto no se muestran en la web
UPDATE mdm.tblStgBatch SET Status_ID = '4' WHERE EnterDTM <= '2018-01-01 00:00:00'