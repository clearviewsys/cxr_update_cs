var $status : Object
var $msg : Text

// Database Method: On Startup
//Shell_Startup 

// run code common to both headless and GUI mode

ARRAY TEXT:C222($arrComponents_Txt; 0)  //6/29/16 IBB
COMPONENT LIST:C1001($arrComponents_Txt)
If (Find in array:C230($arrComponents_Txt; "iReport")>0)  // iReport does not have to be present
	EXECUTE METHOD:C1007("iRPT_init")
End if 

If (runHeadless)  // run in headless mode
	
Else 
	
	$status:=checkForDirectoryJSON
	
	If (Not:C34(isDesignerPasswordEmpty))
		
		If (checkCSAppVersionDiffs)
			
			SET WINDOW TITLE:C213("CurrencyXChanger")  // Set the splash screen window title.
			
			SET ABOUT:C316("About CurrencyXChanger"; "Shell_Dialog_About")  // Install the custom About Box.
			
			CXR_initSettings  //must come before checkIfCorrectDatafile 
			openCorrectDataFile
			
			Startup
			
			SP_start
			
			
			
			If (Application type:C494=4D Local mode:K5:1)
				// USER_Load_Groups
			End if 
			
			RegisterHMReportLicense
			
		Else 
			
			QUIT 4D:C291
			
		End if 
		
	Else 
		
		$msg:="Password for Designer user is empty. Application will quit.\n"
		
		If ($status.dirJSONFileCopied#Null:C1517)
			If ($status.dirJSONFileCopied)
				$msg:=$msg+"directory.json file copied to proper location.\n"
			End if 
		End if 
		
		myAlert($msg+"\nIf you receive this message again, please contact tech support.")
		
		QUIT 4D:C291
		
	End if 
	
End if 
