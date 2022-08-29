//%attributes = {}
// pickTags (->self: pointer; forceDialog: boolean)
// this method opens the picker for tags
// [Tags];"pick"

C_POINTER:C301($1)
C_BOOLEAN:C305($2)
Case of 
	: (Count parameters:C259=1)
		pickRecordForTable(->[Tags:162]; ->[Tags:162]Tag:1; $1)
	: (Count parameters:C259=2)
		pickRecordForTable(->[Tags:162]; ->[Tags:162]Tag:1; $1; True:C214; $2)
End case 