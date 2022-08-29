//%attributes = {"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/16/15, 13:47:28
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: WSS_Execute
// Description
//      Web service that will execute code (method) in local database
//      Used to force updates at remote sites

// Parameters
// ----------------------------------------------------


//METHOD COMMENTS
//

//DECLARATIONS
C_TEXT:C284(WSS_tCode)  //method to call
C_TEXT:C284(WSS_tParameters)  // parameters are passed in as text separated by backslash "\"
C_TEXT:C284(WSS_tSecurity)  // security - not used yet

C_TEXT:C284(WSS_tResult)  // 

C_BOOLEAN:C305($bIsAuthorized)


C_TEXT:C284($tResult; $tCode; $tParameters; $tCode)
C_LONGINT:C283($iPos; $i)


//INITIALIZATION

SOAP DECLARATION:C782(WSS_tCode; Is text:K8:3; SOAP input:K46:1; "Code")
SOAP DECLARATION:C782(WSS_tParameters; Is text:K8:3; SOAP input:K46:1; "Parameters")
SOAP DECLARATION:C782(WSS_tSecurity; Is text:K8:3; SOAP input:K46:1; "Security")

SOAP DECLARATION:C782(WSS_tResult; Is text:K8:3; SOAP output:K46:2; "Result")

//MAIN CODE


$tCode:=WSS_tCode
$tParameters:=WSS_tParameters

$tResult:=""


//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES

If (WSS_tSecurity="")  //allow anythingright now
	
	
	If ($tParameters#"")  //parse out the parameter
		ARRAY TEXT:C222($atParameters; 0)
		Repeat 
			$iPos:=Position:C15("\\"; $tParameters)
			If ($iPos>0)
				APPEND TO ARRAY:C911($atParameters; Substring:C12($tParameters; 1; $iPos-1))
				$tParameters:=Substring:C12($tParameters; $iPos+1; Length:C16($tParameters))
			Else 
				APPEND TO ARRAY:C911($atParameters; $tParameters)
			End if 
			
		Until ($iPos=0)
		
	End if 
	
	Case of 
		: ($tCode="UpdateXXXX")
			
			
		: ($tCode="myAlert")
			$tParameters:=""  //init
			For ($i; 1; Size of array:C274($atParameters))
				$tParameters:=$tParameters+Char:C90(Carriage return:K15:38)+$atParameters{$i}
			End for 
			
			EXECUTE METHOD:C1007($tCode; *; $tParameters)
			
		Else 
			//not an authorized method/code
	End case 
	
	
End if 

WSS_tResult:=$tResult