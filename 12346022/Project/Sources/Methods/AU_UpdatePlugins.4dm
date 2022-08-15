//%attributes = {}
// AU_UpdatePlugins
// run update process for only Plugins Folder

C_TEXT:C284($0)

C_TEXT:C284($auEnabled)
C_LONGINT:C283($iProcess)
C_TEXT:C284($tMethodName)

$tMethodName:=Current method name:C684

$auEnabled:=CXR_getSetting("automatic_updates_allowed")

If (Num:C11($auEnabled)=1)
	
	If (SOAP Request:C783)
		$iProcess:=Execute on server:C373($tMethodName; 0; $tMethodName)
	Else 
		AU_DoUpdate(False:C215; False:C215; False:C215; True:C214)  // Structure, Components, Resources, Plugins
	End if 
	
	$0:="Plugins Update Started"
	
Else 
	$0:="Updates are not enabled, please enable it on CXR_settings.xml file"
End if 

