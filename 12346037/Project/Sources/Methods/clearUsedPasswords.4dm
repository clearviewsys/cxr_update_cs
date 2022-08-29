//%attributes = {}
READ WRITE:C146([UserPasswords:145])
ALL RECORDS:C47([UserPasswords:145])
FIRST RECORD:C50([UserPasswords:145])

Repeat 
	DELETE RECORD:C58([UserPasswords:145])
	NEXT RECORD:C51([UserPasswords:145])
Until ((End selection:C36([UserPasswords:145])))
UNLOAD RECORD:C212([UserPasswords:145])