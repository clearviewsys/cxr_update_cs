//%attributes = {}

C_TEXT:C284($tHost)


//configure default values for Web Server

$tHost:=getKeyValue("confirmation.server.hostname")
If ($tHost="")  //set a default
	C_OBJECT:C1216($oWeb)
	$oWeb:=WEB Get server info:C1531
	
	setKeyValue("confirmation.server.hostname"; UTIL_whatIsMyIP)
	setKeyValue("confirmation.server.portid"; $oWeb.options.webPortID)
	setKeyValue("confirmation.server.httpsportid"; $oWeb.options.webHTTPSPortID)
	
	If ($oWeb.security.HTTPSEnabled=False:C215)
		setKeyValue("confirmation.server.httpsenabled"; "false")
	Else 
		setKeyValue("confirmation.server.httpsenabled"; "true")
	End if 
	
	
End if 



