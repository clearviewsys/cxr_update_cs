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
		: ($1="@currency/quote@")
			//https://127.0.0.1/CXR/GET/v1/currency/quote?base=CAD&symbols=EUR,USD
			API_cxrGetCcyQuote
			
		Else 
			
	End case 
	
	
Else 
	API_sendError("401"; $status)
	//WEB SEND TEXT(JSON Stringify($status))
End if 