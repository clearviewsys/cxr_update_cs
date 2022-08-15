//%attributes = {}
// pickRecordForTable (->table;->fieldtopick;->returnVariable;{query selection:boolean}; {forceDialog:boolean})
// return the result of the pick in the returnVariable
// the caller is responsible for the event settings and checking 
// usually must be called (either: on getting focus or modified event but not both)  `
// forceDialog: is used for buttons elipsis that force opening the picker window no matter what
// e.g. pickRecordForTable (->[CurrencyISOCodes];->[CurrencyISOCodes]ISO4217; ->vSearchVar; false; false)


C_POINTER:C301($1; $2; $3; $tablePtr; $fieldPtr; $returnVarPtr)
C_BOOLEAN:C305($4; $5; $inSelection; $forceDialog)

C_POINTER:C301(vFieldToPickPtr)
C_LONGINT:C283($winRef)
C_TEXT:C284(vSearchText; $0)
C_TEXT:C284($previousValue)
C_TEXT:C284($pickForm)

$pickForm:="PICK"

vFieldToPickPtr:=$2  // this variable is used inside the pick form
Case of 
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$returnVarPtr:=$3
		$inSelection:=False:C215
		$forceDialog:=False:C215
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$fieldPtr:=$2
		$returnVarPtr:=$3
		$inSelection:=$4
		$forceDialog:=False:C215
		
	: (Count parameters:C259=5)
		$tablePtr:=$1
		$fieldPtr:=$2
		$returnVarPtr:=$3
		$inSelection:=$4
		$forceDialog:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ ONLY:C145($tablePtr->)
SET QUERY LIMIT:C395(<>queryLimit)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

$previousValue:=$returnVarPtr->  // store the original value of the field (in case the user press the cancel button)


If ($forceDialog)
	$returnVarPtr->:=""  // empty the value to force the dialog to open
End if 

If ($inSelection=True:C214)  // query in selection
	CREATE SET:C116($tablePtr->; "$BaseSet")
	QUERY SELECTION:C341($tablePtr->; $fieldPtr->=$returnVarPtr->)
	
	If (Records in selection:C76($tablePtr->)=0)  // now try with wildcard
		USE SET:C118("$BaseSet")
		QUERY SELECTION:C341($tablePtr->; $fieldPtr->=$returnVarPtr->+"@")
	End if 
	CLEAR SET:C117("$BaseSet")
Else 
	QUERY:C277($tablePtr->; $fieldPtr->=$returnVarPtr->)
	
	If (Records in selection:C76($tablePtr->)=0)
		QUERY:C277($tablePtr->; $fieldPtr->=$returnVarPtr->+"@")
	End if 
End if 


SET QUERY LIMIT:C395(0)

If (Records in selection:C76($tablePtr->)#1)  // if an exact match is not found then open the picker window
	
	$winRef:=Open form window:C675($tablePtr->; $pickForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
	
	vSearchText:=$returnVarPtr->
	DIALOG:C40($tablePtr->; $pickForm)
	
	If (OK=1)
		$returnVarPtr->:=vSearchText
		QUERY:C277($tablePtr->; $fieldPtr->=vSearchText)  // now search again for the exact Code, so we can load the record
		
		If (Records in selection:C76($tablePtr->)>0)
			LOAD RECORD:C52($tablePtr->)  // load the record
		Else 
			//BEEP
		End if 
		
		
	Else   // OK#1 the cancel has been presssed therefore the previous value should be restored
		
		$returnVarPtr->:=$previousValue
		vSearchText:=$previousValue
	End if 
	
Else   // if an exact match was found 
	$returnVarPtr->:=$fieldPtr->
End if 

