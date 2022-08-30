//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 01/14/15, 17:33:21
// ----------------------------------------------------
// Method: WSS_Save_Remote_Record
// Description
// 
//    Locates the record in the table (WSS_iTable) where the field (WSS_iField) has the value (WSS_tSearchValue)
//
//     If found then delete the existing record and replace with the record passed in
//     If not found then create and add the record passed in
//
//     Maybe remove the security and use the XML to have additional authorization info
//
// Parameters
// ----------------------------------------------------



//METHOD COMMENTS
//

//DECLARATIONS
C_LONGINT:C283(WSS_iTable)
C_LONGINT:C283(WSS_iField)
C_TEXT:C284(WSS_tSearchValue)
C_TEXT:C284(WSS_tSecurity; $tXML)  //  security question

C_BLOB:C604(WSS_xRecord)  // xml_bag record - parse with XB_BlobToBag - then use xml_bag command to get results





C_POINTER:C301($ptrField; $ptrTable)
C_BOOLEAN:C305($bIsAuthorized; $bReadOnly)
C_LONGINT:C283($iError; $iType)


//INITIALIZATION

SOAP DECLARATION:C782(WSS_iTable; Is longint:K8:6; SOAP input:K46:1; "Table")
SOAP DECLARATION:C782(WSS_iField; Is longint:K8:6; SOAP input:K46:1; "Field")
SOAP DECLARATION:C782(WSS_tSearchValue; Is text:K8:3; SOAP input:K46:1; "Search")
SOAP DECLARATION:C782(WSS_xRecord; Is BLOB:K8:12; SOAP input:K46:1; "Record")
SOAP DECLARATION:C782(WSS_tSecurity; Is text:K8:3; SOAP input:K46:1; "Security")
SOAP DECLARATION:C782(WSS_iError; Is longint:K8:6; SOAP output:K46:2; "Error")

//MAIN CODE

$ptrTable:=Table:C252(WSS_iTable)
$ptrField:=Field:C253(WSS_iTable; WSS_iField)
$bIsAuthorized:=True:C214
$iError:=0


//add any security checks here for specific tables
Case of 
	: ($ptrTable=(->[eWires:13]))
		$bIsAuthorized:=True:C214
	Else 
		$bIsAuthorized:=True:C214
End case 


If ($bIsAuthorized)
	
	$tXML:=XB_BlobToBag(WSS_xRecord)  //retreive the record
	
	$bReadOnly:=Read only state:C362($ptrTable->)
	
	READ WRITE:C146($ptrTable->)
	
	$iType:=Type:C295($ptrField->)
	
	If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
		QUERY:C277($ptrTable->; $ptrField->=Num:C11(WSS_tSearchValue))
	Else 
		QUERY:C277($ptrTable->; $ptrField->=WSS_tSearchValue)
	End if 
	
	Case of 
		: (Records in selection:C76($ptrTable->)=0)
			
		: (Records in selection:C76($ptrTable->)=1)
			DELETE RECORD:C58($ptrTable->)
		Else   //found multiple records might be a problem???
			$iError:=-2
	End case 
	
	If ($iError=0)
		CREATE RECORD:C68($ptrTable->)
		XB_GetRecord($tXML; "record"; $ptrTable)
		SAVE RECORD:C53($ptrTable->)
	End if 
	
	XB_Clear($tXML)
	
	If ($bReadOnly)  //restore to read only if that's how we found it
		READ ONLY:C145($ptrTable->)
	End if 
	
Else 
	$iError:=-1
End if 


WSS_iError:=$iError
