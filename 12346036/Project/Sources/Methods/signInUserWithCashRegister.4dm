//%attributes = {}
checkInit

//If ([CashRegisters]UserID=<>ApplicationUser)  ` this user is currently signed in
//checkAddError ("You have already signed in on "+String([CashRegisters]SignInDate)+" at "+String([CashRegisters]SignInTime))
//End if 

If (([CashRegisters:33]UserID:2#"") & ([CashRegisters:33]UserID:2#getApplicationUser))  // someone else is signed in
	checkAddError([CashRegisters:33]UserID:2+" is still signed-in with this Till."; "WARN")
End if 

//checkAddWarning ("Please make sure that you have counted the bills and coins and agree to the calcu"+"lated values")

checkAddErrorIf(Not:C34(isUserAdministrator) & [CashRegisters:33]isAdminOnly:10; "This Till is reserved for administrators only.")  // if user is not admin and the till is for admin then don't let signing in

If (isValidationConfirmed)
	READ WRITE:C146([CashRegisters:33])
	LOAD RECORD:C52([CashRegisters:33])
	//◊CashRegisterID:=[CashRegisters]CashRegisterID  ` sign in
	[CashRegisters:33]UserID:2:=getApplicationUser  //<>applicationUser
	[CashRegisters:33]SignInDate:3:=Current date:C33
	[CashRegisters:33]SignInTime:4:=Current time:C178
	//[CashRegisters]SignOutDate:=!00/00/00!
	//[CashRegisters]SignOutTime:=†00:00:00†
	SAVE RECORD:C53([CashRegisters:33])
	//UNLOAD RECORD([CashRegisters])
	READ ONLY:C145([CashRegisters:33])
End if 
C_LONGINT:C283(mainListBox)
REDRAW:C174(mainListBox)
