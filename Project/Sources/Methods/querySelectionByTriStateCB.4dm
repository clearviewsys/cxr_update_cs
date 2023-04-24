//%attributes = {}
// querySelectionByTriStateCB (->booleanField; threeStateCheckbox; combineOperator:int; isLast:bool)

C_POINTER:C301($tablePtr; $booleanFieldPtr; $1)
C_LONGINT:C283($value; $2; $tableNum; $fieldNum)
C_LONGINT:C283($combine; $3)
C_BOOLEAN:C305($isLast; $doContinue; $4)
C_TEXT:C284($varName)


//$combine:=0  // no combine
//$combine:=1  // And
//$combine:=2 // or

$combine:=0  // for backward compatibility don't combine
$doContinue:=False:C215  // for backward compatibility don't chain the queries

Case of 
	: (Count parameters:C259=0)
		ALL RECORDS:C47([Accounts:9])
		$booleanFieldPtr:=->[Accounts:9]isCashAccount:3
		$value:=1  // true
		
	: (Count parameters:C259=2)
		$booleanFieldPtr:=$1
		$value:=$2
		
	: (Count parameters:C259=3)
		$booleanFieldPtr:=$1
		$value:=$2
		$combine:=$3
		
	: (Count parameters:C259=4)
		$booleanFieldPtr:=$1
		$value:=$2
		$combine:=$3
		$isLast:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

RESOLVE POINTER:C394($booleanFieldPtr; $varName; $tableNum; $fieldNum)
$tablePtr:=Table:C252($tableNum)

C_BOOLEAN:C305($expected)
Case of 
	: ($value=1)
		$expected:=True:C214
	: ($value=2)
		$expected:=False:C215
End case 

If ($value#0)
	Case of 
		: ($combine=0)
			QUERY SELECTION:C341($tablePtr->; $booleanFieldPtr->=$expected)
			
		: ($combine=1)  // and
			If ($doContinue)
				QUERY SELECTION:C341($tablePtr->; $booleanFieldPtr->=$expected; *)
			Else 
				QUERY SELECTION:C341($tablePtr->; $booleanFieldPtr->=$expected)
			End if 
			
		: ($combine=2)  // or
			If ($doContinue)
				QUERY SELECTION:C341($tablePtr->;  | ; $booleanFieldPtr->=$expected; *)
			Else 
				QUERY SELECTION:C341($tablePtr->;  | ; $booleanFieldPtr->=$expected)
			End if 
	End case 
End if 