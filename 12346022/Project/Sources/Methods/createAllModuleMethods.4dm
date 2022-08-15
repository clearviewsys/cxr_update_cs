//%attributes = {}
C_TEXT:C284($name; $names; $bracketName; $primaryKey; $methodName; $code)
$names:=Request:C163("Please enter the table name")
$bracketName:="["+$names+"]"
$primaryKey:=Request:C163("Please enter the primary Key")
CONFIRM:C162("Create All necessary methods automatically?")
If (OK=1)
	// newRecordTable
	$methodName:="newRecord"+$names
	$code:="newRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// modifyRecordTable
	$methodName:="modifyRecord"+$names
	$code:="modifyRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// orderByTable
	$methodName:="orderBy"+$names
	$code:="ORDER BY("+$bracketName+";"+$bracketName+$primaryKey+")"
	create4DMethod($methodName; $code)
	
	// allRecordsTable
	$methodName:="allRecords"+$names
	$code:="all records("+$bracketName+")"
	$code:=$code+Char:C90(13)+"orderBy"+$names
	create4DMethod($methodName; $code)
	
	// showRelevant
	$methodName:="showRelevant"+$names
	$code:="allRecords"+$names
	$code:=$code+Char:C90(13)+"orderBy"+$names
	create4DMethod($methodName; $code)
	
	// printTable
	$methodName:="print"+$names
	$code:="printTable(->"+$bracketName+";\"print\";->"+$bracketName+$primaryKey+")"
	create4DMethod($methodName; $code)
	
	// importTable
	$methodName:="import"+$names
	$code:="importTable(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// exportTable
	$methodName:="export"+$names
	$code:="exportTable(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// displayListTable
	$methodName:="displayList"+$names
	$code:="displayList(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// displayList_Table
	$methodName:="displayList_"+$names
	$code:="displayList_(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// displayRecordTable
	$methodName:="displayRecord"+$names
	$code:="displayRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// displayRecord_Table
	$methodName:="displayRecord_"+$names
	$code:="displayRecord_(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	// displayLBox_Table
	$methodName:="displayLBox_"+$names
	$code:="displayLBox_(->"+$bracketName+")"
	create4DMethod($methodName; $code)
	
	
	// makePrimaryKey
	$methodName:="make"+$primaryKey
	$code:="c_text($0)"+Char:C90(13)
	$code:=$code+"$0:=createSerializedID(->"+$bracketName+";100000)"
	create4DMethod($methodName; $code)
	
	
	// searchTable
	$methodName:="search"+$names
	$code:="searchTable(->"+$bracketName+";->"+$bracketName+$primaryKey+")"
	create4DMethod($methodName; $code)
	
	// validateTable
	$methodName:="validate"+$names
	$code:="checkUniqueKey(->"+$bracketName+";->"+$bracketName+$primaryKey+";"+"\""+$primaryKey+"\")"
	create4DMethod($methodName; $code)
	
	// pickTable
	$methodName:="pick"+$names
	$code:="c_pointer($1)"+Char:C90(13)
	$code:=$code+"pickRecordForTable(->"+$bracketName+";->"+$bracketName+$primaryKey+";$1)"
	create4DMethod($methodName; $code)
	
	// delChecksTable
	$methodName:="delChecks"+$names
	$code:="`do preliminary checks  before deleting"
	create4DMethod($methodName; $code)
	
	// deleteTable
	$methodName:="delete"+$names
	$code:="`do cleanup after deletions"
	create4DMethod($methodName; $code)
	
	//showFlagged
	$methodName:="showFlagged"+$names
	$code:="showFlaggedTable(->"+$bracketName+";->"+$bracketName+"isFlagged)"
	create4DMethod($methodName; $code)
	
	//showTodays
	$methodName:="showTodays"+$names
	$code:="showTodaysTable(->"+$bracketName+";->"+$bracketName+"creationDate)"
	create4DMethod($methodName; $code)
	
	// toggleFlaggedTable
	$methodName:="toggleFlagged"+$names
	$code:="toggleFlaggedTable(->"+$bracketName+";->"+$bracketName+"isFlagged)"
	create4DMethod($methodName; $code)
	
	
	
	// 
End if 
