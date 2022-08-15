//%attributes = {}
// returns MoneyGram credentials to confirm staged transaction

C_OBJECT:C1216($0)
C_TEXT:C284($agentID; $password; $username; $prefix)

$prefix:="mg.staged."

$agentID:=getKeyValue($prefix+"agentID")
$username:=getKeyValue($prefix+"username")
$password:=getKeyValue($prefix+"password")

Case of 
	: ($agentID="")
	: ($username="")
	: ($password="")
	Else 
		$0:=New object:C1471("username"; $username; "agentID"; $agentID; "password"; $password)
End case 