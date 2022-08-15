//%attributes = {"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 09/16/16, 09:49:36
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: WSS_Remote_getTableSchema
// Description
// 
//
// Parameters
// ----------------------------------------------------




//DECLARATIONS
C_TEXT:C284(WSS_tSecurity)  // security code -- might need to enhance user/pw

C_BLOB:C604(WSS_xResult)  //xml bag with arrays for table name and nums


C_TEXT:C284($tXML; $tVar)
C_BLOB:C604($xResult)
C_BOOLEAN:C305($bValid)
C_LONGINT:C283($i)

//INITIALIZATION

SET BLOB SIZE:C606(WSS_xResult; 0)  //init

SOAP DECLARATION:C782(WSS_tSecurity; Is text:K8:3; SOAP input:K46:1; "security")
SOAP DECLARATION:C782(WSS_xResult; Is BLOB:K8:12; SOAP output:K46:2; "result")


//MAIN CODE
ARRAY TEXT:C222($atTables; 0)
ARRAY LONGINT:C221($aiTables; 0)

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
	
	For ($i; 1; Get last table number:C254)
		If (Is table number valid:C999($i))
			APPEND TO ARRAY:C911($atTables; Table name:C256($i))
			APPEND TO ARRAY:C911($aiTables; $i)
		End if 
	End for 
	
	XB_PutArray($tXML; "tableNameArray"; ->$atTables)
	XB_PutArray($tXML; "tableNumArray"; ->$aiTables)
	
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