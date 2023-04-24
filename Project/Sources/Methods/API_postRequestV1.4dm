//%attributes = {}

//$1  TextURL
//$2. TextHTTP header+HTTP body(up to 32 kb limit)
//$3. TextIP address of the Web clie(browser)
//$4. TextIP address of the server
//$5. TextUser name
//$6. TextPassword

C_TEXT:C284($1; $2; $3; $4; $5; $6)

C_OBJECT:C1216($status)


$status:=API_isRequestAuthorized

If ($status.success)
	
	Case of 
		: ($1="@pushTransaction@")
			API_cxrPushTransactions
			
		: ($1="@checkSanction@")
			API_checkSanctionList
			
		Else 
			API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Endpoint not found: "+$1))
	End case 
	
Else 
	API_sendError("401"; $status)
End if 