//%attributes = {"shared":true}
// open4DDataFile ( {path})
// if path is empty it will ask for the data file

C_TEXT:C284($path; $1; $DocType; $Doc)
C_LONGINT:C283($Options)
If (isUserSuperAdmin)
	//C_LONGINT($platform)
	
	If (Count parameters:C259=0)
		//_O_PLATFORM PROPERTIES($platform)
		
		If (Is Windows:C1573)  // changed by @tiran for v18
			$DocType:=".4DD"
		Else 
			$DocType:="com.4d.4d.data-file"  //UTI type
		End if 
		
		$Options:=Alias selection:K24:10+Package open:K24:8+Use sheet window:K24:11
		$Doc:=Select document:C905(""; $DocType; "Select the data file"; $Options)
		
		If (OK=1)
			OPEN DATA FILE:C312(Document)
		End if 
	Else 
		$path:=$1
		OPEN DATA FILE:C312($path)
	End if 
	
Else 
	myalert_SuperAminNeeded
End if 