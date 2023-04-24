//%attributes = {"shared":true}
C_TEXT:C284($0)

C_TEXT:C284($auEnabled)
C_LONGINT:C283($iProcess)

$auEnabled:=CXR_getSetting("automatic_updates_allowed")

If (Num:C11($auEnabled)=1)
	
	If (SOAP Request:C783)
		$iProcess:=Execute on server:C373("AU_DoUpdate"; 0; "AU_DoUpdate"; True:C214)
	Else 
		AU_DoUpdate(True:C214; True:C214; True:C214; True:C214)  // Structure, Components, Resources, Plugins
	End if 
	
	$0:="Full Update Started"
	
Else 
	$0:="Updates are not enabled, please enable it on CXR_settings.xml file"
End if 