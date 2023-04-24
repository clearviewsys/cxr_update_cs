var $status : Object
var $msg : Text


COMPILER_WEB

$status:=checkForDirectoryJSON

If (Not:C34(isDesignerPasswordEmpty))
	
	CXR_initSettings  //must come before checkIfCorrectDatafile 
	// Automatic Update Procedures. SERVER
	openCorrectDataFile
	
	//SYNC_Startup   //needs to come before startup on server -- in Startup method now
	USER_Load_Groups
	
	UTIL_generateSSLKeys
	Startup
	
	SP_start
	
	If (<>isHMReportActive)
		//$iError:=hmRep_Register (<>hmReportLicense)  //OEM license 2015
	End if 
	
	//$iError:=hmRep_Register ("lEgAJjZ7ZAN1AAAAAJADXBXDAHIAJdAMQAOSAgGB9J")  //OEM license
	//$iError:=hmRep_Register ("0MMADJZ18AJSAAAAMhAQrBVaAGcAJuANAAAdADwAiq")
	
	
	//Ltg_Startup 
	
Else 
	
	$msg:="Password for Designer user is empty. Application will quit.\n"
	
	If ($status.dirJSONFileCopied#Null:C1517)
		If ($status.dirJSONFileCopied)
			$msg:=$msg+"directory.json file copied to proper location.\n"
		End if 
	End if 
	
	$msg:=$msg+"\nIf you receive this message again, please contact tech support."
	
	// notifyAlert($msg)
	
	// notifyAlert("Designer password notification"; $msg)
	
	// myAlert($msg)
	
	ALERT:C41($msg)
	
	QUIT 4D:C291
	
End if 
