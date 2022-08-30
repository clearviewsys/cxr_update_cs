//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/21/17, 22:37:26
// ----------------------------------------------------
// Method: UTIL_getFieldPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_TEXT:C284($1; $tFieldName)
C_POINTER:C301($0; $ptrField)

C_POINTER:C301($ptrNull)
C_LONGINT:C283($iField; $iTable; $iPos)
C_TEXT:C284($tTableName; $currOnErr)


$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")


$tFieldName:=$1

$iPos:=Position:C15("]"; $tFieldName)

If ($iPos>0)
	$tTableName:=Substring:C12($tFieldName; 1; $iPos-1)
	$tTableName:=Replace string:C233($tTableName; "["; "")
	$tFieldName:=Substring:C12($tFieldName; $iPos+1; Length:C16($tFieldName))
	
	If ($tFieldName="")  //only a table
		
		Begin SQL
			      SELECT TABLE_ID
			      FROM _USER_TABLES
			      WHERE TABLE_NAME=:$tTableName
			      INTO :$iTable;
		End SQL
		
		If ($iTable>0)
			$0:=Table:C252($iTable)
		Else 
			$0:=$ptrNull
		End if 
		
		
	Else 
		Begin SQL
			SELECT TABLE_ID, COLUMN_ID
			FROM _USER_COLUMNS
			WHERE TABLE_NAME = :$tTableName
			AND COLUMN_NAME = :$tFieldName
			INTO :$iTable, :$iField;
		End SQL
		
		If ($iTable=0)
			$0:=$ptrNull
		Else 
			$0:=Field:C253($iTable; $iField)
		End if 
		
	End if 
	
Else 
	$0:=$ptrNull
End if 

ON ERR CALL:C155($currOnErr)