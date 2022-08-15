C_TEXT:C284(vLookFor)

SET QUERY DESTINATION:C396(Into set:K19:2; "$match")
QUERY SELECTION:C341([Registers:10]; [Registers:10]isValidated:35=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8=Num:C11(vLookFor); *)
QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]Credit:7=Num:C11(vLookFor); *)
QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]Comments:9="@"+vLookFor+"@")
If (Records in set:C195("$match")>0)
	HIGHLIGHT RECORDS:C656([Registers:10]; "$match")
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
USE SET:C118("$match")
CLEAR SET:C117("$match")
GOTO OBJECT:C206(Self:C308->)