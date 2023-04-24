//%attributes = {}
var $clientCode : Text
var $applicationID : Text


// ----------------------------------------------------
// This is a valid License
// ----------------------------------------------------

$clientCode:="MoneyWayNew"  // Valid

If (BR_isCustomerLicenseValid($clientCode))
	myAlert("Client License for "+$clientCode+" is valid")
Else 
	myAlert("Client License for "+$clientCode+" is NOT valid")
End if 

// ----------------------------------------------------
// This is an invalid License
// ----------------------------------------------------

$clientCode:="clearviewsysVM2Test"  // Invalid

If (BR_isCustomerLicenseValid($clientCode))
	myAlert("Client License for "+$clientCode+" is valid")
Else 
	myAlert("Client License for "+$clientCode+" is NOT valid. License Expired")
End if 


// ----------------------------------------------------
// This is a valid License for a customer using an App
// ----------------------------------------------------

$clientCode:="MoneyWayNew"  // Valid
$applicationID:="AML_BR"

If (BR_IsAppLicenseValid($clientCode; $applicationID))
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is valid")
Else 
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is NOT valid")
End if 

// -------------------------------------------------------
// This is a no valid License for a customer using an App
// -------------------------------------------------------

$clientCode:="clearviewsysVM2Test"  // Invalid: Expired
$applicationID:="AML_BR"

If (BR_IsAppLicenseValid($clientCode; $applicationID))
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is valid")
Else 
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is NOT valid. License expired")
End if 


// -------------------------------------------------------
// This is a valid License for a customer using Hits
// -------------------------------------------------------
$clientCode:="MoneyWayNew"  // Vvalid: Hits available
$applicationID:="CXW.SL.OFAC"

If (BR_IsAppLicenseValidbyHits($clientCode; $applicationID))
	myAlert("App License for client "+$clientCode+" and Application: "+$applicationID+" Hits available")
Else 
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is NOT valid. Hits consumed")
End if 

// -------------------------------------------------------
// This is a not valid License for a customer using Hits
// -------------------------------------------------------
$clientCode:="clearviewsysVM2Test"  // Invalid: Expired
$applicationID:="CXW.SL.OFAC"

If (BR_IsAppLicenseValidbyHits($clientCode; $applicationID))
	myAlert("App License for client "+$clientCode+" and Application: "+$applicationID+" Hits available")
Else 
	myAlert("App License for client: "+$clientCode+" and Application: "+$applicationID+" is NOT valid. Hits consumed")
End if 

