//%attributes = {"publishedWeb":true}
// Project Method: Account_RedrawWindow (window ref)

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft


C_LONGINT:C283($1; $processNumber)

$processNumber:=New process:C317("Account_RedrawWindow2"; 0; "$Redraw process"; $1)