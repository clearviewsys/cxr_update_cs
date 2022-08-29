//%attributes = {}


checkInit

If ([CashRegisters:33]UserID:2#getApplicationUser)  // someone else is signed in
	checkAddErrorOnTrue(Not:C34(isUserAdministrator); "You are not signed in with this Till.")
End if 

//checkAddWarning ("Please make sure that you have counted the bills and coins and agree to the calcu"+"lated values")

If (isValidationConfirmed)
	READ WRITE:C146([CashRegisters:33])
	LOAD RECORD:C52([CashRegisters:33])
	//◊CashRegisterID:=[CashRegisters]CashRegisterID  ` sign in
	[CashRegisters:33]UserID:2:=""
	[CashRegisters:33]SignInDate:3:=!00-00-00!
	[CashRegisters:33]SignInTime:4:=?00:00:00?
	//[CashRegisters]SignOutDate:=!00/00/00!
	//[CashRegisters]SignOutTime:=†00:00:00†
	SAVE RECORD:C53([CashRegisters:33])
	//UNLOAD RECORD([CashRegisters])
	READ ONLY:C145([CashRegisters:33])
End if 
C_LONGINT:C283(mainListBox)
REDRAW:C174(mainListBox)