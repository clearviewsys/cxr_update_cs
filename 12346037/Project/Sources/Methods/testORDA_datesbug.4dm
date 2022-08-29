//%attributes = {}
C_DATE:C307($fromDate; $toDate)
C_OBJECT:C1216($es; $obj)
C_COLLECTION:C1488($dates)

// TRACE
$fromDate:=(OBJECT Get pointer:C1124(Object named:K67:5; "fromDate"))->
$toDate:=(OBJECT Get pointer:C1124(Object named:K67:5; "toDate"))->

If (Form:C1466.currAccount#Null:C1517)
	QUERY:C277([Registers:10]; [Registers:10]AccountID:6=Form:C1466.currAccount.AccountID)
	$es:=ds:C1482.Registers.query("AccountID = :1"; Form:C1466.currAccount.AccountID)
Else 
	ALL RECORDS:C47([Registers:10])
	$es:=ds:C1482.Registers.all()
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate)
$es:=$es.query("RegisterDate >= :1"; $fromDate)

If ($toDate#!00-00-00!)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$toDate)
	$es:=$es.query("RegisterDate <= :1"; $toDate)
End if 

Form:C1466.registers:=$es

