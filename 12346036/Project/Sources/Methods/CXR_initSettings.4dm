//%attributes = {"executedOnServer":true}
// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/11/08, 09:35:58
// ----------------------------------------------------
// Method: INIT_DatabaseParams
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($tPath)
C_LONGINT:C283($iReboot; $iChange)
C_TEXT:C284($sRef; $sRootRef; $sRoot; $sValue)

$iReboot:=0
$iChange:=0

If (Application type:C494=4D Remote mode:K5:5)
Else 
	$sRoot:="cxr_settings"
	$sRootRef:=CXR_openConfigRef
	
	//$tPath:=Get 4D folder(Database Folder)+"CXR_settings.xml"
	
	//If (Test path name($tPath)=Is a document)  //read it
	
	//$sRootRef:=DOM Parse XML source($tPath)
	If ($sRootRef#"")
		XT_Get_Value($sRootRef; "IndexCompacting"; ->$sValue)
		If ($sValue#"")
			//SET DATABASE PARAMETER(_o_Index compacting;Num($sValue)) // obsolete parameter ; see 'compact data file' command ; @tiran ; #obsolete #modernize
		End if 
		
		XT_Get_Value($sRootRef; "ServerTimeout"; ->$sValue)
		If ($sValue#"")
			SET DATABASE PARAMETER:C642(4D Server timeout:K37:13; Num:C11($sValue))
		End if 
		
		XT_Get_Value($sRootRef; "RemoteModeTimeout"; ->$sValue)
		If ($sValue#"")
			SET DATABASE PARAMETER:C642(4D Remote mode timeout:K37:14; Num:C11($sValue))
		End if 
		
		XT_Get_Value($sRootRef; "ServerLogRecording"; ->$sValue)
		If ($sValue#"")
			SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; Num:C11($sValue))
		End if 
		
		//disabled in v12
		//XT_Get_Value ($sRootRef;"CacheWritingMode";->$sValue)
		//If ($sValue#"")
		//SET DATABASE PARAMETER(Cache writing mode;Num($sValue))
		//End if 
		
		XT_Get_Value($sRootRef; "WebLogRecording"; ->$sValue)
		If ($sValue#"")
			//SET DATABASE PARAMETER(_o_Web Log recording;Num($sValue))
			WEB SET OPTION:C1210(Web log recording:K73:9; Num:C11($sValue))  // changed by @tiran for v18 compatibility ; #newcommand ; 
			// see https://doc.4d.com/4Dv15/4D/15.6/WEB-SET-OPTION.301-3817718.en.html
		End if 
		
		XT_Get_Value($sRootRef; "WebServerMaxRequestSize"; ->$sValue)  // added by: Barclay Berry (3/11/15)
		If ($sValue#"")
			//SET DATABASE PARAMETER(Maximum Web requests size;Num($sValue))
			WEB SET OPTION:C1210(Web maximum requests size:K73:8; Num:C11($sValue))
		End if 
		
		//obsolete in v14 --   // Modified by: Barclay Berry (2/23/15)
		
		//XT_Get_Value ($sRootRef;"RealDisplayPrecision";->$sValue)
		//If ($sValue#"")
		//SET DATABASE PARAMETER(_O_Real display precision;Num($sValue))
		//End if 
		
		XT_Get_Value($sRootRef; "SQLEngineCaseSensitivity"; ->$sValue)
		If ($sValue#"")
			SET DATABASE PARAMETER:C642(SQL engine case sensitivity:K37:43; Num:C11($sValue))
		End if 
		
		XT_Get_Value($sRootRef; "PortID"; ->$sValue)  //web server port
		If ($sValue#"") & (Get database parameter:C643(Port ID:K37:15)#Num:C11($sValue))
			SET DATABASE PARAMETER:C642(Port ID:K37:15; Num:C11($sValue))
			//$iReboot:=$iReboot+1
		End if 
		
		XT_Get_Value($sRootRef; "HTTPSPortID"; ->$sValue)  //ssl web server port
		If ($sValue#"") & (Get database parameter:C643(HTTPS port ID:K37:38)#Num:C11($sValue))
			SET DATABASE PARAMETER:C642(HTTPS port ID:K37:38; Num:C11($sValue))
		End if 
		
		
		
		XT_Get_Value($sRootRef; "ClientServerPortID"; ->$sValue)  //main 4D client port
		If ($sValue#"") & (Get database parameter:C643(Client Server port ID:K37:35)#Num:C11($sValue))
			SET DATABASE PARAMETER:C642(Client Server port ID:K37:35; Num:C11($sValue))  // Apr 7, 2008 18:16:24 -- I.Barclay Berry 
			$iReboot:=$iReboot+2
		End if 
		
		//XT_Get_Value ($sRootRef;"SQLServerPortID";->$sValue)  //main SQL port
		//If ($sValue#"")
		//If (Get database parameter(88)#Num($sValue))
		//SET DATABASE PARAMETER(88;Num($sValue))
		//$iReboot:=$iReboot+3
		//End if 
		//End if 
		
		XT_Get_Value($sRootRef; "StartSQLServer"; ->$sValue)  // Feb 16, 2013 18:03:57 -- I.Barclay Berry 
		If ($sValue="False")
			STOP SQL SERVER:C963
		Else 
			START SQL SERVER:C962
		End if 
		
		
		If (False:C215)  //not available in v13
			//XT_Get_Value ($sRootRef;"CircularLogLimitation";->$sValue)  //12/16/15 added
			//If ($sValue="")
			//$sRef:=DOM Create XML element($sRootRef;$sRoot+"/CircularLogLimitation")
			//DOM SET XML ELEMENT VALUE($sRef;"100")
			//$iChange:=$iChange+1
			//Else 
			//If (Get database parameter(Circular log limitation)#Num($sValue))
			//SET DATABASE PARAMETER(Circular log limitation;Num($sValue))
			//End if 
			//End if 
		End if 
		
		XT_Get_Value($sRootRef; "DiagnosticLogRecording"; ->$sValue)  //12/16/15 added
		If ($sValue="")
			$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DiagnosticLogRecording")
			DOM SET XML ELEMENT VALUE:C868($sRef; "0")  //default to do NOT record
			$iChange:=$iChange+1
		Else 
			If (Get database parameter:C643(Diagnostic log recording:K37:69)#Num:C11($sValue))
				If ($sValue="0") | ($sValue="1")
					SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; Num:C11($sValue))
				End if 
			End if 
		End if 
		
		XT_Get_Value($sRootRef; "DebugLogRecording"; ->$sValue)  //12/16/15 added
		If ($sValue="")
			$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DebugLogRecording")
			DOM SET XML ELEMENT VALUE:C868($sRef; "0")  //default to do NOT record
			$iChange:=$iChange+1
		Else 
			If (Get database parameter:C643(Debug log recording:K37:34)#Num:C11($sValue))
				If ($sValue="0") | ($sValue="1") | ($sValue="2") | ($sValue="6")
					SET DATABASE PARAMETER:C642(Debug log recording:K37:34; Num:C11($sValue))
				End if 
			End if 
		End if 
		
		XT_Get_Value($sRootRef; "automatic_updates_allowed"; ->$sValue)  //9/20/18
		If ($sValue="")
			$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/automatic_updates_allowed")
			DOM SET XML ELEMENT VALUE:C868($sRef; "1")  //default to update
			$iChange:=$iChange+1
		End if 
		
		XT_Get_Value($sRootRef; "SanctionListURL"; ->$sValue)  //9/20/18
		If ($sValue="")
			$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/SanctionListURL")
			DOM SET XML ELEMENT VALUE:C868($sRef; "http://cloud.clearviewsys.net/cxblacklist/soap.asmx")
			$iChange:=$iChange+1
		End if 
		
		
		If ($iChange>0)  //12/16/15 added
			DOM EXPORT TO FILE:C862($sRootRef; Get 4D folder:C485(Database folder:K5:14)+"CXR_settings.xml")
		End if 
		
	Else   //create it
		
		
		$sRoot:="cxr_settings"
		$sRootRef:=DOM Create XML Ref:C861("cxr_settings")
		
		//4D startup parameters
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/IndexCompacting")
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/ServerTimeout")
		DOM SET XML ELEMENT VALUE:C868($sRef; "10")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/RemoteModeTimeout")
		DOM SET XML ELEMENT VALUE:C868($sRef; "10")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/ServerLogRecording")
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DebugLogRecording")
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")
		
		//$sRef:=DOM Create XML element($sRootRef;$sRoot+"/CacheWritingMode")
		//DOM SET XML ELEMENT VALUE($sRef;UUrgGetParameter ("ServerSettings";"CacheWritingMode";"1"))
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/WebLogRecording")
		DOM SET XML ELEMENT VALUE:C868($sRef; "1")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/RealDisplayPrecision")
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/SQLEngineCaseSensitivity")  //web server port id
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/ClientServerPortID")
		DOM SET XML ELEMENT VALUE:C868($sRef; "19813")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/PortID")  //web server port id
		DOM SET XML ELEMENT VALUE:C868($sRef; "8080")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/HTTPSPortID")  //web server port id
		DOM SET XML ELEMENT VALUE:C868($sRef; "443")
		
		
		
		
		//i.comp specific startup parameters
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/StoredProcedures")
		DOM SET XML ELEMENT VALUE:C868($sRef; "True")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/ScheduledEvents")
		DOM SET XML ELEMENT VALUE:C868($sRef; "True")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/WebServerEnabled")
		DOM SET XML ELEMENT VALUE:C868($sRef; "True")
		
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/WebServerSSLEnforced")  //5/4/17
		DOM SET XML ELEMENT VALUE:C868($sRef; "False")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/WebServerMaxRequestSize")
		DOM SET XML ELEMENT VALUE:C868($sRef; "4000000")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/InfoReport")  // Dec 8, 2011 07:37:54 -- I.Barclay Berry 
		DOM SET XML ELEMENT VALUE:C868($sRef; "False")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/SQLServerPortID")  // Modified by: Barclay Berry (2/27/15)
		DOM SET XML ELEMENT VALUE:C868($sRef; "19812")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/StartSQLServer")  // Dec 8, 2011 07:37:54 -- I.Barclay Berry
		DOM SET XML ELEMENT VALUE:C868($sRef; "True")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/QuickTimeSupport")  // Modified by: Barclay Berry (6/8/15)
		DOM SET XML ELEMENT VALUE:C868($sRef; "1")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/CircularLogLimitation")  //12/15/15 added
		DOM SET XML ELEMENT VALUE:C868($sRef; "100")
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DiagnosticLogRecording")  //12/15/15 added
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")  //default to do NOT record
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DebugLogRecording")  //12/15/15 added
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")  //default to do NOT record
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/DataFileOnLastUpdate")
		DOM SET XML ELEMENT VALUE:C868($sRef; getDataFilePath)  //default to do NOT record
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/automatic_updates_allowed")
		DOM SET XML ELEMENT VALUE:C868($sRef; "0")  //default to do NOT update
		
		$sRef:=DOM Create XML element:C865($sRootRef; $sRoot+"/SanctionListURL")  //1/5/19
		DOM SET XML ELEMENT VALUE:C868($sRef; "https://cloud.clearviewsys.net/cxblacklist/soap.asmx")
		
		
		//DOM EXPORT TO FILE($sRootRef;$tPath)
	End if 
	
	//DOM CLOSE XML($sRootRef)
	CXR_closeConfigRef($sRootRef)
	
	If ($iReboot>0)
		myAlert("Database parameters have been reset based on your cxr_settings.xml file. Code: "+String:C10($iReboot)+" CXR will quit now. Please restart.")
		//QUIT 4D  //must restart to take affect
		//<>Quit:=True
		//QUIT 4D
		
		//OPEN DATA FILE("")  // Sep 26, 2011 14:23:13 -- I.Barclay Berry Doesn't work on SERVER
	End if 
End if 