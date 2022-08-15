C_TEXT:C284($path)

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Getting Focus:K2:7))
	C_BLOB:C604($WebAttachment)
	C_TEXT:C284($command; $LocalPath)
	
	
	If ([LinkedDocs:4]filePath:26#"")
		
		FORM GOTO PAGE:C247(1)
		
		$LocalPath:=""
		
		If (Application type:C494=4D Remote mode:K5:5)
			
			$WebAttachment:=getWebAttachmentFromServer([LinkedDocs:4]filePath:26)
			
			If (BLOB size:C605($WebAttachment)>0)
				
				// save BLOB locally
				$LocalPath:=Temporary folder:C486+[LinkedDocs:4]fileName:28
				BLOB TO DOCUMENT:C526($LocalPath; $WebAttachment)
				
			Else 
				
				myAlert("Nothing to display")
				
			End if 
			
		Else 
			
			$LocalPath:=WAPI_uploadsFolder+[LinkedDocs:4]filePath:26
			
		End if 
		
		If ($LocalPath#"")
			
			Case of 
					
				: (Folder separator:K24:12="\\")  // windows
					
					//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE";"true")
					//LAUNCH EXTERNAL PROCESS("cmd.exe /C start \"\" \""+WA OPEN URL(webArea;$path)+"\"")
					WA OPEN URL:C1020(webArea; $LocalPath)
				: (Folder separator:K24:12=":")  // macOS
					
					$LocalPath:=Char:C90(Double quote:K15:41)+Convert path system to POSIX:C1106($LocalPath)+Char:C90(Double quote:K15:41)
					//LAUNCH EXTERNAL PROCESS("open "+$LocalPath)
					WA OPEN URL:C1020(webArea; $LocalPath)
				Else 
					
					// according to JPR from WorldTour in Stockholm headless 4D server on Linux is closer than we think
					
			End case 
			
		End if 
	Else 
		FORM GOTO PAGE:C247(2)
	End if 
End if 
