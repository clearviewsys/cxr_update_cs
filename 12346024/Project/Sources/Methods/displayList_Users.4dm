//%attributes = {"shared":true}
C_POINTER:C301($1)  // Jan 17, 2012 12:11:03 -- I.Barclay Berry 
If (isUserSuperAdmin)
	displayLBox_(->[Users:25])
Else 
	myalert_SuperAminNeeded
End if 