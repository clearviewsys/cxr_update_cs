Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(user4d; password4D; serverIp; password4D)
		
		vfromDate:=Add to date:C393(Current date:C33(*); -1; 0; 0)
		user4d:="Designer"
		serverIp:="10.1.0.4:19819"
		
		password4D:="matifer2k4DCXR1324!#@$"
		OBJECT SET FONT:C164(password4D; "%password")
		
		getDeveloperList
End case 



