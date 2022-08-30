//%attributes = {}
// isUserAllowedToChangeRates(->allowancePct4Ind ;->allowancePct4Corp) -> boolean

C_POINTER:C301($1; $2)
C_BOOLEAN:C305($0)

If (isUserAdministrator)
	$0:=True:C214
	Case of 
		: (Count parameters:C259=1)  // Jan 17, 2012 14:21:38 -- I.Barclay Berry 
			$1->:=1.5  //(150%)
		: (Count parameters:C259=2)
			$1->:=1.5  //(150%)
			$2->:=2
	End case 
	
	
Else   // non-administrators
	$0:=isUserAllowedTo(->[Users:25]isAllowedToChangeRates:7)
	Case of 
		: (Count parameters:C259=1)  // Jan 17, 2012 14:21:38 -- I.Barclay Berry 
			$1->:=[Users:25]dealerAllowancePct4Ind:8
		: (Count parameters:C259=2)
			$1->:=[Users:25]dealerAllowancePct4Ind:8
			$2->:=[Users:25]dealerAllowancePct4Corp:19
	End case 
End if 