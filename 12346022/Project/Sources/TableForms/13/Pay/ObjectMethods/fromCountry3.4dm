If (Form event code:C388=On Clicked:K2:4)
	OBJECT SET ENTERABLE:C238([eWires:13]ThirdPartyDetails:68; True:C214)
	GOTO OBJECT:C206([eWires:13]ThirdPartyDetails:68)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]ThirdPartyDetails:68; False:C215)
End if 