//%attributes = {}
// myRequest (message; defaultAnswer): text
// this method asks a questions and returns the result in text
// the defaultAnswer is returned if the customer presses Cancel

C_TEXT:C284($0; $1; $2; $question; $defaultAnswer; $result)

Case of 
	: (Count parameters:C259=0)
		$question:="This is the question"
		$defaultAnswer:="default"
		
	: (Count parameters:C259=1)
		$question:=$1
		
	: (Count parameters:C259=2)
		$question:=$1
		$defaultAnswer:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$result:=Request:C163($question; $defaultAnswer; "Save"; "Use default")
If (OK=1)
	$0:=$result
Else 
	$0:=$defaultAnswer
End if 
