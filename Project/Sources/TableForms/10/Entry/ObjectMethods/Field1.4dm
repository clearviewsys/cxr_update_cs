If (Form event code:C388=On Load:K2:1)
	If (Record number:C243([Registers:10])<0)  // on ly if new record created
		[Registers:10]AutoComments:12:=True:C214
	End if 
	OBJECT SET ENTERABLE:C238([Registers:10]Comments:9; Not:C34([Registers:10]AutoComments:12))
	
End if 

If (Form event code:C388#On Load:K2:1)  // on clicked or on data change
	OBJECT SET ENTERABLE:C238([Registers:10]Comments:9; Not:C34([Registers:10]AutoComments:12))
	GOTO OBJECT:C206([Registers:10]Comments:9)
End if 