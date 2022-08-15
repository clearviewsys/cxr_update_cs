//%attributes = {}
// #ORDA

C_OBJECT:C1216($obj; $obj2; $status)
C_COLLECTION:C1488($diff)
C_TEXT:C284($cusID)
C_LONGINT:C283($win)
$obj:=ds:C1482.Customers.query("FirstName = 'Tira@'")[0]
$cusID:=$obj.CustomerID

$win:=Open form window:C675([Customers:3]; "new")
DIALOG:C40([Customers:3]; "new"; $obj)
If (OK=1)
	$status:=$obj.save()  // save the record
	If ($status.success)
		// good
	Else 
		BEEP:C151
		ALERT:C41("Record didn't save")
	End if 
End if 
$obj2:=ds:C1482.Customers.query("CustomerID = :1"; $cusID)[0]  // find the same record

$diff:=$obj.diff($obj2)

