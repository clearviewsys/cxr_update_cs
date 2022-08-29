//%attributes = {"publishedWeb":true}
// Project Method: Shell_Dialog_HelpTip

// Searching for answers? Be sure to check out the "About..." command located
// in the Apple menu (Macintosh), or the Help menu (Windows). There you can 
// find online help for this example database, as well as a listing of numerous
// 4D resources available to you.

// Method created by: Raymond Manley, 4D, Inc.

// Displays the Help Tip dialog.

C_LONGINT:C283($nWinRef)

If (Not:C34(Test path name:C476(Get 4D folder:C485+<>Shell_DatabaseName+".pref")=Is a document:K24:1))  // If there's no database prefs file in the 4D folder
	BEEP:C151
	$nWinRef:=Open form window:C675([Occupations:2]; "HelpTipDialog"; Movable dialog box:K34:7; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([Occupations:2]; "HelpTipDialog")
	CLOSE WINDOW:C154
End if 