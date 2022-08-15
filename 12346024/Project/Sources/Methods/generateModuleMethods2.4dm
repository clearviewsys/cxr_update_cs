//%attributes = {}
C_TEXT:C284($name; $tableName; $bracketName; $primaryKey; $tableName; $folderName; $methodName; $code)
$tableName:=Request:C163("Please enter the table name")
$bracketName:="["+$tableName+"]"
$primaryKey:=Request:C163("Please enter the primary Key field")
$folderName:=Request:C163("Please enter the folder name"; "Default Folder")

CONFIRM:C162("Create All necessary methods automatically?")
If (OK=1)
	// newRecordTable
	$methodName:="newRecord"+$tableName
	$code:="newRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	// modifyRecordTable
	$methodName:="modifyRecord"+$tableName
	$code:="modifyRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	// orderByTable
	$methodName:="orderBy"+$tableName
	$code:="ORDER BY("+$bracketName+";"+$bracketName+$primaryKey+")"
	// e.g. ORDER BY ([companyTypes];[CompanyTypes]code)
	
	create4DMethod($methodName; $code; $folderName)
	
	// allRecordsTable
	$methodName:="allRecords"+$tableName
	$code:="all records("+$bracketName+")"
	$code:=$code+Char:C90(13)+"orderBy"+$tableName
	create4DMethod($methodName; $code; $folderName)
	
	// printTable
	$methodName:="print"+$tableName
	$code:="printTable(->"+$bracketName+";\"print\";->"+$bracketName+$primaryKey+")"
	create4DMethod($methodName; $code; $folderName)
	
	
	// displayLBoxTable
	$methodName:="displayLBox"+$tableName
	$code:="displayLBox(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	
	// displayLBox_Table
	$methodName:="displayLBox_"+$tableName
	$code:="displayLBox_(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	// displayListTable
	$methodName:="displayList"+$tableName
	$code:="displayLBox"+$tableName
	create4DMethod($methodName; $code; $folderName)
	
	// displayList_Table
	$methodName:="displayList_"+$tableName
	$code:="displayLBox"+$tableName
	create4DMethod($methodName; $code; $folderName)
	
	// displayRecordTable
	$methodName:="displayRecord"+$tableName
	$code:="displayRecord(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	// displayRecord_Table
	$methodName:="displayRecord_"+$tableName
	$code:="displayRecord_(->"+$bracketName+")"
	create4DMethod($methodName; $code; $folderName)
	
	// makePrimaryKey
	$methodName:="make"+$primaryKey
	$code:="c_text($0)"+Char:C90(13)
	$code:=$code+"$0:=createSerializedID(->"+$bracketName+";100000)"
	create4DMethod($methodName; $code; $folderName)
	
	// searchTable
	$methodName:="search"+$tableName
	$code:="searchTable(->"+$bracketName+";->"+$bracketName+$primaryKey+")"
	create4DMethod($methodName; $code; $folderName)
	
	// validateTable
	$methodName:="validate"+$tableName
	$code:="checkUniqueKey(->"+$bracketName+";->"+$bracketName+$primaryKey+";"+"\""+$primaryKey+"\")"
	create4DMethod($methodName; $code; $folderName)
	
	// pickTable
	$methodName:="pick"+$tableName
	$code:="c_pointer($1)"+Char:C90(13)
	$code:=$code+"pickRecordForTable(->"+$bracketName+";->"+$bracketName+$primaryKey+";$1)"
	create4DMethod($methodName; $code; $folderName)
	
	// delChecksTable
	$methodName:="delChecks"+$tableName
	$code:="`do preliminary checks  before deleting"
	create4DMethod($methodName; $code; $folderName)
	
	// deleteTable
	$methodName:="delete"+$tableName
	$code:="`do cleanup after deletions"
	create4DMethod($methodName; $code; $folderName)
	
	//showFlagged
	$methodName:="showFlagged"+$tableName
	$code:="showFlaggedTable(->"+$bracketName+";->"+$bracketName+"isFlagged)"
	create4DMethod($methodName; $code; $folderName)
	
	//showTodays
	$methodName:="showTodays"+$tableName
	$code:="showTodaysTable(->"+$bracketName+";->"+$bracketName+"creationDate)"
	create4DMethod($methodName; $code; $folderName)
	
	// toggleFlagged<TableName>
	$methodName:="toggleFlagged"+$tableName
	$code:="toggleFlaggedTable(->"+$bracketName+";->"+$bracketName+"isFlagged)"
	create4DMethod($methodName; $code; $folderName)
	
	// showRelevant<TableName>
	$methodName:="showRelevant"+$tableName
	$code:="allRecords"+$tableName
	create4DMethod($methodName; $code; $folderName)
	
	// showDateRange<TableName>
	$methodName:="showDateRange"+$tableName
	$code:="showDateRangeTable(->"+$bracketName+";->"+$bracketName+"date)"
	create4DMethod($methodName; $code; $folderName)
End if 
