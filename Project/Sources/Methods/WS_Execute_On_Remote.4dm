//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/16/15, 13:51:16
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: WS_Execute_On_Remote
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tCode)  //method nameto call
C_TEXT:C284($2; $tParameters)  //parameters to pass to method separated by backslash "\"
C_TEXT:C284($3; $tSecurity)  //security code -- not used right now

C_TEXT:C284($4; $tServerURL)  //remote URL to update

C_TEXT:C284($0; $tResult)




If (Count parameters:C259>=1)
	$tCode:=$1
Else 
	$tCode:="myAlert"
End if 

If (Count parameters:C259>=2)
	$tParameters:=$2
Else 
	$tParameters:="Hello World\\parameter 2"
End if 

If (Count parameters:C259>=3)
	$tSecurity:=$3
Else 
	$tSecurity:=""
End if 

If (Count parameters:C259>=4)
	$tServerURL:=$4
End if 

If ($tServerURL="")
	$tServerURL:="http://localhost:8080"
End if 




WEB SERVICE SET PARAMETER:C777("Code"; $tCode)
WEB SERVICE SET PARAMETER:C777("Parameters"; $tParameters)
WEB SERVICE SET PARAMETER:C777("Security"; $tSecurity)

WEB SERVICE CALL:C778($tServerURL+"/4DSOAP/"; "cxr_Services#WSS_Execute_Locally"; "WSS_Execute_Locally"; "http://www.clearviewsys.com/namespace"; Web Service dynamic:K48:1)

If (OK=1)
	WEB SERVICE GET RESULT:C779($tResult; "Result"; *)  // Memory clean-up on the final return value.
End if 


$0:=$tResult