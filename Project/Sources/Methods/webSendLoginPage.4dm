//%attributes = {}
C_TEXT:C284($context)

//<>20201201
$context:=WAPI_getSession("context")
If ($context="")
	$context:=getKeyValue("web.configuration.context.default"; "customers")
End if 
WAPI_sendFile("login.shtml"; $context)
