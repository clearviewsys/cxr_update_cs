//%attributes = {}
//Method: RAL2_Licensing
//Purpose: Begin the RAL licensing process to validate the application license
//Parameters: mustActivate (Boolean) (Optional), set true to show the 
//must activate account popup

//Parameters
C_BOOLEAN:C305($mustActivate)
//Internal
C_TEXT:C284($clientCode; $applicationId; $response; $sUser; $sSessionUser; $sProcessName)
C_BOOLEAN:C305($continue)
C_OBJECT:C1216($oForm)
C_LONGINT:C283($winRef; $iProcess)
$oForm:=New object:C1471()
$oForm.retry:=False:C215
$oForm.success:=True:C214

Case of 
	: (Count parameters:C259=1)
		$mustActivate:=$1
	Else 
		$mustActivate:=False:C215
End case 

If ($mustActivate)
	$oForm.success:=False:C215
	$winRef:=Open form window:C675("LicensingRetry"; Movable form dialog box:K39:8)
	DIALOG:C40("LicensingRetry"; $oForm)
	CLOSE WINDOW:C154($winRef)
	
End if 

If ($oForm.success)
	$continue:=True:C214
	
	If (Locked:C147([CompanyInfo:7]))
		LOCKED BY:C353([CompanyInfo:7]; $iProcess; $sUser; $sSessionUser; $sProcessName)
		myAlert(Table name:C256(->[CompanyInfo:7])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName)
	End if 
	$clientCode:=[CompanyInfo:7]ClientCode2:25
	$applicationId:=[CompanyInfo:7]ApplicationID:30
	
	//TODO change this to account for existing application licenses
	If ($applicationId="")
		$applicationId:="CXR.BE-2350"
	End if 
	
	While ($continue)
		$response:=RAL2_licenseClient($clientCode; $applicationId)
		
		$continue:=False:C215
		Case of 
			: ($response="0")
				//Success
				RAL2_resetConnectExpiry
				//myAlert ("Licensing was successful")
				[CompanyInfo:7]ApplicationID:30:=$applicationId
				SAVE RECORD:C53([CompanyInfo:7])
				RAL2_checkExpiry
			: ($response="11")
				//Registration not activated
				//Pop up form asking user to activate their account with options to retry
				RAL2_resetConnectExpiry
				$oForm.retry:=True:C214
				$oForm.success:=False:C215
				$winRef:=Open form window:C675("LicensingRetry"; Movable form dialog box:K39:8)
				DIALOG:C40("LicensingRetry"; $oForm)
				CLOSE WINDOW:C154($winRef)
				If ($oForm.success=True:C214)
					$continue:=True:C214
				Else 
					//User hit Exit on form
					//Terminate application
					If (Not:C34(isUserSupport))
						If (getKeyValue("ral.terminate")="true")
							forceQuit
						End if 
					End if 
				End if 
			: ($response="20")
				//Trial License generated
				RAL2_resetConnectExpiry
				notifyAlert("License Generated"; "30 day Trial License generated for this application."; 10)
				[CompanyInfo:7]ApplicationID:30:=$applicationId
				SAVE RECORD:C53([CompanyInfo:7])
			: (($response="1") | ($response="3") | ($response="911"))
				RAL2_CantConnect
			Else 
				RAL2_resetConnectExpiry
				RAL2_handleErrors($response)
				If (Not:C34(isUserSupport))
					If (getKeyValue("ral.terminate")="true")
						forceQuit
					End if 
				End if 
				
		End case 
	End while 
Else 
	//User hit exit
	//Terminate application
	If (Not:C34(isUserSupport))
		If (getKeyValue("ral.terminate")="true")
			forceQuit
		End if 
	End if 
End if 
