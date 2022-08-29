If (([TableLimitations:55]TableNo:1<=0) | ([TableLimitations:55]TableNo:1>Get last table number:C254))
	vTableName:="Default privileges"
Else 
	vTableName:=getElegantTableName(Table:C252([TableLimitations:55]TableNo:1))
End if 

colourizeLineBG