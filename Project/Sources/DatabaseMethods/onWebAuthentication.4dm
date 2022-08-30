
C_TEXT:C284($1; $2)
C_TEXT:C284($5; $6; $3; $4)
C_TEXT:C284(WebUser; Webpass; WebServerIP; WebClientIP)
ARRAY TEXT:C222(WebUsers; 0)
C_TEXT:C284(webSearchField)

C_BOOLEAN:C305($0; $isValid)
$isValid:=True:C214

WebClientIP:=$3
WebServerIP:=$4
Webuser:=$5
Webpass:=$6

//C_TEXT(WEB_Alert)
//WEB_Alert:="Welcome to CXR online"s

COMPILER_WEB

If (SOAP Request:C783)
	//soap methods handle authentication
	$isValid:=True:C214
Else 
	// DO WE NEED TO FORCE ALL PAGE REQUESTS TO GO THRU ON WEB CONNECTION ---------
	//$isValid:=webIsSessionAlive   //this ensure we have the correct context set based on the session
	
	//$bAllow:=False
	//
	//ARRAY TEXT($anames;0)
	//ARRAY TEXT($avalues;0)
	//WEB GET VARIABLES($anames;$avalues)
	//
	//$iFound:=Find in array($anames;"pq_table")
	//If ($iFound>0)
	//If ($avalues{$iFound}=Table name(->[Currencies]))
	//$bAllow:=True
	//End if 
	//End if 
	//
	//Case of 
	//: ($bAllow)  //no session needed
	//  //WAPI_onWebConnection ($1;$2;$3;$4;$5;$6)
	//  //need to have way to let some connections in without a session.. ie. currency ticker
	//$0:=True
	//
	//: (webIsSessionAlive =False)  //test for valid session here
	//webSendLoginPage   //since no session then redirect for a login
	//$0:=False
	//
	//Else 
	//  //WAPI_onWebConnection ($1;$2;$3;$4;$5;$6)
	//$0:=True
	//
	//End case 
	
	//$header:="Access-Control-Allow-Origin: *"
	// WEB SET HTTP HEADER($header)
	
End if 


$0:=$isValid  //accept the connection
