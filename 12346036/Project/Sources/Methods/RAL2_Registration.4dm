//%attributes = {}
C_TEXT:C284($clientCode; $clientKey; $response; $sUser; $sSessionUser; $sProcessName)
C_OBJECT:C1216($oForm)
C_LONGINT:C283($i; $winRef; $iProcess)
$oForm:=New object:C1471()
$oForm.success:=False:C215

UNLOAD RECORD:C212([CompanyInfo:7])
READ WRITE:C146([CompanyInfo:7])
ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])
If (Locked:C147([CompanyInfo:7]))
	LOCKED BY:C353([CompanyInfo:7]; $iProcess; $sUser; $sSessionUser; $sProcessName)
	myAlert(Table name:C256(->[CompanyInfo:7])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName)
End if 
$clientCode:=[CompanyInfo:7]ClientCode2:25
$clientKey:=[CompanyInfo:7]ClientKey2:26
//Get company info record
$response:=RAL2_verifyClient($clientCode; $clientKey)
If ($response="0")
	//Licensing  process
	RAL2_resetConnectExpiry
	RAL2_Licensing
Else 
	If (($response="1") | ($response="3") | ($response="911"))
		RAL2_CantConnect
	Else 
		RAL2_resetConnectExpiry
		$winRef:=Open form window:C675("RegistrationLogin"; Movable form dialog box:K39:8)
		DIALOG:C40("RegistrationLogin"; $oForm)
		CLOSE WINDOW:C154($winRef)
		If (Not:C34($oForm.success))
			If (Not:C34(isUserSupport))
				If (getKeyValue("ral.terminate")="true")
					forceQuit
				End if 
			End if 
		End if 
	End if 
End if 

READ ONLY:C145([CompanyInfo:7])
UNLOAD RECORD:C212([CompanyInfo:7])