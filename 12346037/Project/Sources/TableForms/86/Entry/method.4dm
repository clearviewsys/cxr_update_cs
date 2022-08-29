C_TEXT:C284($path)

If (Form event code:C388=On Load:K2:1)
	$path:=WAPI_uploadsFolder+[WebAttachments:86]FilePath:3
	//$systemPath:=Convert path POSIX to system($path) 
	
	WA OPEN URL:C1020(webArea; $path)
	
	
	If ([WebAttachments:86]CreateDate:4=!00-00-00!)
		[WebAttachments:86]CreateDate:4:=Current date:C33(*)
		[WebAttachments:86]CreateTime:7:=Current time:C178(*)
	End if 
	
	If ([WebAttachments:86]CreateUser:6="")
		[WebAttachments:86]CreateUser:6:=getApplicationUser  //<>ApplicationUser
	End if 
End if 

HandleEntryForm
