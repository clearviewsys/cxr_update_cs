//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/15/11, 10:10:51
// Copyright 2009 -- i.Comp, LLC
// ----------------------------------------------------
// Method: SQL_Field2SQLtxt
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptrField)
C_LONGINT:C283($iField; $iTable)
C_TEXT:C284($0; $var)

$ptrField:=$1

RESOLVE POINTER:C394($ptrField; $var; $iTable; $iField)

Case of 
	: ($iTable>0) & ($iField>0)
		$0:=Lowercase:C14(Table name:C256(Table:C252($ptrField))+"___"+Field name:C257($ptrField)+"")
		
	: ($iTable>0)
		$0:=Lowercase:C14(Table name:C256(Table:C252($ptrField)))  //+"."+Field name($ptrField)+"");"_";"-")
		
	Else 
		
End case 
