//%attributes = {}
// 
// ws_get(Date;webURL)

// http://localhost:8080/4DWSDL/
// 
// Method source code by Tiran B
// ----------------------------------------------------------------

C_DATE:C307($1; $date)
C_TEXT:C284($2; $webURL)
C_REAL:C285($0)

Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33
		$webURL:="http://192.168.0.200:8090"
		$webURL:=""
		
	: (Count parameters:C259=1)
		$date:=$1
		$webURL:="http://192.168.0.200:8090"
		
	: (Count parameters:C259=2)
		$date:=$1
		$webURL:=$2
End case 

WEB SERVICE SET PARAMETER:C777("date"; $1)

WEB SERVICE CALL:C778($webURL+"/4DSOAP/"; "cxr_Services#pws_getUnrealizedGainByDate"; "pws_getUnrealizedGainByDate"; "http://www.clearviewsys.com/namespace"; Web Service dynamic:K48:1)

If (OK=1)
	WEB SERVICE GET RESULT:C779($0; "profit"; *)  // Memory clean-up on the final return value.
End if 
