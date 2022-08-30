//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan
// Date and time: 01/08/21, 04:27:22
// ----------------------------------------------------
// Method: checkCSAppVersinDiffs
// Description
// 
// Checks the application versions and builds and asks
// if the user want to continue with startup 
//
// Returns True if to continue with startup, false if not
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($versions)
C_TEXT:C284($msg)
C_BOOLEAN:C305($0)

$0:=True:C214  // continue startup by default

If (Application type:C494=4D Remote mode:K5:5)
	
	$versions:=UTIL_compareCSAppVersions
	
	If (Not:C34($versions.success))
		
		If ($versions.server.appVersion#$versions.client.appVersion)
			$msg:="Server and client application versions doesn't match!"
		Else 
			If ($versions.server.buildNum#$versions.client.buildNum)
				$msg:="Server and client build numbers doesn't match!"
			End if 
		End if 
		
		myConfirm($msg+"\n\nContinue with startup?"; "Continue"; "Quit application")
		
		If (OK=0)
			$0:=False:C215
		End if 
		
	End if 
	
End if 
