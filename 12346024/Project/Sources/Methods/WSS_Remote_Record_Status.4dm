//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 01/13/15, 20:53:03
// ----------------------------------------------------
// Method: WSS_Remote_Record_Status
// Description
// 
//     generic method to get a record status
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
C_LONGINT:C283(WSS_iField; $iType; $i)
C_TEXT:C284(WSS_tSearchValue)
C_TEXT:C284(WSS_tSite)
C_TEXT:C284(WSS_tSecurity; $tXML; $sFieldName)

C_BLOB:C604(WSS_xRecord; $xRecord)  // xml_bag record - parse with XB_BlobToBag - then use xml_bag command to get results


C_POINTER:C301($ptrField; $ptrTable)
C_BOOLEAN:C305($bIsAuthorized; $bReadOnly)
//C_TEXT($tVar)



//INITIALIZATION

SET BLOB SIZE:C606(WSS_xRecord; 0)  //init

SOAP DECLARATION:C782(WSS_iTable; Is longint:K8:6; SOAP input:K46:1; "Table")
SOAP DECLARATION:C782(WSS_iField; Is longint:K8:6; SOAP input:K46:1; "Field")
SOAP DECLARATION:C782(WSS_tSearchValue; Is text:K8:3; SOAP input:K46:1; "Search")
SOAP DECLARATION:C782(WSS_tSite; Is text:K8:3; SOAP input:K46:1; "Site")
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
			: (Records in selection:C76([eWires:13])=1) & ([eWires:13]securityChallengeCode:75#WSS_tSecurity)  //found and security rejected
				XB_PutText($tXML; "requestStatus"; "FAIL-SECURITY")
				
			: (Records in selection:C76([eWires:13])=1) & ([eWires:13]securityChallengeCode:75=WSS_tSecurity)  //found and security validated
				XB_PutText($tXML; "requestStatus"; "SUCCESS")
				
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]SendDate:2); ->[eWires:13]SendDate:2)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]SenderName:7); ->[eWires:13]SenderName:7)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]BeneficiaryFullName:5); ->[eWires:13]BeneficiaryFullName:5)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]FromAmount:13); ->[eWires:13]FromAmount:13)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]ToAmount:14); ->[eWires:13]ToAmount:14)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]Currency:12); ->[eWires:13]Currency:12)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]fromCountry:9); ->[eWires:13]fromCountry:9)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]toCountry:10); ->[eWires:13]toCountry:10)
				
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]fromCountryCode:111); ->[eWires:13]fromCountryCode:111)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]toCountryCode:112); ->[eWires:13]toCountryCode:112)
				
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]isSettled:23); ->[eWires:13]isSettled:23)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]comments_Visible:48); ->[eWires:13]comments_Visible:48)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]isLocked:79); ->[eWires:13]isLocked:79)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]lockedSite:83); ->[eWires:13]lockedSite:83)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]lockedDate:80); ->[eWires:13]lockedDate:80)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]lockedTime:81); ->[eWires:13]lockedTime:81)
				XB_PutVariable($tXML; Field name:C257(->[eWires:13]BeneficiaryAmendedName:119); ->[eWires:13]BeneficiaryAmendedName:119)
				
			: (Records in selection:C76([eWires:13])>1)
				XB_PutText($tXML; "requestStatus"; "FAIL-MULTIPLE RECORDS FOUND")
			Else   //not not found
				XB_PutText($tXML; "requestStatus"; "FAIL-NOT FOUND")
		End case 
		
		
		
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
				
				For ($i; 1; 10)
					If (Is field number valid:C1000(Table:C252($ptrTable); $i))
						$ptrField:=Field:C253(Table:C252($ptrTable); $i)
						$sFieldName:=Field name:C257($ptrField)
						
						XB_PutVariable($tXML; $sFieldName; $ptrField)
					End if 
					
				End for 
				
				
			: (Records in selection:C76($ptrTable->)>1)
				XB_PutText($tXML; "requestStatus"; "FAIL-MULTIPLE RECORDS FOUND")
			Else 
				XB_PutText($tXML; "requestStatus"; "FAIL-NOT FOUND")
		End case 
		
End case 

If (XB_GetText($tXML; "requestStatus")="SUCCESS@")
Else 
	UTIL_Log("EWIRE"; "STATUS FAILURE:[EWire]ID: "+WSS_tSearchValue+" - "+XB_GetText($tXML; "requestStatus")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
End if 

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

