//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 06/17/19, 13:05:07
// ----------------------------------------------------
// Method: webStartup
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i)
C_TEXT:C284($format)

WAPI_Startup  //make sure all vars are init'd
If (webIsLicensed)  //check for licensing here
	If (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6)  //dont start on remote for now
		//need to look at remotes acting as web servers later 
		WAPI_isLicensed(True:C214)
		WAPI_isCaptchaOn(False:C215)
		WAPI_isMinimized(True:C214)
		WAPI_tableFieldDelimiter("___")
		WAPI_configErrorPage(Get 4D folder:C485(HTML Root folder:K5:20)+"App"+Folder separator:K24:12+"WAPI"+Folder separator:K24:12+"error.shtml")
		WAPI_timeOut(Time:C179(getKeyValue("web.configuration.timeout"; "00:10:00")))  //)?00:07:00?)
		WAPI_configSessionMode(1)
		WEB SET OPTION:C1210(Web log recording:K73:9; 0)
		
		$format:=getKeyValue("web.configuration.format.date"; "")
		If ($format="")
		Else 
			WAPI_formatDates($format)  //("dd/mm/yyyy")
		End if 
		
		$format:=getKeyValue("web.configuration.format.currency"; "")
		If ($format="")
		Else 
			WAPI_formatCurrency($format)  //"999.999.999.999,99")
		End if 
		
		WAPI_defaultAutoDismissTime("20000")
		
		WAPI_isDebug(Choose:C955(getKeyValue("web.configuration.debug.enabled"; "false")="true"; True:C214; False:C215))
		WAPI_isLoggingOn(Choose:C955(getKeyValue("web.configuration.logging.enabled"; "true")="true"; True:C214; False:C215))
		
		WAPI_maxRequest(1024*1024*10)
		
		WEB SET OPTION:C1210(Web inactive process timeout:K73:13; Num:C11(getKeyValue("web.configuration.process.timeout"; "30")))
		WEB SET OPTION:C1210(Web inactive session timeout:K73:3; Num:C11(getKeyValue("web.configuration.session.timeout"; "60")))
		WEB SET OPTION:C1210(Web max concurrent processes:K73:7; Num:C11(getKeyValue("web.configuration.process.max"; "30")))
		WEB SET OPTION:C1210(Web max sessions:K73:2; Num:C11(getKeyValue("web.configuration.session.max"; "30")))
		
		mgCredentialsStore(mgGetCredentialsFromKeyValues)
		webWiresMapStore
		
		
		WAPI_configIgnoreRequest(".aspx")
		WAPI_configIgnoreRequest(".php")
		WAPI_configIgnoreRequest(".cgi")
		WAPI_configIgnoreRequest("wp-content")
		WAPI_configIgnoreRequest("console/")
		WAPI_configIgnoreRequest("_ignition/")
		WAPI_configIgnoreRequest("boaform")
		WAPI_configIgnoreRequest("mifs/")
		WAPI_configIgnoreRequest("ecp/")
		WAPI_configIgnoreRequest("<script")
		WAPI_configIgnoreRequest("javascript")
		WAPI_configIgnoreRequest("<iframe")
		
		
		If (True:C214)  // -------- INITIALIAZE BASIC FIELD CONSTRAINTS FOR WEB IF THE DO NOT EXIST ALREADY --------
			createFieldConstraint(->[Customers:3]FirstName:3; 1)
			createFieldConstraint(->[Customers:3]LastName:4; 1)
			createFieldConstraint(->[Customers:3]Address:7; 1)
			createFieldConstraint(->[Customers:3]City:8; 1)
			createFieldConstraint(->[Customers:3]CountryCode:113; 1)
			createFieldConstraint(->[Customers:3]CitizenshipCountryCode:22; 1)
			createFieldConstraint(->[Customers:3]CountryOfResidenceCode:114; 1)
			createFieldConstraint(->[Customers:3]CountryOfBirthCode:18; 1)
			
			createFieldConstraint(->[WebEWires:149]toAmount:10; 1)
			createFieldConstraint(->[WebEWires:149]CustomerID:21; 1)
			createFieldConstraint(->[WebEWires:149]LinkID:25; 1)
			
			createFieldConstraint(->[Links:17]LastName:3; 1; "wapi_getInputValue(->[Links]isCompany)=\"\")")
			createFieldConstraint(->[Links:17]FirstName:2; 1; "wapi_getInputValue(->[Links]isCompany)=\"\")")
			createFieldConstraint(->[Links:17]countryCode:50; 1)
			createFieldConstraint(->[Links:17]CompanyName:42; 1; "wapi_getInputValue(->[Links]isCompany)=\"on\")")
			
			createFieldConstraint(->[Bookings:50]Amount:9; 1)
		End if 
		
	End if 
End if 

//10/1/19 extrat test to see if we need to be running the web server
If (WEB Is server running:C1313)
Else 
	If (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6)
		If (Sync_Is_Status_On("Active"))  //try to start the web server again
			WEB START SERVER:C617
		End if 
	End if 
End if 

If (webIsLicensed) & (WEB Is server running:C1313)
	//the web app is running check for SSL/TLS and alert if not
	C_LONGINT:C283($minutes)
	C_TEXT:C284($tResult)
	
	$tResult:=""
	WEB GET OPTION:C1209(Web inactive session timeout:K73:3; $minutes)
	$tResult:=$tResult+"sessionTimeout: "+String:C10($minutes)+" || "
	WEB GET OPTION:C1209(Web inactive process timeout:K73:13; $minutes)
	$tResult:=$tResult+"processTimeout: "+String:C10($minutes)+" || "
	
	C_OBJECT:C1216($o)
	$o:=WEB Get server info:C1531
	If ($o.security.HTTPSEnabled)
		iH_Notify("SECURITY WARNING"; "TLS/SSL is ACTIVE || "+$tResult; 20)
	Else 
		iH_Notify("SECURITY WARNING"; "TLS/SSL is NOT ACTIVE. || "+$tResult; 20)
	End if 
End if 