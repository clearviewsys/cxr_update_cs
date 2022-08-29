
C_BOOLEAN:C305($isRegistered)

$isRegistered:=ws_isCustomerRegistered(<>wsUser; <>wsPassword; [CompanyInfo:7]ClientCode:15)

If ($isRegistered)
	ALERT:C41([CompanyInfo:7]ClientCode:15+" is registered with registration server.")
Else 
	ALERT:C41([CompanyInfo:7]ClientCode:15+" is not registered yet.")
End if 
