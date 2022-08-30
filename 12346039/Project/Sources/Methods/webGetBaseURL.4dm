//%attributes = {"publishedWeb":true}
C_TEXT:C284($0)

PROCESS PROPERTIES:C336(Current process:C322; $name; $state; $time; $mode; $unique; $origin)

If ($origin=Web process on 4D remote:K36:17) | ($origin=Web process with no context:K36:8) | ($origin=Web server process:K36:18)
	$0:=WAPI_getHost+"/"+WAPI_getSession("context")
Else 
	$0:=getKeyValue("web.configuration.baseurl")+"/customers"
End if 