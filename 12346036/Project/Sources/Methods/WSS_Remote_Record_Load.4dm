//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 01/13/15, 20:53:03
// ----------------------------------------------------
// Method: WSS_Load_Remote_Record
// Description
// 
//    call this to check and see if an eWire is available for a customer
//    pass in a reference number and the answer to a security question
//
// Parameters
// ----------------------------------------------------




//METHOD COMMENTS
//

//DECLARATIONS
C_LONGINT:C283(WSS_iTable)
C_LONGINT:C283(WSS_iField; $iType)
C_TEXT:C284(WSS_tSearchValue; $tXML)
C_TEXT:C284(WSS_tSite)
C_TEXT:C284(WSS_tSecurity)  // eWire security question

C_BLOB:C604(WSS_xRecord; $xRecord)  // xml_bag record - parse with XB_BlobToBag - then use xml_bag command to get results


C_POINTER:C301($ptrField; $ptrTable)
C_BOOLEAN:C305($bIsAuthorized; $bReadOnly)



//INITIALIZATION

SET BLOB SIZE:C606(WSS_xRecord; 0)  //init

SOAP DECLARATION:C782(WSS_iTable; Is longint:K8:6; SOAP input:K46:1; "Table")
SOAP DECLARATION:C782(WSS_iField; Is longint:K8:6; SOAP input:K46:1; "Field")
SOAP DECLARATION:C782(WSS_tSite; Is text:K8:3; SOAP input:K46:1; "Site")
SOAP DECLARATION:C782(WSS_tSearchValue; Is text:K8:3; SOAP input:K46:1; "Search")
SOAP DECLARATION:C782(WSS_tSecurity; Is text:K8:3; SOAP input:K46:1; "Security")

SOAP DECLARATION:C782(WSS_xRecord; Is BLOB:K8:12; SOAP output:K46:2; "Record")

//MAIN CODE


$ptrTable:=Table:C252(WSS_iTable)
$ptrField:=Field:C253(WSS_iTable; WSS_iField)


$tXML:=XB_New  //init a return object


$bReadOnly:=Read only state:C362($ptrTable->)
READ WRITE:C146($ptrTable->)


//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES

Case of 
	: ($ptrTable=(->[eWires:13]))
		
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=WSS_tSearchValue)
		
		Case of 
			: (Records in selection:C76([eWires:13])=1) & ([eWires:13]isLocked:79)  //ewire has already been retrieved
				XB_PutText($tXML; "requestStatus"; "FAIL-EWIRE IS LOCKED by "+[eWires:13]lockedSite:83+" "+String:C10([eWires:13]lockedDate:80)+" "+String:C10([eWires:13]lockedTime:81))
				
			: (Records in selection:C76([eWires:13])=1) & ([eWires:13]isSettled:23)  // eWire is settled - PAID already
				XB_PutText($tXML; "requestStatus"; "FAIL-EWIRE IS SETTLED")
				
			: (Records in selection:C76([eWires:13])=1) & ([eWires:13]isCancelled:34)  // eWire is Cancelled
				XB_PutText($tXML; "requestStatus"; "FAIL-EWIRE IS CANCELLED")
				
			: (Records in selection:C76([eWires:13])=1) & (Not:C34([eWires:13]isLocked:79))
				
				//NEED TO CHECK 4D LOCKING -- MUST BE LOADED AND READY TO WRITE
				// IF 4D LOCKED THE RECORD THEN PASS BACK AN ERROR
				//MUST BE COPIED TO EWIRE SERVER AND VM2 -->V15 VERSION
				//  ADD LOGGING TO THIS ON DISK
				
				If (isRecordLoaded(->[eWires:13]))
					If ([eWires:13]securityChallengeCode:75=WSS_tSecurity)  //is Authorized so send record
						XB_PutText($tXML; "requestStatus"; "SUCCESS")
						
						[eWires:13]isLocked:79:=True:C214
						[eWires:13]lockedDate:80:=Current date:C33
						[eWires:13]lockedTime:81:=Current time:C178
						[eWires:13]lockedIP:82:=WebClientIP
						[eWires:13]lockedSite:83:=WSS_tSite
						SAVE RECORD:C53([eWires:13])
						
						XB_PutRecord($tXML; "record"; $ptrTable)
						
					Else 
						XB_PutText($tXML; "requestStatus"; "FAIL-SECURITY")
					End if 
				Else 
					XB_PutText($tXML; "requestStatus"; "FAIL-RECORD LOCKED BY ANOTHER 4D PROCESS")
				End if 
				
				
			: (Records in selection:C76([eWires:13])>1)
				XB_PutText($tXML; "requestStatus"; "FAIL-MULTIPLE RECORDS FOUND")
			Else   //not not found
				XB_PutText($tXML; "requestStatus"; "FAIL-NOT FOUND")
		End case 
		
		If (XB_GetText($tXML; "requestStatus")="SUCCESS@")
			UTIL_Log("EWIRE"; "LOAD SUCCESS:[EWire]ID: "+WSS_tSearchValue+" - "+XB_GetText($tXML; "requestStatus")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
			//DOM EXPORT TO VAR($tXML;$tVar)
			//UTIL_Log ("EWIRE";"DATA SENT: "+$tVar)
		Else 
			UTIL_Log("EWIRE"; "LOAD FAILURE:[EWire]ID: "+WSS_tSearchValue+" - "+XB_GetText($tXML; "requestStatus")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
		End if 
		
	Else   //ALL OTHER TABLES
		
		$iType:=Type:C295($ptrField->)
		
		If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
			QUERY:C277($ptrTable->; $ptrField->=Num:C11(WSS_tSearchValue))
		Else 
			QUERY:C277($ptrTable->; $ptrField->=WSS_tSearchValue)
		End if 
		
		Case of 
			: (Records in selection:C76($ptrTable->)=1)
				XB_PutText($tXML; "requestStatus"; "SUCCESS")
				XB_PutRecord($tXML; "record"; $ptrTable)
			: (Records in selection:C76($ptrTable->)>1)
				XB_PutText($tXML; "requestStatus"; "FAIL-MULTIPLE RECORDS FOUND")
			Else 
				XB_PutText($tXML; "requestStatus"; "FAIL-NOT FOUND")
		End case 
		
		UTIL_Log(Current method name:C684; "Search Value: "+WSS_tSearchValue+" - "+XB_GetText($tXML; "requestStatus"))
		
End case 


//If ($bIsAuthorized)
//$iType:=Type($ptrField->)
//
//If ($iType=Is LongInt) | ($iType=Is Real) | ($iType=Is Integer)  //add other case statements to handle other types
//QUERY($ptrTable->;$ptrField->=Num(WSS_tSearchValue))
//Else 
//QUERY($ptrTable->;$ptrField->=WSS_tSearchValue)
//End if 
//
//If (Records in selection($ptrTable->)=1)
//XB_PutText ($tXML;"requestStatus";"SUCCESS")
//XB_PutRecord ($tXML;"record";$ptrTable)
//$xRecord:=XB_BagToBlob ($tXML)
//Else 
//XB_PutText ($tXML;"requestStatus";"FAIL-NOT FOUND")
//$xRecord:=XB_BagToBlob ($tXML)
//End if 
//
//Else 
//XB_PutText ($tXML;"requestStatus";"FAIL-SECURITY")
//$xRecord:=XB_BagToBlob ($tXML)
//End if 


$xRecord:=XB_BagToBlob($tXML)
//DOM EXPORT TO VAR($tXML;$tVar)
//SET TEXT TO PASTEBOARD($tVar)  //for debugging comment out for production
XB_Clear($tXML)

UNLOAD RECORD:C212($ptrTable->)
REDUCE SELECTION:C351($ptrTable->; 0)

If ($bReadOnly)
	READ ONLY:C145($ptrTable->)
End if 

WSS_xRecord:=$xRecord

