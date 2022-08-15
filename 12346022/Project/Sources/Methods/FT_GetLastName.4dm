//%attributes = {}

// FT_GetLastName ($fullName)
// Gets the first name spliting the full name

C_TEXT:C284($0; $1; $fullName; $2; $strToFind)


Case of 
	: (Count parameters:C259=1)
		$fullName:=FJ_Trim($1)
		$strToFind:=" "
	: (Count parameters:C259=2)
		$fullName:=FJ_Trim($1)
		$strToFind:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($firstName)
$firstName:=FT_GetFirstName($fullName)
$0:=FJ_Trim(Replace string:C233($fullName; $firstName+" "; ""))






