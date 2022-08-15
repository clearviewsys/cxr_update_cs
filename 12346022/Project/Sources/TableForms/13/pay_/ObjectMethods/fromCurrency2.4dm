If (Self:C308->)
	OBJECT SET ENTERABLE:C238([eWires:13]phoneNumber:39; True:C214)
	GOTO OBJECT:C206([eWires:13]phoneNumber:39)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]phoneNumber:39; False:C215)
	[eWires:13]phoneNumber:39:=""
End if 


If (([eWires:13]doNotifyBySMS:31) & ([eWires:13]phoneNumber:39=""))
	[eWires:13]phoneNumber:39:=getLinkPrimaryPhone
End if 