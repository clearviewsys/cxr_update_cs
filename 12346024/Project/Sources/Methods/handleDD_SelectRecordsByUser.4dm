//%attributes = {}
// handlePopupRecordsByUser (->self;->[table];->userIDField;inSelection: int)
// Select records in a table by username 

// Unit test is written

C_POINTER:C301($objectPtr; $1)
C_POINTER:C301($tablePtr; $2)
C_POINTER:C301($userFieldPtr; $3)
C_LONGINT:C283($inSelection; $4)
C_LONGINT:C283($formEvent; $5)

$inSelection:=0
$formEvent:=Form event code:C388

Case of 
	: (Count parameters:C259=3)
		$objectPtr:=$1
		$tablePtr:=$2
		$userFieldPtr:=$3
		
	: (Count parameters:C259=4)
		$objectPtr:=$1
		$tablePtr:=$2
		$userFieldPtr:=$3
		$inSelection:=$4
		
	: (Count parameters:C259=5)
		$objectPtr:=$1
		$tablePtr:=$2
		$userFieldPtr:=$3
		$inSelection:=$4
		$formEvent:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



If ($formEvent=On Load:K2:1)
	READ ONLY:C145([Users:25])
	QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)  // active users
	ARRAY TEXT:C222($objectPtr->; 0)
	SELECTION TO ARRAY:C260([Users:25]UserName:3; $objectPtr->)
	INSERT IN ARRAY:C227($objectPtr->; 1; 2)
	$objectPtr->{1}:="Users..."
	$objectPtr->{2}:="Administrator"
	$objectPtr->:=1
End if 

If ($formEvent=On Clicked:K2:4)
	C_TEXT:C284($user)
	
	If ($objectPtr->>1)
		$user:=$objectPtr->{$objectPtr->}
		
		If ($inSelection=1)
			// if 'filter within selection' is on
			QUERY SELECTION:C341($tablePtr->; $userFieldPtr->=$user)
		Else 
			QUERY:C277($tablePtr->; $userFieldPtr->=$user)
		End if 
	End if 
End if 

