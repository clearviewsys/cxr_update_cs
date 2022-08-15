
If (Form event code:C388=On Data Change:K2:15)
	READ ONLY:C145([Users:25])
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
End if 