//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/12/15, 09:20:35
// ----------------------------------------------------
// Method: WS_Remote_List_Load
// Description
// 
//  //     currently can only retrive field data from the parent table

// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $tableNum; $fieldNum)  //table number
C_TEXT:C284($2; $tQuery)  //search value

C_TEXT:C284($3; $serverURL)
C_TEXT:C284($4; $securityCode)  //security code - optional -- not used yet

C_POINTER:C301(${5})



C_BLOB:C604($0; $xList; $xFieldList)

C_TEXT:C284($tXML; $encodedText; $requestBag; $tServerURL; $tQuery)
C_LONGINT:C283($i; $iError; $iTable)
C_POINTER:C301($ptrField)
C_OBJECT:C1216($status; $request)
C_BOOLEAN:C305($useJSON)

If (Count parameters:C259>=1)
	$iTable:=$1
Else 
	$iTable:=Table:C252(->[eWires:13])
End if 

If (Count parameters:C259>=2)
	$tQuery:=$2
Else   //build a basic sql query for all records
	$tQuery:=Table name:C256($tableNum)+"."+Field name:C257($tableNum; Field:C253(->[eWires:13]isSettled:23))+" = FALSE"
End if 

If (Count parameters:C259>=3)
	$tServerURL:=$3
Else 
	$tServerURL:=""
End if 

If (Count parameters:C259>=4)
	$securityCode:=$4
Else 
	$securityCode:=""
End if 

If ($tServerURL="")
	$tServerURL:="http://localhost:8080"
End if 


SET BLOB SIZE:C606($xBlob; 0)
$useJSON:=Choose:C955(getKeyValue("ewire.useJSON"; "false")="true"; True:C214; False:C215)  // ----------------------------  CHANGE TO TRUE ONCE TESTED ------

$requestBag:=XB_New

If (Count parameters:C259>=5)
	For ($i; 5; Count parameters:C259)
		$fieldNum:=Field:C253(${$i})
		XB_PutVariable($requestBag; "FieldList.Field"+String:C10($i-4); ->$fieldNum)
	End for 
Else 
	For ($i; 1; 5)
		If (Is field number valid:C1000($iTable; $i))
			$ptrField:=Field:C253($iTable; $i)
			XB_PutVariable($requestBag; "FieldList."+Field name:C257($ptrField); $ptrField)
		End if 
	End for 
End if 


If (getKeyValue("ewire.protocol"; "true")="true")  //try HTTP
	$request:=New object:C1471
	$request.url:=$tServerURL+"/4DREMOTE/"
	$request.compression:="none"
	$request.timeOut:=15
	
	
	XB_PutText($requestBag; "Request_Type"; "LIST")
	XB_PutBoolean($requestBag; "Request_JSON"; $useJSON)
	XB_PutLong($requestBag; "Request_Table"; $iTable)
	//XB_PutLong ($requestBag;"Request_Field";$iField)
	XB_PutText($requestBag; "Request_SearchValue"; $tQuery)
	XB_PutText($requestBag; "Request_SecurityCode"; $securityCode)
	
	$xBlob:=XB_BagToBlob($requestBag)
	XB_Clear($requestBag)
	
	BASE64 ENCODE:C895($xBlob; $encodedText)
	$request.request:=$encodedText
	
	$status:=WSS_httpPost($request)
	
	If ($status.success)
		$encodedText:=$status.response
		BASE64 DECODE:C896($encodedText; $xBlob)
		//$responseBag:=XB_BlobToBag ($xBlob)
	Else 
		SET BLOB SIZE:C606($xBlob; 0)
		$iError:=-1
	End if 
	
Else 
	
	If (BLOB size:C605($xBlob)=0)
		
		$xBlob:=XB_BagToBlob($requestBag)
		XB_Clear($requestBag)
		
		WEB SERVICE SET PARAMETER:C777("Table"; $iTable)
		WEB SERVICE SET PARAMETER:C777("FieldList"; $xBlob)
		WEB SERVICE SET PARAMETER:C777("Search"; $tQuery)
		WEB SERVICE SET PARAMETER:C777("Security"; $securityCode)
		
		WEB SERVICE CALL:C778($tServerURL+"/4DSOAP/"; "cxr_Services#WSS_Remote_List_Load"; "WSS_Remote_List_Load"; "http://www.clearviewsys.com/namespace"; Web Service dynamic:K48:1)
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779($xBlob; "List"; *)  // Memory clean-up on the final return value.
		End if 
		
	End if 
	
End if 






$0:=$xBlob