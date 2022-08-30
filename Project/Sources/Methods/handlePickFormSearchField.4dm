//%attributes = {}
// handlepickFormSearchField (self; current form table; ->key;->valuePtr;->sortKey;->searchField1;->searchField2;->searchKey4;->searchKeyPtr5; {searchMethod} )

C_TEXT:C284($search)
C_POINTER:C301($tablePtr; $self; $tablePtr; $valuePtr; $sortKeyPtr; $searchKeyPtr1; $searchKeyPtr2; $searchKeyPtr3; $searchKeyPtr4; $searchKeyPtr5)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)
C_TEXT:C284($10; $searchMethod)
C_LONGINT:C283($len)

$self:=$1
$tablePtr:=$2
$searchKeyPtr1:=$3
$valuePtr:=$4
$sortKeyPtr:=$5
$searchMethod:=""

Case of 
	: (Count parameters:C259=5)  // don't delete this or the else will kick in when 5 parameters are sent only
		
	: (Count parameters:C259=6)
		$searchKeyPtr2:=$6
		
	: (Count parameters:C259=7)
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		
	: (Count parameters:C259=8)
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		
	: (Count parameters:C259=9)
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		$searchKeyPtr5:=$9
		
	: (Count parameters:C259=10)
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		$searchKeyPtr5:=$9
		
		$searchMethod:=$10
	Else 
		myAlert("Invalid number of parameteres sent to handlePickFormSearchField")
		
		
End case 

// make sure you don't add $8 here cause it's inside the code
SET QUERY LIMIT:C395(<>queryLimit)

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On After Keystroke:K2:26))
	
	If (Form event code:C388=On After Keystroke:K2:26)
		$search:=Get edited text:C655
	Else 
		$search:=$self->
	End if 
	
	If (Count parameters:C259<10)
		//allRecords ($tablePtr)
		
		Case of 
			: (Count parameters:C259=6)
				QUERY:C277($tablePtr->; $valuePtr->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
				
			: (Count parameters:C259=7)
				QUERY:C277($tablePtr->; $valuePtr->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@")
				
			: (Count parameters:C259=8)
				QUERY:C277($tablePtr->; $valuePtr->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr4->="@"+$search+"@")
				
			: (Count parameters:C259=9)
				QUERY:C277($tablePtr->; $valuePtr->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr4->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr5->="@"+$search+"@")
				
			Else 
				QUERY:C277($tablePtr->; $valuePtr->="@"+$search+"@"; *)
				QUERY:C277($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@")
		End case 
		
		
	Else 
		executeMethodName($searchMethod)
		
		
		QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
		QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@")
		
		orderByTable($tablePtr)
	End if 
	
	
	If (Records in selection:C76($tablePtr->)=0)
		//BEEP
		
	Else 
		ORDER BY:C49($tablePtr->; $sortKeyPtr->; >)
		//GOTO SELECTED RECORD($tablePtr->;arrKey)
		//$arrKeyPtr->:=1
		//$arrValuePtr->:=1
	End if 
End if 

If (Form event code:C388=On Losing Focus:K2:8)
	If (Records in selection:C76($tablePtr->)#0)
		$self->:=$searchKeyPtr1->
	Else 
		//BEEP
		//GOTO AREA(Self->)
	End if 
End if 

//vRecNum:=String(Records in selection($tablePtr->))

SET QUERY LIMIT:C395(0)

