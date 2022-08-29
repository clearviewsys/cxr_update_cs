//%attributes = {"executedOnServer":true}
// returns MG Log content as JSON

C_TEXT:C284($0)

If (Storage:C1525.mgLOG=Null:C1517)
Else 
	$0:=JSON Stringify:C1217(Storage:C1525.mgLOG; *)
End if 
