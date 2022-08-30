//%attributes = {}
C_TEXT:C284($curr; $base)
C_REAL:C285($rate)
C_LONGINT:C283($error)
$base:=<>BASECURRENCY

If ($base="USD")
	$curr:="CAD"
Else 
	$curr:="USD"
End if 

setErrorTrap("Test Button")
$error:=ws_getCurrencyRate($curr; $base; ->$rate)
If ($error=0)
	myAlert("SUCCESS:"+$curr+"/"+$base+"="+String:C10($rate))
Else 
	myAlert("Error fetching rate! "+String:C10($error))
End if 

endErrorTrap