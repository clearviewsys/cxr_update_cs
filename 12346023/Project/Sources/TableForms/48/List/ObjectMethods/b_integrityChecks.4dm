//ALL RECORDS([IC_FailedRecords])
//If (Records in selection([IC_FailedRecords])>0)
//CONFIRM("Delete previous intergrity check data?";"Delete";"Don't Delete")
//If (OK=1)
//DELETE SELECTION([IC_FailedRecords])
//End if 
//End if 
//
//`integrityCheckAll
//allRecordsIntegrityChecks 
