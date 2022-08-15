//%attributes = {"shared":true}
//displayCurrentRecord(->table; isAllowed)
// display the current record of table in its view form
C_POINTER:C301($1; $tablePtr)
C_BOOLEAN:C305($isAllowed)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
		$isAllowed:=isUserAuthorizedToView($tablePtr)
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$isAllowed:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($isAllowed)
	If ((Records in selection:C76($tablePtr->)>0) & (Record number:C243($tablePtr->)>=0))
		READ ONLY:C145($tablePtr->)
		PUSH RECORD:C176($tablePtr->)
		LOAD RECORD:C52($tablePtr->)
		If (Record number:C243($tablePtr->)>=0)
			COPY NAMED SELECTION:C331($tablePtr->; getTableNamedSelection($tablePtr))
			displayRecord($tablePtr; Selected record number:C246($tablePtr->))
		End if 
		//READ WRITE($1->)
		POP RECORD:C177($tablePtr->)
	End if 
Else 
	myAlert_AccessDenied
End if 
