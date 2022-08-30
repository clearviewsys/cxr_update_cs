checkInit
validateLinks

If (checkErrorExist)
	ALERT:C41(checkGetErrorString)
	REJECT:C38
Else 
	// validation code
	// validate transaction
	setTableBranchDateTimeEtc(->[Links:17]; ->[Links:17]BranchID:38; ->[Links:17]CreationDate:20; ->[Links:17]CreationTime:21; ->[Links:17]createdByUser:39; ->[Links:17]ModificationDate:22; ->[Links:17]ModificationTime:23; ->[Links:17]modifiedByUser:40)
End if 