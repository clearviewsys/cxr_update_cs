//%attributes = {}
// disableToolbarButton (int: button)

C_LONGINT:C283($buttonID; $1)
C_TEXT:C284($buttonName)

$buttonID:=$1

Case of 
	: ($buttonID=1)  // new
		$buttonName:="newButton"
		
	: ($buttonID=2)  // change
		$buttonName:="changeButton"
		
	: ($buttonID=3)  // delete
		$buttonName:="deleteButton"
		
	: ($buttonID=4)  // find
		$buttonName:="findButton"
		
	: ($buttonID=5)  // query
		$buttonName:="queryButton"
		
	: ($buttonID=6)  // all
		$buttonName:="allButton"
		
	: ($buttonID=7)  // 
		$buttonName:="filterButton"
		
	: ($buttonID=8)  // 
		$buttonName:="reportButton"
		
	: ($buttonID=9)  // 
		$buttonName:="printButton"
		
	: ($buttonID=10)  // 
		$buttonName:="htmlButton"
	Else 
End case 

OBJECT SET ENABLED:C1123(*; $buttonName; False:C215)