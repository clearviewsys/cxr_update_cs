//%attributes = {}
// handlePopupRecordsByUser (->self;->[table];->branchIDField;inSelection: int)
// Select records in a table by username 

C_POINTER:C301($objectPtr; $1)
C_POINTER:C301($tablePtr; $2)
C_POINTER:C301($currencyFieldPtr; $3)
C_LONGINT:C283($inSelection; $4)
C_TEXT:C284($currency)

Case of 
	: (Count parameters:C259=4)
		$objectPtr:=$1
		$tablePtr:=$2
		$currencyFieldPtr:=$3
		$inSelection:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Currencies:6])
	QUERY:C277([Currencies:6]; [Currencies:6]isDisplayOnly:33=False:C215)  // active users
	ARRAY TEXT:C222($objectPtr->; 0)
	SELECTION TO ARRAY:C260([Currencies:6]ISO4217:31; $objectPtr->)
	INSERT IN ARRAY:C227($objectPtr->; 1; 1)
	$objectPtr->{1}:="CURR"
	$objectPtr->:=1
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($currency)
	
	If ($objectPtr->>1)
		$currency:=$objectPtr->{$objectPtr->}
		
		If ($inSelection=1)
			// if 'filter within selection' is on
			QUERY SELECTION:C341($tablePtr->; $currencyFieldPtr->=$currency)
		Else 
			QUERY:C277($tablePtr->; $currencyFieldPtr->=$currency)
		End if 
	End if 
End if 

