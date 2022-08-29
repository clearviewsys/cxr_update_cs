//%attributes = {"publishedWeb":true}
// generateRandomString ({$stringLength})
// Generates a random string of $stringLength

C_TEXT:C284($0; $characters; $randstring)
C_LONGINT:C283($1; stringLength)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=0)
		stringLength:=8
		
	: (Count parameters:C259=1)
		stringLength:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$characters:="123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"
$randstring:=""

C_LONGINT:C283($ini; $range)
C_TEXT:C284($randstring)

For ($i; 1; stringLength)
	
	// Number between 1 and length($characters)
	//  vlResult:=(Random%21)+10  between 10 and 30
	$ini:=Length:C16($characters)-2
	$range:=(Random:C100%$ini)+1
	$randstring:=$randstring+Substring:C12($characters; $range; 1)
	
End for 

$0:=$randstring


