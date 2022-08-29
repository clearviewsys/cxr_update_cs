//%attributes = {"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/12/15, 09:20:03
// ----------------------------------------------------
// Method: WSS_Remote_List_Load
// Description
//     $1 = table number of records to return
//     $2 = query -- not sure yet -- SQL???
//     $3 = blob -- of arrays for list ???

//   eWiresGetListRemotely (fromCountry; toCountry; fromDate; toDate; isFetched; isSettled)
//
//    could use encryption on return blob ? other security?
//
// Parameters
// ----------------------------------------------------



//METHOD COMMENTS
//

//DECLARATIONS
C_LONGINT:C283(WSS_iTable)
C_TEXT:C284(WSS_tSearch)
C_BLOB:C604(WSS_xFieldList)  //<-- variable to blob or a pointer array to fields to return

C_TEXT:C284(WSS_tSite)
C_TEXT:C284(WSS_tSecurity)  //  security question

C_BLOB:C604(WSS_xList)  // xml_bag - parse with XB_BlobToBag - then use xml_bag command to get results


C_POINTER:C301($ptrField; $ptrTable)
C_BOOLEAN:C305($bIsAuthorized; $bReadOnly)
C_LONGINT:C283($i; $iCount; $iField; $iTable; $iType)
C_BLOB:C604($xList)

C_TEXT:C284($tXML; $tVar)


//INITIALIZATION

SET BLOB SIZE:C606(WSS_xRecord; 0)  //init

SOAP DECLARATION:C782(WSS_iTable; Is longint:K8:6; SOAP input:K46:1; "Table")
SOAP DECLARATION:C782(WSS_xFieldList; Is BLOB:K8:12; SOAP input:K46:1; "FieldList")
SOAP DECLARATION:C782(WSS_tSearch; Is text:K8:3; SOAP input:K46:1; "Search")

//SOAP DECLARATION(WSS_tSite;Is Text;SOAP Input;"Site")
//SOAP DECLARATION(WSS_tSecurity;Is Text;SOAP Input;"Security")

SOAP DECLARATION:C782(WSS_xList; Is BLOB:K8:12; SOAP output:K46:2; "List")

//MAIN CODE


$iTable:=WSS_iTable
$ptrTable:=Table:C252($iTable)


$tXML:=XB_BlobToBag(WSS_xFieldList)  //get our list of fields to return
ARRAY TEXT:C222($atList; 0)
XB_GetAllItems($tXML; ->$atList)
$iCount:=XB_ItemCount($tXML; "FieldList")



//$tXML:=XB_New   //init a return object

$bReadOnly:=Read only state:C362($ptrTable->)
READ WRITE:C146($ptrTable->)


//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES


If (WSS_tSearch="")
	//ALL RECORDS(Table($iTable)->)
Else 
	QUERY BY SQL:C942($ptrTable->; WSS_tSearch)
End if 


Case of 
		//: (False)  //Records in selection([(eWires)])>0)
	: (Records in selection:C76(Table:C252($iTable)->)>0)
		
		ARRAY LONGINT:C221($aiList; 0)
		ARRAY REAL:C219($arList; 0)
		ARRAY TEXT:C222($atList; 0)
		ARRAY DATE:C224($adList; 0)
		ARRAY BOOLEAN:C223($abList; 0)
		ARRAY PICTURE:C279($apList; 0)
		//array time($ahList;0)
		//ARRAY BLOB($axList;0) `v13 doesn't handle blob arrays
		
		If (WSS_tSecurity=WSS_tSecurity)  //is Authorized so send record
			XB_PutText($tXML; "requestStatus"; "SUCCESS")
			XB_PutLong($tXML; "DataListCount"; $iCount)
			
			For ($i; 1; $iCount)  //loop thru the field count
				
				XB_GetVariable($tXML; "FieldList.Field"+String:C10($i); ->$iField)
				$ptrField:=Field:C253($iTable; $iField)
				$iType:=Type:C295($ptrField->)
				
				Case of 
					: ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
						SELECTION TO ARRAY:C260($ptrField->; $aiList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$aiList)
						
					: ($iType=Is real:K8:4)
						SELECTION TO ARRAY:C260($ptrField->; $arList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$arList)
						
					: ($iType=Is date:K8:7)
						SELECTION TO ARRAY:C260($ptrField->; $adList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$adList)
						
					: ($iType=Is boolean:K8:9)
						SELECTION TO ARRAY:C260($ptrField->; $abList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$abList)
						
					: ($iType=Is time:K8:8)  //<-- need to check what this is formated like? might be an issue
						SELECTION TO ARRAY:C260($ptrField->; $aiList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$aiList)
						
					: ($iType=Is BLOB:K8:12)
						//SELECTION TO ARRAY($ptrField->;$axList)
						//XB_PutArray ($tXML;"DataList.List"+String($i);->$axList)
						
					: ($iType=Is picture:K8:10)
						SELECTION TO ARRAY:C260($ptrField->; $apList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$apList)
						
					Else   //assume text or string
						SELECTION TO ARRAY:C260($ptrField->; $atList)
						XB_PutArray($tXML; "DataList.List"+String:C10($i); ->$atList)
						
				End case 
				
			End for 
			
			
		Else 
			XB_PutText($tXML; "requestStatus"; "FAIL-SECURITY")
		End if 
		
	Else   //not not found
		XB_PutText($tXML; "requestStatus"; "FAIL-NOT FOUND")
End case 



//XB_Clear ($tXMLFieldList)


$xList:=XB_BagToBlob($tXML)

If (Current user:C182="designer")
	DOM EXPORT TO VAR:C863($tXML; $tVar)
	SET TEXT TO PASTEBOARD:C523($tVar)  //for debugging comment out for production
End if 
//XB_ViewBags ($tXML)

XB_Clear($tXML)

UNLOAD RECORD:C212($ptrTable->)
REDUCE SELECTION:C351($ptrTable->; 0)

If ($bReadOnly)
	READ ONLY:C145($ptrTable->)
End if 

WSS_xList:=$xList

