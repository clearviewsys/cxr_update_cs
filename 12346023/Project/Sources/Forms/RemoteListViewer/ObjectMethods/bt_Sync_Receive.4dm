

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/19/15, 18:04:08
// ----------------------------------------------------
// Method: eWireRemoteList.bt_Sync_Receive
// Description
//      currently limited by having to declare header vars and column vars
//      moving to v14 we will be able to use the automatic var feature so this will be cleaner
//     currently can only retrive field data from the parent table
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($NilPtr)
C_BLOB:C604($xBlob)
C_BLOB:C604($xList)
C_LONGINT:C283($i; $iCount; $iError; $iFieldNum; $iTable)
C_TEXT:C284($tQuery; $tStatus; $tXML; $json)
C_BOOLEAN:C305($useJSON)

ARRAY TEXT:C222(EWR_Col1; 0)
ARRAY TEXT:C222(EWR_Col2; 0)
ARRAY TEXT:C222(EWR_Col3; 0)
ARRAY TEXT:C222(EWR_Col4; 0)
ARRAY TEXT:C222(EWR_Col5; 0)
ARRAY TEXT:C222(EWR_Col6; 0)
ARRAY TEXT:C222(EWR_Col7; 0)
ARRAY TEXT:C222(EWR_Col8; 0)
ARRAY TEXT:C222(EWR_Col9; 0)
ARRAY TEXT:C222(EWR_Col10; 0)

C_TEXT:C284(EWR_Head1; EWR_Head2; EWR_Head3; EWR_Head4; EWR_Head5; EWR_Head6; EWR_Head7; EWR_Head8; EWR_Head9; EWR_Head10)



$iTable:=Table:C252(->[eWires:13])
$tQuery:=Table name:C256($iTable)+"."+Field name:C257($iTable; Field:C253(->[eWires:13]isSettled:23))+" = FALSE"


//call web service here
//$xList:=WS_Remote_List_Load ($iTable;$tQuery;<>eWireServerURL;"";->[eWires]eWireID;->[eWires]creationDate;->[eWires]BeneficiaryFullName;->[eWires]toCountry;->[eWires]ToAmount;->[eWires]isSettled)

$xList:=WS_Remote_List_Load($iTable; $tQuery; "http://127.0.0.1:8080"; ""; ->[eWires:13]eWireID:1; ->[eWires:13]creationDate:53; ->[eWires:13]BeneficiaryFullName:5; ->[eWires:13]toCountry:10; ->[eWires:13]ToAmount:14; ->[eWires:13]isSettled:23)


If (BLOB size:C605($xList)>0)
	
	ARRAY TEXT:C222($atItemList; 0)
	
	$tXML:=XB_BlobToBag($xList)
	
	//XB_ViewBags ($tXML)
	
	$tStatus:=XB_GetText($tXML; "requestStatus")
	
	Case of 
		: ($tStatus="SUCCESS")
			
			$useJSON:=XB_GetBoolean($tXML; "requestJSON")
			$iCount:=XB_ItemCount($tXML; "FieldList")
			
			XB_GetAllItems($tXML; ->$atItemList)
			
			
			For ($i; 1; $iCount)
				C_POINTER:C301($ptrCol; $ptrHead)
				$ptrCol:=Get pointer:C304("EWR_Col"+String:C10($i))
				$ptrHead:=Get pointer:C304("EWR_Head"+String:C10($i))  //Definition of header
				
				If ($useJSON)
					$json:=XB_GetText($tXML; "DataList.List"+String:C10($i))
					JSON PARSE ARRAY:C1219($json; $ptrCol->)
				Else 
					XB_GetVariable($tXML; "DataList.List"+String:C10($i); $ptrCol)
				End if 
				
				LISTBOX INSERT COLUMN:C829(*; "lb_eWire"; $i; "Column"+String:C10($i); $ptrCol->; "Header"+String:C10($i); $ptrHead->)
				
				XB_GetVariable($tXML; "FieldList.Field"+String:C10($i); ->$iFieldNum)
				OBJECT SET TITLE:C194($ptrHead->; Field name:C257($iTable; $iFieldNum))
				
			End for 
			
			
			
			
		: ($tStatus="FAIL-SECURITY")
			$iError:=-1
			myAlert("Fail - Security")
			//LOG HERE?
			
		: ($tStatus="FAIL-NOT FOUND")
			$iError:=-2
			//LOG HERE?
			myAlert("Fail - No Records Found")
			
		Else 
			$iError:=-6
			//LOG HERE?
			myAlert("Fail - Unknown Error")
			
	End case 
	
	XB_Clear($tXML)
	
End if 




