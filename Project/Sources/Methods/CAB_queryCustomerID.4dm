//%attributes = {}
// 
// ws_QueryCustomerIO
// access http://10.1.101.110:7006/FCUBSCustomerService/FCUBSCustomerService and execute the ws to
// get Information about the CAB customer
// 
// ----------------------------------------------------------------

#DECLARE($custNumber : Text)->$success : Boolean

Case of 
	: (Count parameters:C259=0)
		$custNumber:="000033667"  // Testing Only
		$custNumber:="000078436"
	: (Count parameters:C259=1)
		$custNumber:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// ------------------------------------------------------------
// Variable Definitions
// ------------------------------------------------------------
C_BLOB:C604($blob)
C_LONGINT:C283($err)
C_TEXT:C284($customerXMLRef; $tagRef; $errTagRef; $errContent)

C_OBJECT:C1216($ws_response; $customerInfo; $errObj; $errInfo; $es)
$ws_response:=New object:C1471

C_TEXT:C284($errCode; $errMsg)
C_TEXT:C284($header; $path; $tmp)
C_TEXT:C284($root; $r; $soapRequest; $responseXML)
C_TEXT:C284($accessURL; $requestFile; $responseFile)
C_BOOLEAN:C305($doUpdate)

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)


// ------------------------------------------------------------
// Create Request in XML Format
// ------------------------------------------------------------


// --- CURRENTLY ONLY FETCH CUSTOMER ONCE ---
// --- ADD PULL/PUSH OPTION IN THE CUSTOMER PROFILE - NOT IN SCOPE NOW --- 

$es:=ds:C1482.Customers.query("CustomerID == :1"; $custNumber)

If ($es.length>0)
	If ($es.first().approvalStatus=-9999)
		$doUpdate:=True:C214
	End if 
Else 
	$doUpdate:=True:C214
End if 

If ($doUpdate)
	$soapRequest:=createQueryCustomerIOReq($custNumber)
	$accessURL:="http://10.1.101.110:7006/FCUBSCustomerService/FCUBSCustomerService"
	$accessURL:=getKeyValue("cab.ws.url"; $accessURL)
	
	// ------------------------------------------------------------
	// Configure Header for the request
	// ------------------------------------------------------------
	
	APPEND TO ARRAY:C911($headerNames; "Content-Type")
	APPEND TO ARRAY:C911($headerValues; "text/xml")
	
	APPEND TO ARRAY:C911($headerNames; "charset")
	APPEND TO ARRAY:C911($headerValues; "UTF-8")
	
	APPEND TO ARRAY:C911($headerNames; "Content-Length")
	APPEND TO ARRAY:C911($headerValues; String:C10(Length:C16($soapRequest)))
	
	// ------------------------------------------------------------
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 240)
	
	//SET TEXT TO PASTEBOARD($soapRequest)
	
	ON ERR CALL:C155("onErrCallIgnore")
	$err:=HTTP Request:C1158(HTTP POST method:K71:2; $accessURL; $soapRequest; $responseXML; $headerNames; $headerValues)
	ON ERR CALL:C155("")
	
	If ($err=200)
		
		$ws_response.status:=$err
		$ws_response.response:=$responseXML
		
		$responseFile:=Temporary folder:C486+"response.xml"
		TEXT TO BLOB:C554(JSON Stringify:C1217($ws_response); $blob)
		BLOB TO DOCUMENT:C526($responseFile; $blob)
		
		$customerXMLRef:=DOM Parse XML variable:C720($responseXML)
		$errTagRef:=DOM Find XML element:C864($customerXMLRef; "S:Envelope/S:Body/QUERYCUSTOMER_IOFS_RES/FCUBS_BODY/FCUBS_ERROR_RESP/ERROR")
		
		
		If (OK=1)  // There was an error getting Customer Information
			
			$errInfo:=mgXML2Object($errTagRef)
			
			$errObj:=OB Get:C1224($errInfo; "ERROR")
			$errCode:=$errObj.ECODE
			$errMsg:=$errObj.EDESC
			$success:=False:C215
			
			CAB_log("----------------------------------------------------------------------")
			CAB_log("Date: "+String:C10(Current date:C33(*))+" Time: "+String:C10(Current time:C178(*)))
			CAB_log("Error Getting Customer Information:\n Customer No: "+$custNumber)
			CAB_log("Error Code:"+$errCode+" Err Message: "+$errMsg)
			CAB_log("Request: \n"+$soapRequest)
			CAB_log("Response:\n"+BLOB to text:C555($blob; UTF8 text with length:K22:16))
			
		End if 
		
		// ----------------------------------------------------------------
		// Parse the response in XML Format
		// ----------------------------------------------------------------
		
		$tagRef:=DOM Find XML element:C864($customerXMLRef; "S:Envelope/S:Body/QUERYCUSTOMER_IOFS_RES/FCUBS_BODY/Customer-Full")
		
		If (OK=1)
			$success:=True:C214
			$customerInfo:=mgXML2Object($tagRef)
			$success:=$success & CAB_createUpdateCustomer($customerInfo)
		End if 
		
		
		If (getKeyValue("CAB.testMode"; "true")="true")
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($customerInfo))
		End if 
	Else 
		CAB_log("Error on SOAP Request \n"+$soapRequest)
		$success:=False:C215
	End if 
	
Else 
	$success:=True:C214
	CAB_log("Customer has been skipped. Already exists: "+$custNumber)
End if 







