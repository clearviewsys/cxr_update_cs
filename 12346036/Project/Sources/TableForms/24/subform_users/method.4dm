If (([Privileges:24]TableNo:2<=0) | ([Privileges:24]TableNo:2>Get last table number:C254))
	vTableName:="Default privileges"
Else 
	vTableName:=Table name:C256([Privileges:24]TableNo:2)
End if 

colourizeLineBG