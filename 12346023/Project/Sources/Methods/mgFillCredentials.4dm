//%attributes = {}
// fills credentials into Profix login form

C_OBJECT:C1216($1; $credentials)
C_TEXT:C284($js; $result)

$credentials:=$1

$js:="document.getElementById('AgentIDTextBox').value = '"+$credentials.agentID+"';"
$js:=$js+" document.getElementById('PasswordTextBox').value = '"+$credentials.password+"';"
$js:=$js+" document.getElementById('LoginTextBox').value = '"+$credentials.username+"';\r"

$result:=WA Evaluate JavaScript:C1029(*; Form:C1466.mywa; $js)
