//%attributes = {}
// saveSelectedRecordsSetToDisk (->[table])


C_POINTER:C301($tablePtr)
C_TEXT:C284($filePath)
C_LONGINT:C283($n)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$n:=Records in selection:C76($tablePtr->)
C_TEXT:C284($setName)
If ($n>0)
	$setName:=makeSavedSetNameForTable($tablePtr)
	If (Shift down:C543)
		$filePath:=""
	Else 
		$filePath:=$setName
	End if 
	
	CREATE SET:C116($tablePtr->; $setName)
	SAVE SET:C184($setName; $filePath)
	CLEAR SET:C117($setName)
	
	C_TEXT:C284($alert)
	$alert:="Mapped record set of table "+getElegantTableName($tablePtr)+" were saved on disk."
	$alert:=$alert+CRLF+"Number of records: "+String:C10($n)
	$alert:=$alert+CRLF+"Click on 'load' on the toolbar to load the records"
	myAlert($alert)
	displayLBox($tablePtr)
	
End if 
