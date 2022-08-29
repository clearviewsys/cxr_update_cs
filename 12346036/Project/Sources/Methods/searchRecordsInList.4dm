//%attributes = {"publishedWeb":true}
// searchRecordsInList (-> [TABLE] {{ ;  viewForm }; searchForm} )
// defaults: modifyForm = "View"
// defaults : searchForm = "SEARCH"
// OUTPUT FORM is always set to "List"

C_POINTER:C301($1)
C_LONGINT:C283(bSearch; $paramCount)
C_TEXT:C284($2; $3; $viewForm; $searchForm; $listForm)
C_LONGINT:C283($totalRecords)

$paramCount:=Count parameters:C259

// set the default form
$listForm:="List"
$viewForm:="View"
$searchForm:="Search"

Case of 
		
	: ($paramCount=2)
		$viewForm:=$2
		
	: ($paramCount=3)
		$viewForm:=$2
		$searchForm:=$3
		
End case 
bSearch:=0
Repeat 
	$totalRecords:=queryRecords($1; $searchForm)
	If ((bSearch=1) | (OK=1))  // first check if ok =1 then check the number of matches =0
		If ($totalRecords=0)
			CONFIRM:C162("I have not found any records that matches your criteria. Search again?"; "Yes")
			bSearch:=0
		End if   // end if totalRecord=0    
	End if   // end if OK=1
Until (($totalRecords>0) | (OK=0))  // repeat until a record is found or cancel is pressed


