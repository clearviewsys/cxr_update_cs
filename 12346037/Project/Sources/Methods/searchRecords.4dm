//%attributes = {}
// viewRecords (-> [TABLE] {{ ;  viewForm }; searchForm} )

// defaults: modifyForm = "View"

// defaults : searchForm = "SEARCH"

// OUTPUT FORM is always set to "List"


C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283(bSearch)
C_TEXT:C284($2; $3; $viewForm; $searchForm; $listForm)
C_LONGINT:C283($totalRecords; $0)


// set the default form

$listForm:="List"
$viewForm:="View"
$searchForm:="Search"

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$viewForm:=$2
		
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$viewForm:=$2
		$searchForm:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

bSearch:=0
Repeat 
	$totalRecords:=queryRecords($tablePtr; $searchForm)
	If ((bSearch=1) | (OK=1))  // first check if ok =1 then check the number of matches =0
		
		If ($totalRecords=0)
			CONFIRM:C162("I have not found any records that matches your criteria. Search again?"; "Yes")
			bSearch:=0
		End if   // end if totalRecord=0    
		
	End if   // end if OK=1
	
Until (($totalRecords>0) | (OK=0))  // repeat until a record is found or cancel is pressed



If ((OK=1) | (bSearch=1))
	viewRecordsInSelection($tablePtr; $viewForm; $listForm)
End if   // end if OK=1


$0:=$totalRecords