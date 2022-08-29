//%attributes = {"publishedWeb":true}
// Project Method: Account_RedrawWindow2 (window ref)

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft


C_LONGINT:C283($1; $winRef; $left; $top; $right; $bottom)

GET WINDOW RECT:C443($left; $top; $right; $bottom; $1)
$top:=$top+70
$bottom:=$bottom-36
$winRef:=Open window:C153($left; $top; $right; $bottom; 2)
CLOSE WINDOW:C154