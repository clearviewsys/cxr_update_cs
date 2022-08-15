//%attributes = {}
//Method to check the expiry date of the current RAL License and provide appropriate alerts
//Inputs: none
//Outputs:
// isLicenseExpired (Bool)

C_BOOLEAN:C305($0)
C_LONGINT:C283($iProcess)
C_TEXT:C284($sProcessName; $sSessionUser; $sUser)
C_OBJECT:C1216($oForm; $oStatus; $oProfile)
C_DATE:C307($expiry; $oneWeek)
$oForm:=New object:C1471()
$oStatus:=New object:C1471()
$oProfile:=New object:C1471()

READ WRITE:C146([CompanyInfo:7])

ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])



If (Locked:C147([CompanyInfo:7]))
	LOCKED BY:C353([CompanyInfo:7]; $iProcess; $sUser; $sSessionUser; $sProcessName)
	myAlert(Table name:C256(->[CompanyInfo:7])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName)
Else 
	$oStatus:=RAL2_getStatus([CompanyInfo:7]ClientCode2:25)
	If (($oStatus.code#"0"))
		RAL2_handleErrors($oStatus.code)
	Else 
		$expiry:=RAL2_saveExpiryDate($oStatus; [CompanyInfo:7]ApplicationID:30)
		$oneWeek:=Add to date:C393(Current date:C33; 0; 0; 7)
		If ((Current date:C33<$expiry) & ($oneWeek>$expiry))
			notifyAlert("License Warning"; "Warning: Your current License expires on "+String:C10($expiry); 10)
		End if 
		If ($expiry<Current date:C33)
			$0:=True:C214
			If ($expiry=Date:C102("00/00/00"))
				//expiry date of 0000-00-00 means the date is not set
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
	End if 
End if 

READ ONLY:C145([CompanyInfo:7])
UNLOAD RECORD:C212([CompanyInfo:7])