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
C_TEXT:C284($4; $tSite)
C_TEXT:C284($5; $tSecurity)  //security code - optional
C_TEXT:C284($6; $tServerURL)
C_POINTER:C301($7; $ptrResult)

C_LONGINT:C283($0; $iError)

C_POINTER:C301($ptrField; $ptrTable)
C_TEXT:C284($tXML; $tStatus; $tResult)
C_LONGINT:C283($iCount; $i)
C_BLOB:C604($xBlob)
C_TEXT:C284($encodedText; $requestBag; $responseBag)
C_OBJECT:C1216($status; $request)


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
	$tSite:=$4
Else 
	$tSite:=<>branchPrefix
End if 

If (Count parameters:C259>=5)
	$tSecurity:=$5
Else 
	$tSecurity:=""
End if 

If (Count parameters:C259>=6)
	$tServerURL:=$6
End if 

If ($tServerURL="")
	$tServerURL:="http://localhost:8080"
End if 


If (getKeyValue("ewire.protocol"; "true")="true")  //try HTTP
	$request:=New object:C1471
	$request.url:=$tServerURL+"/4DREMOTE/"
	$request.compression:="none"
	$request.timeOut:=5
	
	$requestBag:=XB_New
	XB_PutText($requestBag; "Request_Type"; "STATUS")
	XB_PutText($requestBag; "Request_Site"; $tSite)
	XB_PutLong($requestBag; "Request_Table"; $iTable)
	XB_PutLong($requestBag; "Request_Field"; $iField)
	XB_PutText($requestBag; "Request_SearchValue"; $tValue)
	XB_PutText($requestBag; "Request_SecurityCode"; $tSecurity)
	
	$xBlob:=XB_BagToBlob($requestBag)
	XB_Clear($requestBag)
	
	BASE64 ENCODE:C895($xBlob; $encodedText)
	$request.request:=$encodedText
	
	$status:=WSS_httpPost($request)
	
	If ($status.success)
		$encodedText:=$status.response
		BASE64 DECODE:C896($encodedText; $xBlob)
		//$responseBag:=XB_BlobToBag ($xBlob)
	End if 
	
Else 
	//If (XB_IsBag ($responseBag)=False)  //http call failed fall back to webservice
	If (BLOB size:C605($xBlob)=0)
		WEB SERVICE SET PARAMETER:C777("Table"; $iTable)
		WEB SERVICE SET PARAMETER:C777("Field"; $iField)
		WEB SERVICE SET PARAMETER:C777("Search"; $tValue)
		WEB SERVICE SET PARAMETER:C777("Security"; $tSecurity)
		WEB SERVICE SET PARAMETER:C777("Site"; $tSite)
		
		WEB SERVICE CALL:C778($tServerURL+"/4DSOAP/"; "cxr_Services#WSS_Remote_Record_Status"; "WSS_Remote_Record_Status"; "http://www.clearviewsys.com/namespace"; Web Service dynamic:K48:1)
		
		If (OK=1)
			WEB SERVICE GET RESULT:C779($xBlob; "Record"; *)  // Memory clean-up on the final return value.
		End if 
		
		$iError:=0
	End if 
	
End if 


If (BLOB size:C605($xBlob)>0)
	
	$responseBag:=XB_BlobToBag($xBlob)
	
	$ptrTable:=Table:C252($iTable)
	$ptrField:=Field:C253($iTable; $iField)
	
	$tStatus:=XB_GetText($responseBag; "requestStatus")
	If ($tStatus="")
		$tStatus:=XB_GetText($responseBag; "statusText")
	End if 
	
	Case of 
		: ($tStatus="SUCCESS")
			
			If (Count parameters:C259>=7)
				$7->:=$xBlob
			Else 
				
				ARRAY TEXT:C222($atItems; 0)
				XB_GetAllItems($responseBag; ->$atItems)
				
				$iCount:=XB_ItemCount($responseBag)
				$tResult:=""
				
				For ($i; 1; $iCount)
					$tResult:=$tResult+$atItems{$i}+": "+XB_GetText($responseBag; $atItems{$i})+Char:C90(Carriage return:K15:38)
				End for 
				
				myAlert($tResult)
			End if 
			
		: ($tStatus="FAIL-SECURITY@")
			$iError:=-1
			//LOG HERE?
			
		: ($tStatus="FAIL-NOT FOUND@")
			$iError:=-2
			//LOG HERE?
			
		: ($tStatus="FAIL-MULTIPLE RECORDS FOUND@")
			$iError:=-3
			//LOG HERE?
			
		: ($tStatus="FAIL-EWIRE IS LOCKED@")
			$iError:=-20
			//LOG HERE?
			
			
		Else 
			$iError:=-6
			//LOG HERE?
	End case 
End if 

If (XB_IsBag($responseBag))
	XB_Clear($responseBag)
End if 

If ($iError=0)
Else 
	UTIL_Log(Table name:C256($ptrTable); "STATUS ERROR: "+String:C10($iError)+" "+$tStatus+" "+Table name:C256($ptrTable)+" "+Field name:C257($ptrField)+" "+$tValue)
End if 

$0:=$iError