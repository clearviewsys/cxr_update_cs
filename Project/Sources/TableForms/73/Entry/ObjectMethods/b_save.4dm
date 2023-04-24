

checkInit
If (validateTable(->[Reports:73]))
	C_BLOB:C604($xBlob)
	
	//hmRep_REPORT TO BLOB (hmReport;$xBlob)
	
	COMPRESS BLOB:C534($xBlob; Compact compression mode:K22:12)
	[Reports:73]xReport:3:=$xBlob
	
Else 
	REJECT:C38
End if 