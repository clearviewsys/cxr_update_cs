//%attributes = {}
C_TEXT:C284($1; $dateTime)
C_TEXT:C284($2; $separator)
C_TIME:C306($0)
C_LONGINT:C283($separatorPosition)

$dateTime:=$1
$0:=?00:00:00?

If (Count parameters:C259>1)
	$separator:=$2
Else 
	$separator:="+"  // defaults to Profix Web app format. It is space character for SOAP API date format
End if 

$separatorPosition:=Position:C15($separator; $dateTime)

If ($separatorPosition>0)
	
	$0:=Time:C179(Substring:C12($dateTime; $separatorPosition+1))
	
End if 

