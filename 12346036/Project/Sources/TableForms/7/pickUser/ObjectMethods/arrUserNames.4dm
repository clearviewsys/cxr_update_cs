If (Form event code:C388=On Load:K2:1)
	
	vUserName:=""
	
	ARRAY TEXT:C222(arrUserNames; 0)
	QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)
	ORDER BY:C49([Users:25]; [Users:25]UserName:3; >)
	SELECTION TO ARRAY:C260([Users:25]UserName:3; arrUserNames)
	INSERT IN ARRAY:C227(arrUserNames; 1; 4)
	arrUserNames{1}:="Designer"
	arrUserNames{2}:="Administrator"
	arrUserNames{3}:="Support"
	arrUserNames{4}:=""
	
End if 


If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	vUserName:=arrUserNames{arrUserNames}
	user_handleUserNameMethod
End if 

