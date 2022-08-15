//%attributes = {}
Case of 
	: (Macintosh option down:C545) & (Macintosh command down:C546) & (Caps lock down:C547)
		//do nothing - backdoor
	: (User in group:C338(Current user:C182; "Designers"))
		quit
	Else 
		QUIT 4D:C291
End case 