//%attributes = {"executedOnServer":true}
// adds one line to MG Log in server Storage (Execute on Server property for method set)

C_TEXT:C284($1; $message)
C_OBJECT:C1216($obj)

$message:=$1

Use (Storage:C1525)
	If (Storage:C1525.mgLOG=Null:C1517)
		Storage:C1525.mgLOG:=New shared collection:C1527
	End if 
End use 

$obj:=New shared object:C1526
Use ($obj)
	$obj.date:=Current date:C33
	$obj.time:=Current time:C178
	$obj.message:=$message
End use 

Use (Storage:C1525.mgLOG)
	Storage:C1525.mgLOG.push($obj)
End use 
