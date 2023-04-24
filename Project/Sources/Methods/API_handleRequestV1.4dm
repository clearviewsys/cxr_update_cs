//%attributes = {}



//$1  TextURL
//$2. TextHTTP header+HTTP body(up to 32 kb limit)
//$3. TextIP address of the Web clie(browser)
//$4. TextIP address of the server
//$5. TextUser name
//$6. TextPassword

C_TEXT:C284($1; $2; $3; $4; $5; $6)

C_OBJECT:C1216($status)
C_COLLECTION:C1488($col)


Case of 
	: ($1="@/POST/@")
		API_postRequestV1($1; $2; $3; $4; $5; $6)
		
	: ($1="@/GET/@")
		API_getRequestV1($1; $2; $3; $4; $5; $6)
		
	Else 
		ARRAY TEXT:C222($aNames; 0)
		ARRAY TEXT:C222($aValues; 0)
		WEB GET HTTP HEADER:C697($aNames; $aValues)
		
		$col:=New collection:C1472
		ARRAY TO COLLECTION:C1563($col; $aNames; "header"; $aValues; "value")
		
		Case of 
			: ($col.query("name == :1"; "X-METHOD")="POST")
				API_postRequestV1($1; $2; $3; $4; $5; $6)
			: ($col.query("name == :1"; "X-METHOD")="GET")
				API_getRequestV1($1; $2; $3; $4; $5; $6)
			Else 
				API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Endpoint not found: "+$1))
		End case 
		
End case 

