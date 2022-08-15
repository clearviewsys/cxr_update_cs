//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/14/17, 17:07:57
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: JSON_Txt2Field
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; WEBAPI_tFieldName)
C_POINTER:C301($0; $ptrField)

C_POINTER:C301($ptrNull)
C_LONGINT:C283(WEBAPI_iField; WEBAPI_iTable; $iPos)
C_TEXT:C284(WEBAPI_tTableName)
C_LONGINT:C283($iLength)

WEBAPI_tFieldName:=$1

$iLength:=3
$iPos:=Position:C15("___"; WEBAPI_tFieldName)
If ($iPos=0)
	$iPos:=Position:C15("."; WEBAPI_tFieldName)
	$iLength:=1
End if 

If ($iPos>0)
	WEBAPI_tTableName:=Substring:C12(WEBAPI_tFieldName; 1; $iPos-1)
	WEBAPI_tFieldName:=Substring:C12(WEBAPI_tFieldName; $iPos+$iLength; Length:C16(WEBAPI_tFieldName))
	
	Begin SQL
		SELECT TABLE_ID, COLUMN_ID
		FROM _USER_COLUMNS
		WHERE TABLE_NAME = :WEBAPI_tTableName
		AND COLUMN_NAME = :WEBAPI_tFieldName
		INTO :WEBAPI_iTable, :WEBAPI_iField;
	End SQL
	
	$0:=Field:C253(WEBAPI_iTable; WEBAPI_iField)
	
Else   //assume table name
	
	WEBAPI_tTableName:=WEBAPI_tFieldName
	
	Begin SQL
		      SELECT TABLE_ID
		      FROM _USER_TABLES
		      WHERE TABLE_NAME=:WEBAPI_tTableName
		      INTO :WEBAPI_iTable;
	End SQL
	
	If (WEBAPI_iTable>0)
		$0:=Table:C252(WEBAPI_iTable)
	Else 
		$0:=$ptrNull
	End if 
	
End if 

