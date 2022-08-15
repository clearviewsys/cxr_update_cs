//%attributes = {"shared":true}


C_LONGINT:C283($0; $iResult)

C_TEXT:C284($tUserName)

$iResult:=0

$tUserName:=getSystemUserName

//If ($tUserName="barclay")
//TRACE
//GET REGISTERED CLIENTS($atclients;$atmethods)
//End if 

REGISTER CLIENT:C648($tUserName)  //IBB 1/28/20

If (False:C215)
	GET REGISTERED CLIENTS:C650($atclients; $atmethods)
End if 

$0:=$iResult