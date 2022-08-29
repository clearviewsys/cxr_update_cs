//%attributes = {}
//Unused currently

C_BOOLEAN:C305($1; $useInternals)

Case of 
	: (Count parameters:C259=0)
		$useInternals:=True:C214
	: (Count parameters:C259=1)
		$useInternals:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($useInternals)
	setKeyValue("twilio.useInternalValues"; "True")
Else 
	setKeyValue("twilio.useInternalValues"; "False")
End if 