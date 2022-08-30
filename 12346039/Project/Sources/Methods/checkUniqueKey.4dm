//%attributes = {}
// checkUniqueKey (->table;->field;titleOfField;{"Warning"})
// behavior changed as of version 7; @tiran ; 
// this method will not make the field mandatory anymore
// see also : isFieldValueUnique
// checkUniqueKey
// this method signature has changed as of Version 7.0
// this method doesn't work proplery for emails ; see isFieldUnique for email comparison

// this method checks to see if there is a dupplicate key
// if the fourth argument is a string then warn instead of err

C_POINTER:C301($1; $2; $tablePtr; $fieldPtr)
C_TEXT:C284($3; $4; $fieldName; $warn)
C_LONGINT:C283($found)
$warn:=""

Case of 
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$fieldPtr:=$2
		$fieldName:=$3
		
	: (Count parameters:C259=4)
		$tablePtr:=$1
		$fieldPtr:=$2
		$fieldName:=$3
		$warn:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tablePtr:=getTablePtrFromFieldPtr($fieldPtr)


If ($fieldPtr->#"")  // this is only for mandatory fields
	//checkAddError($fieldName+" cannot be left blank.")  // primary keys cannot be left blank
	//colourizeField($fieldPtr)
	//Else 
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
	C_LONGINT:C283($expectedFound)
	If (Is new record:C668($tablePtr->))  // new record only
		$expectedFound:=1  // when we are creating a new record, finding another record with the same value is a duplicate
	Else   // modifying the record
		If (((Old:C35($fieldPtr->)#$fieldPtr->)) & ($fieldPtr->#""))  // value has changed but new value is not empty
			$expectedFound:=1  // finding another record with same value is a duplicate
		Else 
			$expectedFound:=2  // when we are modifying a record, finding another record ...
			// ...with the same value is a duplicate but we need to know there is already one record with that value (current record)
			
		End if 
	End if 
	QUERY:C277($tablePtr->; $fieldPtr->=$fieldPtr->)
	
	If ($found>=$expectedFound)
		If (Count parameters:C259=3)
			checkAddError("A record with the same "+$fieldName+" already exist in the database. Duplicate entry!")
			colourizeField($fieldPtr)
			//$2->:=$2->+"_"
		Else 
			checkAddWarning("There is a record with the same "+$fieldName+" in the database.")
		End if 
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
End if 
