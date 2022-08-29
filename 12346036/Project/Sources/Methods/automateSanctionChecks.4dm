//%attributes = {}
// automateSanctionChecks($fullName;$tableNum;$recordID;$iconPtr;$onHoldPtr;$holdNotePtr)
// Events: On Data Change

C_TEXT:C284($1; $fullName)
C_LONGINT:C283($2; $tableNum)
C_TEXT:C284($3; $recordID)
C_POINTER:C301($4; $iconPtr)
C_POINTER:C301($5; $onHoldPtr)
C_POINTER:C301($6; $holdNotePtr)

Case of 
	: (Count parameters:C259=4)
		$fullName:=$1
		$tableNum:=$2
		$recordID:=$3
		$iconPtr:=$4
		$onHoldPtr:=Null:C1517
		$holdNotePtr:=Null:C1517
	: (Count parameters:C259=6)
		$fullName:=$1
		$tableNum:=$2
		$recordID:=$3
		$iconPtr:=$4
		$onHoldPtr:=$5
		$holdNotePtr:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($isHold)
$isHold:=($onHoldPtr#Null:C1517) | ($holdNotePtr#Null:C1517)
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_BOOLEAN:C305($auto)
		C_TEXT:C284($query)
		$query:="IsEnabled = True and isManual = False"
		
		C_BOOLEAN:C305($willCheck)
		// #ORDA
		$willCheck:=ds:C1482.SanctionLists.query($query).length#0
		If ($willCheck)
			$willCheck:=stringHasMinimumLength($fullName; 3)
		End if 
		
		If ($willCheck)
			$auto:=<>doCheckSanctionLists
			
			C_TEXT:C284($message)
			$message:=checkNameAgainstSanctionList($auto; $fullName; $tableNum; $recordID; $iconPtr; ""; False:C215; $query)
			
			If ($message#"")
				If ($isHold)
					$onHoldPtr->:=True:C214
					$holdNotePtr->:=$message
				End if 
			End if 
		End if 
End case 