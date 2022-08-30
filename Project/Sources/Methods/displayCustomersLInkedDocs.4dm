//%attributes = {}


Case of 
	: (Is new record:C668([LinkedDocs:4])) | (Records in selection:C76([LinkedDocs:4])>0)
		
		If (Is new record:C668([LinkedDocs:4])=False:C215)
			LOAD RECORD:C52([LinkedDocs:4])
		End if 
		
		If ([LinkedDocs:4]filePath:26#"")
			
			C_TEXT:C284($path)
			C_BLOB:C604($WebAttachment)
			C_TEXT:C284($command; $LocalPath)
			
			$LocalPath:=""
			
			If (Application type:C494=4D Remote mode:K5:5)
				
				$WebAttachment:=getWebAttachmentFromServer([LinkedDocs:4]filePath:26)
				
				If (BLOB size:C605($WebAttachment)>0)
					
					// save BLOB locally
					$LocalPath:=Temporary folder:C486+[LinkedDocs:4]fileName:28
					BLOB TO DOCUMENT:C526($LocalPath; $WebAttachment)
					
				Else 
					
					//myAlert("Nothing to display")
					
				End if 
				
			Else 
				
				$LocalPath:=WAPI_uploadsFolder+[LinkedDocs:4]filePath:26
				
			End if 
			
			If (Test path name:C476($LocalPath)=Is a document:K24:1)  //($LocalPath#"")
				
				Case of 
					: (Folder separator:K24:12="\\")  // windows
						//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE";"true")
						//LAUNCH EXTERNAL PROCESS("cmd.exe /C start \"\" \""+WA OPEN URL(webArea;$path)+"\"")
						WA OPEN URL:C1020(webArea; $LocalPath)
						
					: (Folder separator:K24:12=":")  // macOS
						//$LocalPath:=Char(Double quote)+"file://"+Convert path system to POSIX($LocalPath)+Char(Double quote)
						$LocalPath:="file://"+Convert path system to POSIX:C1106($LocalPath)
						//LAUNCH EXTERNAL PROCESS("open "+$LocalPath)
						WA OPEN URL:C1020(webArea; $LocalPath)
						
					Else 
						// according to JPR from WorldTour in Stockholm headless 4D server on Linux is closer than we think
						
				End case 
				
			End if 
			OBJECT SET VISIBLE:C603(*; "ScannedImage"; False:C215)
			OBJECT SET VISIBLE:C603(webArea; True:C214)
			
		Else 
			OBJECT SET VISIBLE:C603(*; "ScannedImage"; True:C214)
			OBJECT SET VISIBLE:C603(webArea; False:C215)
			
		End if 
		
	: (Records in selection:C76([LinkedDocs:4])=0)
		WA OPEN URL:C1020(webArea; "about:blank")
		OBJECT SET VISIBLE:C603(*; "ScannedImage"; False:C215)
		OBJECT SET VISIBLE:C603(webArea; True:C214)
		
	Else 
		TRACE:C157
		
End case 