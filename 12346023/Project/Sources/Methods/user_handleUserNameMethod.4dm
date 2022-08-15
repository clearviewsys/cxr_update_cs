//%attributes = {}
READ ONLY:C145([Users:25])

If (arrUserNames>3)
	
	QUERY:C277([Users:25]; [Users:25]UserName:3=vUserName)
	If (Records in selection:C76([Users:25])=1)
		vPicture:=[Users:25]Picture:6
		vUserName:=[Users:25]UserName:3
		OBJECT SET ENTERABLE:C238(vPassword; True:C214)
		GOTO OBJECT:C206(vPassword)
	Else 
		BEEP:C151
		OBJECT SET ENTERABLE:C238(vPassword; False:C215)
		GOTO OBJECT:C206(vUserName)
	End if 
	
Else 
	vUserName:=arrUserNames{arrUserNames}
	GET PICTURE FROM LIBRARY:C565(21771; vPicture)
	
	OBJECT SET ENTERABLE:C238(vPassword; True:C214)
	//GOTO OBJECT(vPassword)
End if 
