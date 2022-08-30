//%attributes = {}
C_LONGINT:C283($iProcess)
C_TEXT:C284($sProcessName; $sSessionUser; $sUser)
C_OBJECT:C1216($oForm; $oStatus; $oProfile)
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
	
	$oProfile:=RAL2_getProfile([CompanyInfo:7]ClientCode2:25; [CompanyInfo:7]ClientKey2:26)
	If (($oStatus.code#"0") | ($oProfile.code#"0"))
		If ($oStatus.code#"0")
			RAL2_handleErrors($oStatus.code)
		Else 
			RAL2_handleErrors($oProfile.code)
		End if 
		
		//RAL2_Registration 
		//READ WRITE([CompanyInfo])
		
		//ALL RECORDS([CompanyInfo])
		//FIRST RECORD([CompanyInfo])
		//$oStatus:=RAL2_getStatus ([CompanyInfo]ClientCode2)
		//$oProfile:=RAL2_getProfile ([CompanyInfo]ClientCode2;[CompanyInfo]ClientKey2)
		
	Else 
		
		RAL2_loadLicensesArray($oStatus)
		
		$oForm.ClientCode:=[CompanyInfo:7]ClientCode2:25
		$oForm.ClientKey:=[CompanyInfo:7]ClientKey2:26
		$oForm.ApplicationID:=[CompanyInfo:7]ApplicationID:30
		$oForm.LicenseExpiry:=[CompanyInfo:7]LicenseExpiryDate:23
		
		$oForm.CompanyName:=[CompanyInfo:7]CompanyName:1
		$oForm.Address:=[CompanyInfo:7]Address:2
		$oForm.City:=[CompanyInfo:7]City:9
		$oForm.Country:=[CompanyInfo:7]Country:10
		$oForm.Email:=[CompanyInfo:7]Email:6
		$oForm.Phone:=[CompanyInfo:7]Tel1:3
		
		If ($oProfile.info.firstName#Null:C1517)
			$oForm.Name:=$oProfile.info.firstName+" "
		End if 
		If ($oProfile.info.lastName#Null:C1517)
			$oForm.Name:=$oForm.Name+$oProfile.info.lastName
		End if 
		If ($oProfile.info.province#Null:C1517)
			$oForm.State:=$oProfile.info.province
		Else 
			$oForm.State:=""
		End if 
		If ($oProfile.info.isCompany#Null:C1517)
			$oForm.isCompany:=Bool:C1537($oProfile.info.isCompany)
		End if 
		If ($oProfile.info.country#Null:C1517)
			$oForm.Country:=$oProfile.info.country
			$oForm.CountryCode:=getCountryCode($oForm.Country)
		Else 
			$oForm.Country:=""
			$oForm.CountryCode:=""
		End if 
		If ($oProfile.info.postalCode#Null:C1517)
			$oForm.PostalCode:=$oProfile.info.postalCode
		Else 
			$oForm.PostalCode:=""
		End if 
		If ($oProfile.info.companyName#Null:C1517)
			$oForm.CompanyName:=$oProfile.info.companyName
		Else 
			$oForm.CompanyName:=""
		End if 
		If ($oProfile.info.address#Null:C1517)
			$oForm.Address:=$oProfile.info.address
		Else 
			$oForm.Address:=""
		End if 
		If ($oProfile.info.city#Null:C1517)
			$oForm.City:=$oProfile.info.city
		Else 
			$oForm.City:=""
		End if 
		
		RAL2_assignExpiryDate($oStatus; $oForm)
		
		
		C_LONGINT:C283($winRef)
		$winRef:=Open form window:C675([CompanyInfo:7]; "UserCompanyInfo"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40([CompanyInfo:7]; "UserCompanyInfo"; $oForm)
		CLOSE WINDOW:C154($winRef)
	End if 
End if 


UNLOAD RECORD:C212([CompanyInfo:7])
READ ONLY:C145([CompanyInfo:7])
LOAD RECORD:C52([CompanyInfo:7])

