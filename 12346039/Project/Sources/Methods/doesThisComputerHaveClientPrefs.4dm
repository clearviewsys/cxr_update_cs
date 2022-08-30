//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($num)

SET QUERY DESTINATION:C396(Into variable:K19:4; $num)
QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]ClientName:1=getCurrentMachineName)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($num>0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 

