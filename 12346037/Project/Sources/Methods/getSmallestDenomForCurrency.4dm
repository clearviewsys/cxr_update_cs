//%attributes = {}
// getSmallestDenomForCurrency (curr)

C_TEXT:C284($curr; $1)
C_REAL:C285($0)


Case of 
	: (Count parameters:C259=1)
		$curr:=$1
		
		
	Else 
		$curr:=<>BASECURRENCY
End case 

If ($curr="")
	$curr:=<>BASECURRENCY
End if 

QUERY:C277([Denominations:31]; [Denominations:31]Currency:2=$curr)
If (Records in selection:C76([Denominations:31])>0)
	ORDER BY:C49([Denominations:31]; [Denominations:31]Value:3; >)
	FIRST RECORD:C50([Denominations:31])
	$0:=[Denominations:31]Value:3
Else 
	$0:=1  // if no record is found assume the lowest denomination is 1
End if 
