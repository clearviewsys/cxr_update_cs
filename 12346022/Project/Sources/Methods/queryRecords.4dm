//%attributes = {"publishedWeb":true}
//queryRecords(->[TABLE]{;"searchForm"}) -> num
// displays the search form and applies a query by example
// returns the number of records found

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($0; $winRef)
C_LONGINT:C283(bSearch; $winRef)
C_TEXT:C284($2; $searchForm)

// set the default form

$searchForm:="Search"

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$searchForm:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

FORM SET INPUT:C55($tablePtr->; $searchForm)
$winRef:=Open form window:C675($tablePtr->; $searchForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4; *)

// query by example opens the input form
QUERY BY EXAMPLE:C292($tablePtr->; *)
$0:=Records in selection:C76($tablePtr->)
CLOSE WINDOW:C154