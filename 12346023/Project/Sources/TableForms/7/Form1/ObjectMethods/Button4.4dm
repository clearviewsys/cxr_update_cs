
C_BOOLEAN:C305($isRegistered; $success)
C_TEXT:C284($expDate)

//$isRegistered:=ws_isCustomerRegistered (◊wsUser;◊wsPassword;[Forms]ClientCode)
$isRegistered:=True:C214

If ($isRegistered)
	If (Not:C34(ws_isMacRegistered(<>wsUser; <>wsPassword; UTIL_getMacAddress)))
		//$success:=ws_addMacAddress(◊wsUser;◊wsPassword;Get MAC address ;[Forms]ClientCode;Current machine;String(Current date+21))
		
	Else   // mac address is registered already
		$expDate:=ws_getMacExpirationDate(<>wsUser; <>wsPassword; UTIL_getMacAddress)
		// we may need to update the client code in case the computer was registered previously under the demo client
		//$success:=ws_addOrUpdateMacAddress(◊wsUser;◊wsPassword;util_getmacAddress ;[Forms]ClientCode;Current machine;$expDate)
		
		ALERT:C41("Validation is due on "+$expDate)
	End if 
Else 
	ALERT:C41([CompanyInfo:7]ClientCode:15+" is not registered")
	
End if 
