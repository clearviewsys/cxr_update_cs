//%attributes = {}
//stringStartsWith( string; startstring) : boolean
// if a string begins with a particular prefix ? 

C_TEXT:C284($1; $2; $string; $search)
C_BOOLEAN:C305($0)

$string:=$1
$search:=$2



If (Substring:C12($string; 1; Length:C16($search))=$search)
	$0:=True:C214
Else 
	$0:=False:C215
End if 