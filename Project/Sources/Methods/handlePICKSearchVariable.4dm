//%attributes = {}
// handlePICKSearchVariable (self; current form table; ->key;->valuePtr;->sortKey;->searchField1;->searchField2;->searchKey4;->searchKeyPtr5; {searchMethod} )
// e.g. handlePickFormSearchField (->vSearchText;->[Customers];->[Customers]UID;->[Customers]FullName;->[Customers]FullName;->[Customers]AccountNo;->[Customers]CompanyName;->[Customers]HomeTel)


C_TEXT:C284($search)
C_POINTER:C301($self; $tablePtr; $valuePtr; $sortKeyPtr; $searchKeyPtr1; $searchKeyPtr2; $searchKeyPtr3; $searchKeyPtr4; $searchKeyPtr5)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)
C_TEXT:C284($10; $searchMethod)

$self:=$1
$tablePtr:=$2
$searchKeyPtr1:=$3
$valuePtr:=$4
$searchMethod:=""

Case of 
	: (Count parameters:C259=5)
		$sortKeyPtr:=$5
		
	: (Count parameters:C259=6)
		$sortKeyPtr:=$5
		$searchKeyPtr2:=$6
		
	: (Count parameters:C259=7)
		$sortKeyPtr:=$5
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		
	: (Count parameters:C259=8)
		$sortKeyPtr:=$5
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		
	: (Count parameters:C259=9)
		$sortKeyPtr:=$5
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		$searchKeyPtr5:=$9
		
	: (Count parameters:C259=10)
		$sortKeyPtr:=$5
		$searchKeyPtr2:=$6
		$searchKeyPtr3:=$7
		$searchKeyPtr4:=$8
		$searchKeyPtr5:=$9
		
		$searchMethod:=$10
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
READ ONLY:C145($tablePtr->)  // added by TB on May 21, 2019 

// make sure you don't add $8 here cause it's inside the code
SET QUERY DESTINATION:C396(Into current selection:K19:1)  // don't assume
SET QUERY LIMIT:C395(<>queryLimit)

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On After Keystroke:K2:26))
	
	If (Form event code:C388=On After Keystroke:K2:26)
		$search:=Get edited text:C655
	Else 
		$search:=$self->
	End if 
	
	If (Count parameters:C259=10)  // the 10th parameter is the search 
		executeMethodName($searchMethod)
		orderByTable($tablePtr)
	Else 
		allRecords($tablePtr)
	End if 
	
	Case of 
		: (Count parameters:C259=5)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@")
			
		: (Count parameters:C259=6)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@")
			
		: (Count parameters:C259=7)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@")
			
		: (Count parameters:C259=8)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr4->="@"+$search+"@")
			
		: (Count parameters:C259=9)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr4->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr5->="@"+$search+"@")
			
		: (Count parameters:C259=10)
			QUERY SELECTION:C341($tablePtr->; $valuePtr->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr1->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr2->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr3->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr4->="@"+$search+"@"; *)
			QUERY SELECTION:C341($tablePtr->;  | ; $searchKeyPtr5->="@"+$search+"@")
			
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	If (Records in selection:C76($tablePtr->)=0)
		//BEEP
		
	Else 
		ORDER BY:C49($tablePtr->; $sortKeyPtr->; >)
		//GOTO SELECTED RECORD($tablePtr->;arrKey)
		//$arrKeyPtr->:=1
		//$arrValuePtr->:=1
		If (Self:C308->="")
			Self:C308->:=$valuePtr->
		End if 
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

