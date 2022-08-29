//%attributes = {}

// FT_GetFirstName ($fullName)
// Gets the first name spliting the full name

C_TEXT:C284($0; $1; $fullName; $2; $strToFind)
C_LONGINT:C283($start; $result; $lengthfound; $last)

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

$start:=1
$last:=$start

Repeat 
	$result:=Position:C15($strToFind; $fullName; $start; $lengthfound)
	$start:=$result+$lengthfound
	If ($result>0)
		$last:=$result
	End if 
	
Until ($result=0)

$0:=FJ_Trim(Substring:C12($fullName; 1; $last-1))





