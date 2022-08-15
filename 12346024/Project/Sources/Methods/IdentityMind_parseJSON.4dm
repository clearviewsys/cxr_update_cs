//%attributes = {}

C_TEXT:C284($1; $json)
C_OBJECT:C1216($0; $ans)
Case of 
	: (Count parameters:C259=1)
		$json:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

ON ERR CALL:C155("IdentityMind_handleJSONError")
$ans:=JSON Parse:C1218($json)
ON ERR CALL:C155("")
$0:=$ans
