//%attributes = {"shared":true}
C_TEXT:C284($macAddress; $pass)
$macAddress:=Request:C163("Enter the MAC address of the computer ")
$pass:=getSupportTeamPassword($macAddress)
myAlert("Password for support team is "+$pass)
CONFIRM:C162("Copy password to Clipboard?")
If (OK=1)
	SET TEXT TO PASTEBOARD:C523($pass)
End if 