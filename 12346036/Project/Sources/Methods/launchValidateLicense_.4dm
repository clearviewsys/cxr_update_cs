//%attributes = {}
// this method should check to see if this computer is licensed to run the program

C_TEXT:C284($expDate)
C_BOOLEAN:C305($success; $isExpired)
$isExpired:=False:C215
$expDate:=String:C10(Current date:C33+21; ISO date:K1:8)
setErrorTrap("launchValidateLicense"; "Perhaps internet access was denied")


If (ws_isMacRegistered(<>wsUser; <>wsPassword; UTIL_getMacAddress))
	$isExpired:=ws_isMacExpired(<>wsUser; <>wsPassword; UTIL_getMacAddress)
Else   // mac address is not registered 
	$expDate:=String:C10(Current date:C33+21; "|ISO Date Time")
	//$success:=ws_addMacAddress (◊wsUser;◊wsPassword;Get MAC address ;[Forms]ClientCode;Current machine;$expDate)
End if 

If ($isExpired)
	myAlert("This computer is not licensed to run the software.")
	// notify us about this problem ASAP
End if 

endErrorTrap