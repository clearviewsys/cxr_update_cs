//%attributes = {}

C_TEXT:C284($first; $last; $1; $2)

Case of 
	: (Count parameters:C259=0)
		$first:="Tiran"
		$last:="Behrouz"
	Else 
		$first:=$1
		$last:=$2
End case 
OPEN URL:C673("http://findaperson.canada-411.ca/search/FindPerson?firstname="+$first+"&name="+$last; *)

// http://findaperson.canada-411.ca/search/FindPerson?firstname=tiran&name=behrouz

