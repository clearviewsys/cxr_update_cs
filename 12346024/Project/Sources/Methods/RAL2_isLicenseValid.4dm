//%attributes = {}
// Created by: viktor (5/29/2021)
// Takes in an ApplicationID and returns whether or not the clients license for that application is valid
// RAL2_isLicenseValid(String: $applicationID) -> bool: $isLicenseValid

// Unit test is written @Zoya

var $RAL_statusResponse; $compnayInfo; $license; $licenseObj; $licenseDetails; $clientInfo : Object
var $licenses : Collection
var $isAccountExpired; $continueCheck; $hasMonthlyHitsLeft; $hasTotalHitsLeft : Boolean
var $accountExpiryDate; $appExpiryDate : Date
var $index : Integer

var $1; $applicationID : Text
var $0; $isLicenseValid : Boolean

Case of 
	: (Count parameters:C259=1)
		$applicationID:=$1
		$isLicenseValid:=True:C214
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Call the RAL Service with current applications Client Info
$clientInfo:=ds:C1482.CompanyInfo.all().first()
$RAL_statusResponse:=RAL2_getStatus($clientInfo.ClientCode2)

// Check if a 'code' property was returned and code is "0" for success, or "20" for trial user 
Case of 
	: (OB Is defined:C1231($RAL_statusResponse; "code"))
		If (($RAL_statusResponse.code#"0") & ($RAL_statusResponse.code#"20"))
			$isLicenseValid:=False:C215
		End if 
	Else 
		$isLicenseValid:=False:C215
End case 

// Store all licences in memory
If ($isLicenseValid)
	$licenses:=New collection:C1472()
	$licenses:=$RAL_statusResponse.info.licenses
End if 

// Check if Account is Expired
If ($isLicenseValid)
	If ($RAL_statusResponse.info.accountExpiryDate#Null:C1517)
		$accountExpiryDate:=Date:C102($RAL_statusResponse.info.accountExpiryDate)
		$isLicenseValid:=$accountExpiryDate>Current date:C33(*)
	End if 
End if 

//Check if license exists in list of client licenses
If ($isLicenseValid)
	$index:=-1
	For each ($license; $licenses)
		If ($license.serviceId=$applicationID)
			$index:=$licenses.indexOf($license)
		End if 
	End for each 
	
	If ($index#-1)
		$licenseDetails:=$licenses[$index]
	Else 
		$isLicenseValid:=False:C215
	End if 
End if 

// Check Monthly and Total hits
If ($isLicenseValid)
	$hasTotalHitsLeft:=True:C214
	$hasMonthlyHitsLeft:=True:C214
	
	If ($licenseDetails.totalHitLimit#Null:C1517)
		$hasTotalHitsLeft:=$licenseDetails.totalHit<$licenseDetails.totalHitLimit
	End if 
	
	If ($licenseDetails.monthlyHitLimit#Null:C1517)
		$hasMonthlyHitsLeft:=$licenseDetails.monthlyHit<$licenseDetails.monthlyHitLimit
	End if 
	
	$isLicenseValid:=$hasTotalHitsLeft & $hasMonthlyHitsLeft
End if 

// Check if Application license is expired
If ($isLicenseValid)
	If ($licenseDetails.serviceExpiryDate#Null:C1517)
		$appExpiryDate:=Date:C102($licenseDetails.serviceExpiryDate)
		$isLicenseValid:=$appExpiryDate>Current date:C33(*)
	End if 
End if 

$0:=$isLicenseValid
