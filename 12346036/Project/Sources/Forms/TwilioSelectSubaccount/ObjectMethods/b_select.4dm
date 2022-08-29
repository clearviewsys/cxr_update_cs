C_TEXT:C284($sid; $name)
$sid:=twilioSubAccounts{drop_subAccounts}
$name:=drop_subAccounts{drop_subAccounts}

If ($sid#"")
	setKeyValue("twilio.subAccount.sid"; $sid)
	myAlert($name+" has been set as sub account for the system.")
	ACCEPT:C269
Else 
	myAlert("Error setting sub account.")
End if 
