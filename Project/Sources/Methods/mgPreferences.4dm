//%attributes = {}
C_LONGINT:C283($winref)
C_OBJECT:C1216($formObj)

$formObj:=mgGetPreferencesFromServer(getCurrentMachineName)

If ($formObj=Null:C1517)
	$formObj:=mgGetDefaultClientPrefs
End if 

$winref:=Open form window:C675("mgPrefs")

DIALOG:C40("mgPrefs"; $formObj)

CLOSE WINDOW:C154

If (OK=1)
	mgSavePreferences($formObj)
End if 
