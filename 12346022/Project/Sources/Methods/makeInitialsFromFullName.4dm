//%attributes = {}
// makeInitialsFromFullName
//

C_TEXT:C284($1; $fullName; $0)
C_LONGINT:C283($n)

C_TEXT:C284($initials)

Case of 
	: (Count parameters:C259=1)
		$fullName:=$1
	Else 
		$fullName:="  Tiran Behrouz"
End case 

// get rid of extra spaces
normalizeFullName(->$fullName)

Case of 
	: (Length:C16($fullName)=1)
		$initials:=$fullName+$fullName
		
	: (Length:C16($fullName)=2)
		$initials:=$fullName
		
	: (Length:C16($fullName)>2)
		$initials:=Substring:C12($fullName; 1; 1)
		$n:=Position:C15(" "; $fullName; 1)
		$initials:=$initials+Substring:C12($fullName; $n+1; 1)
End case 

$0:=$initials