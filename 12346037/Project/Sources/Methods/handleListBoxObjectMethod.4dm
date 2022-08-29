//%attributes = {}
// handleListBoxObjectMethod (self; ->[TABLE]; {->manyField1; {->manyField2}})
// handles the mainListBox in a selection based listbox 
// the second and third field are related fields for displaying related records on display detail
// FORM EVENTS: ON LOAD, ON DOUBLE CLICK, ON UNLOAD

C_POINTER:C301($1; $listboxPtr)

C_POINTER:C301($tablePtr; $manyFieldPtr1; $manyFieldPtr2; $2; $3; $4)
C_LONGINT:C283(vCount)


Case of 
	: (Count parameters:C259=1)
		$listboxPtr:=$1
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=2)
		$listboxPtr:=$1
		$tablePtr:=$2
		
	: (Count parameters:C259=3)
		$listboxPtr:=$1
		$tablePtr:=$2
		$manyFieldPtr1:=$3
		
	: (Count parameters:C259=4)
		$listboxPtr:=$1
		$tablePtr:=$2
		$manyFieldPtr1:=$3
		$manyFieldPtr2:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (<>DOREMEMBERWINDOWPOSITIONS)
	handleListboxColumnsSettings($listboxPtr; $tablePtr)  // keep the column settings
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		showRelevant($tablePtr)
		//vCount:=Records in selection(Current form table->)
		
		If (Count parameters:C259=3)
			SET FIELD RELATION:C919($manyFieldPtr1->; Automatic:K51:4; Manual:K51:3)
		End if 
		
		If (Count parameters:C259=4)
			SET FIELD RELATION:C919($manyFieldPtr1->; Automatic:K51:4; Manual:K51:3)
			SET FIELD RELATION:C919($manyFieldPtr2->; Automatic:K51:4; Manual:K51:3)  // optimized field relations
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		handledoubleclickevent($tablePtr)
		UTIL_unloadAllRecords($tablePtr)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
		If (Count parameters:C259>=3)  // set relation to show related table info
			RELATE ONE:C42($manyFieldPtr1->)
		End if 
		
	: (Form event code:C388=On Selection Change:K2:29)
		//vCount:=Records in selection(Current form table->)
		
	: (Form event code:C388=On Unload:K2:2)
		If (Count parameters:C259=3)
			SET FIELD RELATION:C919($manyFieldPtr1->; Manual:K51:3; Manual:K51:3)
		End if 
		
		If (Count parameters:C259=4)
			SET FIELD RELATION:C919($manyFieldPtr1->; Manual:K51:3; Manual:K51:3)
			SET FIELD RELATION:C919($manyFieldPtr2->; Manual:K51:3; Manual:K51:3)  // optimized field relations
		End if 
		
	Else 
		
End case 



