//%attributes = {"executedOnServer":true}
// gets Web Attachment from Server in BLOB $0
// Execute on Server property is set

C_BLOB:C604($0)
C_TEXT:C284($1; $PathOnServer)

$PathOnServer:=WAPI_uploadsFolder+$1

If (Test path name:C476($PathOnServer)=Is a document:K24:1)
	
	DOCUMENT TO BLOB:C525($PathOnServer; $0)
	
End if 
