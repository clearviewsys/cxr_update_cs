//%attributes = {"shared":true}
C_TEXT:C284($0)

C_TEXT:C284($auEnabled)
C_LONGINT:C283($iProcess)

$auEnabled:=CXR_getSetting("automatic_updates_allowed")

If (Num:C11($auEnabled)=1)
	
	If (SOAP Request:C783)
		$iProcess:=Execute on server:C373("AU_DoUpdate"; 0; "AU_DoUpdate"; False:C215)
	Else 
		AU_DoUpdate(True:C214; False:C215; False:C215; False:C215)  // Structure, Components, Resources, Plugins
	End if 
	
	$0:="Quick Update Started"
	
Else 
	$0:="Updates are not enabled, please enable it on CXR_settings.xml file"
End if 
