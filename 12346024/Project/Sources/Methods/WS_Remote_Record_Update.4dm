//%attributes = {}
// 
// WS_Load_Remote_Record
// 
// 
// Method source code automatically generated by the 4D SOAP wizard.
// ----------------------------------------------------------------



C_LONGINT:C283($1; $iTable)  //table number
C_LONGINT:C283($2; $iField)  //field number
C_TEXT:C284($3; $tValue)  //search value
C_TEXT:C284($4; $tUpdate)  //JSON array to use as update values
C_TEXT:C284($5; $tSite)
C_TEXT:C284($6; $tSecurity)  //security code - optional
C_TEXT:C284($7; $tServerURL)

C_POINTER:C301($ptrTable; $ptrField)
C_TEXT:C284($tXML; $tStatus; $tVar; $encodedText)
C_BOOLEAN:C305($bReadOnly)

C_LONGINT:C283($0; $iError; $iType)

C_BLOB:C604($xBlob)
C_OBJECT:C1216($status; $request)
C_TEXT:C284($requestBag; $responseBag)
C_LONGINT:C283($iTries)

If (Count parameters:C259>=1)
	$iTable:=$1
Else 
	$iTable:=Table:C252(->[eWires:13])
End if 

If (Count parameters:C259>=2)
	$iField:=$2
Else 
	$iField:=Field:C253(->[eWires:13]eWireID:1)
End if 

If (Count parameters:C259>=3)
	$tValue:=$3
Else 
	$tValue:=""
End if 

If (Count parameters:C259>=4)
	$tUpdate:=$4
Else 
	$tUpdate:=""
End if 

If (Count parameters:C259>=5)
	$tSite:=$5
Else 
	$tSite:=<>branchPrefix
End if 

If (Count parameters:C259>=6)
	$tSecurity:=$6
Else 
	$tSecurity:=""
End if 

If (Count parameters:C259>=7)
	$tServerURL:=$7
End if 

If ($tServerURL="")
	$tServerURL:="http://localhost:8080"
End if 


If (getKeyValue("ewire.protocol"; "false")="true")  //try HTTP
	$request:=New object:C1471
	$request.url:=$tServerURL+"/4DREMOTE/"
	$request.compression:="none"
	$request.timeOut:=5
	
	$requestBag:=XB_New
	XB_PutText($requestBag; "Request_Type"; "UPDATE")
	XB_PutText($requestBag; "Request_Site"; $tSite)
	XB_PutLong($requestBag; "Request_Table"; $iTable)
	XB_PutLong($requestBag; "Request_Field"; $iField)
	XB_PutText($requestBag; "Request_SearchValue"; $tValue)
	XB_PutText($requestBag; "Request_SecurityCode"; $tSecurity)
	XB_PutText($requestBag; "Request_Update"; $tUpdate)
	
	$xBlob:=XB_BagToBlob($requestBag)
	
	BASE64 ENCODE:C895($xBlob; $encodedText)
	$request.request:=$encodedText
	
	$iTries:=1
	Repeat 
		
		$status:=WSS_httpPost($request)
		
		If ($status.success=False:C215)
			$iTries:=$iTries+1
			SET BLOB SIZE:C606($xBlob; 0)
			XB_PutLong($requestBag; "Request_Refetch"; $iTries)
			$xBlob:=XB_BagToBlob($requestBag)
			BASE64 ENCODE:C895($xBlob; $encodedText)
			$request.request:=$encodedText
		End if 
		
	Until ($status.success) | ($iTries>5)
	
	If ($status.success)
		$encodedText:=$status.response
		BASE64 DECODE:C896($encodedText; $xBlob)
	End if 
	
	XB_Clear($requestBag)
	
Else 
	//no other option
End if 


$ptrTable:=Table:C252($iTable)
$ptrField:=Field:C253($iTable; $iField)

If (BLOB size:C605($xBlob)=0)
	UTIL_Log(Table name:C256($ptrTable); "ERROR:"+Table name:C256($ptrTable)+""+Field name:C257($ptrField)+""+$tValue+" Result BLOB Empty.")
Else 
	
	$responseBag:=XB_BlobToBag($xBlob)
	
	$tStatus:=XB_GetText($responseBag; "requestStatus")
	If ($tStatus="")
		$tStatus:=XB_GetText($responseBag; "statusText")
	End if 
	
	If ($tStatus="SUCCESS")
		$iError:=0
	Else 
		$iError:=Num:C11(Replace string:C233($tStatus; "FAILURE: Error"; ""))
	End if 
	
	If ($iError=0)
		UTIL_Log(Table name:C256($ptrTable); "SUCCESS:"+Table name:C256($ptrTable)+""+Field name:C257($ptrField)+""+$tValue)
	Else 
		UTIL_Log(Table name:C256($ptrTable); "ERROR: "+String:C10($iError)+" "+$tStatus+" "+Table name:C256($ptrTable)+" "+Field name:C257($ptrField)+" "+$tValue)
	End if 
	
	XB_Clear($responseBag)
	
End if 


$0:=$iError