//%attributes = {}
// serializeThisRecord (->table): text
// PRE: a record must be selected for the table

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($text)

Case of 
	: (Count parameters:C259=0)  // test case
		$tablePtr:=->[Customers:3]
		ALL RECORDS:C47($tablePtr->)
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

REDUCE SELECTION:C351($tablePtr->; 1)  // if more than 1 record selected reduce to 1 record only
If (Records in selection:C76($tablePtr->)=1)
	$text:=JSON Stringify:C1217(Selection to JSON:C1234($tablePtr->))
	
Else 
	//assert(false;"No record in selection")
End if 
$0:=$text
