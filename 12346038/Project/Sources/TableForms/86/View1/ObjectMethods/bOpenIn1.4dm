// opens document in application operating system assigned to open files of the type

C_BLOB:C604($WebAttachment)
C_TEXT:C284($command; $LocalPath)


$LocalPath:=""

If (Application type:C494=4D Remote mode:K5:5)
	
	$WebAttachment:=getWebAttachmentFromServer([WebAttachments:86]FilePath:3)
	
	If (BLOB size:C605($WebAttachment)>0)
		
		// save BLOB locally
		$LocalPath:=Temporary folder:C486+[WebAttachments:86]FileName:5
		BLOB TO DOCUMENT:C526($LocalPath; $WebAttachment)
		
	Else 
		
		myAlert("Nothing to display")
		
	End if 
	
Else 
	
	$LocalPath:=WAPI_uploadsFolder+[WebAttachments:86]FilePath:3
	
End if 

If ($LocalPath#"")
	
	Case of 
			
		: (Folder separator:K24:12="\\")  // windows
			
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
			LAUNCH EXTERNAL PROCESS:C811("cmd.exe /C start \"\" \""+$LocalPath+"\"")
			
		: (Folder separator:K24:12=":")  // macOS
			
			$LocalPath:=Char:C90(Double quote:K15:41)+Convert path system to POSIX:C1106($LocalPath)+Char:C90(Double quote:K15:41)
			LAUNCH EXTERNAL PROCESS:C811("open "+$LocalPath)
			
		Else 
			
			// according to JPR from WorldTour in Stockholm headless 4D server on Linux is closer than we think
			
	End case 
	
End if 
