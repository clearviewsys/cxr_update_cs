//%attributes = {}
// checkIfCorrectDatafile
// Opens the correct datafile after update the structure
// Must Be configured to run on SERVER

C_TEXT:C284($dataFile; $auEnabled)

If (Windows Ctrl down:C562)
	TRACE:C157
End if 

If (Application type:C494#4D Remote mode:K5:5)
	
	
	$auEnabled:=CXR_getSetting("automatic_updates_allowed")
	
	If (Num:C11($auEnabled)=1)
		
		$dataFile:=CXR_getSetting("automatic_updates_dataFile")
		If (($dataFile#"") & ($dataFile#getDataFilePath))
			
			If (Test path name:C476($dataFile)=Is a document:K24:1)
				OPEN DATA FILE:C312($dataFile)
				DELAY PROCESS:C323(Current process:C322; 60*15)  // 60 ticks =1 sec. total: 15 secs
				//QUIT 4D
			Else 
				// OPEN DATA FILE("")  // Last datafile doesn't exist ask for the datafile
			End if 
		Else 
			// Do nothing. Ignore
		End if 
		
	Else 
		UTIL_Log("AutomaticUpdates"; "Updates are not enabled, please enable it on CXR Config File")
	End if 
	
Else 
	// This is a 4D Client APP
End if 
