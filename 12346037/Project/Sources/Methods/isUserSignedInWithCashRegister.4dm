//%attributes = {}
// isUserSignedInWithCashRegisters ->boolean
// returns true if the current application user

C_LONGINT:C283($signedInMachines)
C_BOOLEAN:C305($0)
SET QUERY DESTINATION:C396(Into variable:K19:4; $signedInMachines)
QUERY:C277([CashRegisters:33]; [CashRegisters:33]UserID:2=getApplicationUser; *)
QUERY:C277([CashRegisters:33];  | ; [CashRegisters:33]isShared:8=True:C214)

If ($signedInMachines>0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)