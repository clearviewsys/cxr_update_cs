//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:25:48
// ----------------------------------------------------
// Method: BKP_LaunchApp
// Description
// 
//
// Parameters
// ----------------------------------------------------
ARRAY LONGINT:C221($windows; 0)
ARRAY TEXT:C222($windowTitles; 0)

// get a list of the windows and their titles
WINDOW LIST:C442($windows)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($windows))
	APPEND TO ARRAY:C911($windowTitles; Get window title:C450($windows{$i}))
End for 

// if we already have a preferences window open, simply show it
If (Find in array:C230($windowTitles; "Backup Preferences")#-1)
	SHOW WINDOW:C435($windows{Find in array:C230($windowTitles; "Backup Preferences")})
Else 
	// otherwise, open a new one
	openFormWindow(->[BackupPrefs:46]; "frm_MainWindow")
End if 