//%attributes = {}
C_TEXT:C284($tSuccess; $tContext)

$tSuccess:=WAPI_webVariableValue("form-success")
$tContext:=WAPI_getSession("context")

If ($tSuccess="")
	WAPI_sendFile("home.shtml"; $tContext)
Else 
	WAPI_sendFile($tSuccess; $tContext)
End if 
