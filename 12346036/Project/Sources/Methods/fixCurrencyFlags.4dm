//%attributes = {}
// fixCurrencyFlags
// This method fixed currencies flags based on the flags table
// it reassigns the pictures to the flags
// This is the #classic version

READ ONLY:C145([Flags:19])

ALL RECORDS:C47([Currencies:6])
C_LONGINT:C283($n; $i)
$n:=Records in selection:C76([Currencies:6])

READ WRITE:C146([Currencies:6])
FIRST RECORD:C50([Currencies:6])

For ($i; 1; $n)
	SET QUERY LIMIT:C395(1)  // find maximum 1 result
	QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=[Currencies:6]ISO4217:31)
	If (Records in selection:C76([Flags:19])=1)
		[Currencies:6]Flag:3:=[Flags:19]flag:4
		SAVE RECORD:C53([Currencies:6])
	End if 
	NEXT RECORD:C51([Currencies:6])
End for 

UNLOAD RECORD:C212([Currencies:6])
READ ONLY:C145([Currencies:6])
SET QUERY LIMIT:C395(0)  // reset the query limit