//%attributes = {}
C_OBJECT:C1216($0; $status)

$status:=New object:C1471
$status.success:=True:C214
$status.statusText:=Current method name:C684

// forceSignOffAllTills

QUERY:C277([CashRegisters:33]; [CashRegisters:33]isShared:8=False:C215; *)  // is not a shared till
QUERY:C277([CashRegisters:33];  & ; [CashRegisters:33]UserID:2#"")  // people are signed in - 7/20/19 fixd typo from cashAccounts

If (Records in selection:C76([CashRegisters:33])>0)
	READ WRITE:C146([CashRegisters:33])
	APPLY TO SELECTION:C70([CashRegisters:33]; [CashRegisters:33]UserID:2:="")
	APPLY TO SELECTION:C70([CashRegisters:33]; [CashRegisters:33]SignInDate:3:=!00-00-00!)
	APPLY TO SELECTION:C70([CashRegisters:33]; [CashRegisters:33]SignOutTime:6:=?00:00:00?)
	READ ONLY:C145([CashRegisters:33])
End if 

$0:=$status
