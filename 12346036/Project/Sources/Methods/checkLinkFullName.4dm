//%attributes = {}
// checkLinkFullName ($isForced)

C_TEXT:C284($sanctionCheckResult; $name)
C_LONGINT:C283($match)
C_PICTURE:C286(latestLinkIcon7)
C_BOOLEAN:C305($1; $isForced)

Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
	: (Count parameters:C259=1)
		$isForced:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (([Links:17]FirstName:2#"") & ([Links:17]LastName:3#"") & (stringHasMinimumLength([Links:17]FirstName:2; 1)) & (stringHasMinimumLength([Links:17]LastName:3; 1)))
	$name:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
	CheckSanctionCheckListSetIcon($isForced; $name; False:C215; Table:C252(->[Links:17]); [Links:17]LinkID:1; ->latestLinkIcon7)
End if 


