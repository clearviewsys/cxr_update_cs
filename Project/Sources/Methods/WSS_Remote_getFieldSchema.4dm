//%attributes = {"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 09/16/16, 09:49:36
// Copyright 2016 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: WSS_Remote_getTableSchema
// Description
// 
//
// Parameters
// ----------------------------------------------------




//DECLARATIONS
C_TEXT:C284(WSS_tSecurity)  // security code -- might need to enhance user/pw
C_LONGINT:C283(WSS_iTable)  //table to get field names/number for
C_BLOB:C604(WSS_xResult)  //xml bag with arrays for table name and nums


C_TEXT:C284($tXML; $tVar)
C_BLOB:C604($xResult)
C_LONGINT:C283($i; $iLength; $iType)
C_POINTER:C301($ptrField)
C_BOOLEAN:C305($bIndex; $bInvisible; $bUnique; $bValid)


//INITIALIZATION

SET BLOB SIZE:C606(WSS_xResult; 0)  //init

SOAP DECLARATION:C782(WSS_tSecurity; Is text:K8:3; SOAP input:K46:1; "security")
SOAP DECLARATION:C782(WSS_iTable; Is longint:K8:6; SOAP input:K46:1; "table")
SOAP DECLARATION:C782(WSS_xResult; Is BLOB:K8:12; SOAP output:K46:2; "result")


//MAIN CODE
ARRAY TEXT:C222($atFields; 0)
ARRAY LONGINT:C221($aiFields; 0)
ARRAY LONGINT:C221($aiTypes; 0)
ARRAY LONGINT:C221($aiLengths; 0)

$tXML:=XB_New  //init return object

If (False:C215)
	If (WSS_tSecurity="")
		$bValid:=True:C214
	Else 
		$bValid:=False:C215
	End if 
Else 
	$bValid:=True:C214
End if 


If ($bValid)
	For ($i; 1; Get last field number:C255(WSS_iTable))
		If (Is field number valid:C1000(WSS_iTable; $i))
			APPEND TO ARRAY:C911($atFields; Field name:C257(WSS_iTable; $i))
			APPEND TO ARRAY:C911($aiFields; $i)
			
			$ptrField:=Field:C253(WSS_iTable; $i)
			GET FIELD PROPERTIES:C258($ptrField; $iType; $iLength; $bIndex; $bUnique; $bInvisible)
			
			APPEND TO ARRAY:C911($aiTypes; $iType)
			APPEND TO ARRAY:C911($aiLengths; $iLength)
		End if 
	End for 
	
	XB_PutArray($tXML; "fieldNameArray"; ->$atFields)
	XB_PutArray($tXML; "fieldNumArray"; ->$aiFields)
	XB_PutArray($tXML; "fieldTypeArray"; ->$aiTypes)
	XB_PutArray($tXML; "fieldLengthArray"; ->$aiLengths)
	
	XB_PutText($tXML; "requestStatus"; "SUCCESS")
	
Else 
	XB_PutText($tXML; "requestStatus"; "FAIL-SECURITY")
End if 


$xResult:=XB_BagToBlob($tXML)

If (Is compiled mode:C492)
Else 
	DOM EXPORT TO VAR:C863($tXML; $tVar)
	SET TEXT TO PASTEBOARD:C523($tVar)  //for debugging comment out for production
End if 

XB_Clear($tXML)

WSS_xResult:=$xResult