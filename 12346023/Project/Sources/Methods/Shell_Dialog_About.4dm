//%attributes = {"publishedWeb":true}
// Project Method: Shell_Dialog_About ({number})
// $1      LONGINT      To detect if the method was called from the menu bar

// Searching for answers? Be sure to check out the "About..." command located
// in the Apple menu (Macintosh), or the Help menu (Windows). There you can 
// find online help for this example database, as well as a listing of numerous
// 4D resources available to you.

// Method created by: Raymond Manley, 4D, Inc.

// Displays the About Box dialog.

C_LONGINT:C283($1; $nParameter; $nProcessID; $nStackSize; $nWinRef)
C_TEXT:C284($sMethodName)
C_TEXT:C284($tProcessName)

If (Count parameters:C259>0)  // The presence of a parameter shows this code is running in a new process.
	
	SET MENU BAR:C67(1)  // Install the menu bar for the current process.
	
	$nWinRef:=Open form window:C675([CompanyInfo:7]; "AboutDialog"; Plain fixed size window:K34:6; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE:C213("About "+<>Shell_DatabaseName)
	DIALOG:C40([CompanyInfo:7]; "AboutDialog")
	CLOSE WINDOW:C154
	
Else   // The lack of any parameters shows this method was called from the menu bar.
	// Start a new process to run the About Box in. 
	// Include a parameter, so the code can tell when it is running in a new process.
	$sMethodName:=Current method name:C684
	// stack size since v11 should be set to 0 and let 4D decide @milan
	// $nStackSize:=256*1024
	$nStackSize:=0*1024
	$tProcessName:="About "+<>Shell_DatabaseName
	$nParameter:=1
	$nProcessID:=New process:C317($sMethodName; $nStackSize; $tProcessName; $nParameter; *)
	If ($nProcessID#0)
		BRING TO FRONT:C326($nProcessID)
	End if 
End if 