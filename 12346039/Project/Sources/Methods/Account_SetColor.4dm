//%attributes = {"publishedWeb":true}
// Project Method: Account_SetColor

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft

// Dispays a dialog to allow the user to change the Account's background color.


C_LONGINT:C283($winRef; $foreground; $background)

bColors:=0  // Clear whatever this was last left at.

$winRef:=Open form window:C675([Occupations:2]; "SetColor"; Modal dialog box:K34:2; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Occupations:2]; "SetColor")
CLOSE WINDOW:C154

If (OK=1)
	$foreground:=15  // Black
	$background:=bColors-1
	[Occupations:2]Category:5:=-($foreground+(256*$background))  // See the 4D docs for this.
	SAVE RECORD:C53([Occupations:2])
	
	Account_RedrawWindow(Frontmost window:C447)
End if 