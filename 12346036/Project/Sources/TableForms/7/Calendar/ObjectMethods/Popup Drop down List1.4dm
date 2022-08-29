// this method may look complicated but it is not

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($pickedMonth)
		$pickedMonth:=Self:C308->
		cal_gotoMonth($pickedMonth)
End case 