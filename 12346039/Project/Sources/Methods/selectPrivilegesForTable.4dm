//%attributes = {}
// selectPrivilegesForTable (userID; ->table)
// returns a selection in privileges table 

C_TEXT:C284($1; $userID)
C_POINTER:C301($2; $tablePtr)
C_LONGINT:C283($tableNum)

Case of 
	: (Count parameters:C259=2)
		$userID:=$1
		$tablePtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	$tableNum:=Table:C252($tablePtr)
	
	READ ONLY:C145([Privileges:24])
	QUERY:C277([Privileges:24]; [Privileges:24]UserID:1=$userID; *)  // first lookup the privilege for that particular table
	QUERY:C277([Privileges:24];  & ; [Privileges:24]TableNo:2=$tableNum)
End if 
