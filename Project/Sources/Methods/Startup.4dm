//%attributes = {"publishedWeb":true}

// Startup


initCachedKeyValue
initGlobalVars  // initalize globa vars
ie4_startup
iLB_StartUp
//iM_Startup  -- 1/29/20 causes issue with register client for iH Hola
iH_Startup  //(getRegisteredUserID )
iH_Hook_Startup
initCustomFolders  //before web startup

createDefaultPrivileges  // application privileges are set here (before createdemocompany)
createDemoCompany  // then create a demo company
createDemoLicense

loadServerPreferences
loadControlBoxPrefs

SYNC_Startup  //2/15/17

If (Sync_Is_Quit4D)  //if sync quit 4d don't run more code
Else 
	
	//CXR_initSettings   //9/17/18
	//If (Current user="designer") & (Application type=4D Remote Mode)
	//REGISTER CLIENT("designer")
	//End if 
	
	//importFlags  // before createBaseCurrency
	createBaseCurrency  // must be done after importflags
	createAllAccounts
	
	createSelfCustomer
	createWalkInCustomer
	
	checkSystemAuthorization  // copy protection checks
	If (isSLAExpiringSoon)
		notifyAlert("SLA Expiry Notice"; "Service agreement will expire on "+String:C10(<>SLA_ExpiryDate)+CRLF+".Please contact Clear View for reactivation.")
	End if 
	
	If (isSLAExpired)
		notifyAlert("SLA Expired"; "Your SLA has expired! Please contact Clear View Systems to reactivate your services (rates, sanctions, upgrades)")
	End if 
	
	activateSystemLogs  //activate the systemLog 
	
	switchSystemUser
	
	RAL2_Registration
	
	//Removing since the check is done above in RAL2_Registration
	//If (isLicenseExpired )
	//myAlert ("Your Rental License has expired! Please contact a support agent from Clear View Systems")
	//If (isUserSupport )  // 
	//  // display company info page
	//Else 
	//forceQuit   // quit for normal users
	//End if 
	//End if 
	
	If (getCurrentVersion><>HighestVersionAllowed)
		notifyAlert("Incorrect Version!"; "Please downgrade to version "+<>HighestVersionAllowed+" or less.")
		If (isUserSupport)
			// display the company info page
		Else 
			// forceQuit
			If (Current user:C182#"Designer")
				myAlert("Current User: "+Current user:C182)
				forceQuit
			End if 
		End if 
	End if 
	
	initKeyValues
	
	launchBrowser  //
	
	//If (Current user="administrator")
	//  // there is not need for anyone but the administrator to reset the support team pass
	//  //changeSupportTeamPassword 
	//End if 
	
	//displaySplashScreen 
	If (Application type:C494#4D Server:K5:6)
		selectClientPrefsRecord
		If ([ClientPrefs:26]displayCurrencyPanelAtStartup:8)
			displayListCurrencies
		End if 
		If ([ClientPrefs:26]displayRatesPanelAtStartup:9)
			displayRatesPanel
		End if 
		If ([ClientPrefs:26]displayInvoicesAtStartup:10)
			displayListInvoices
		End if 
	End if 
	
	If (<>isRefreshRatesOnByDefault)
		displayUpdatePanel  // this must be after (createDemoCompany) because of assignCompanyVars
	End if 
	
	warnForBackup
	// getBuild
	
	//registerClient 
	
	//getBroadcastedMessage 
	//getClientDispatchMessage 
	
	
	setWebTimeOut
	
	setErrorTrap("Startup"; "Web Timout- Cannot connect to CVS Cloud Services! Your rates and sanction list checks may not work properly. This could be a temporary problem due to internet connectivity. You may want to increase the timout time in the Server Preferences if your int"+"er"+"net is slow.")
	myAlert(getBroadcastedMessage; "Clear View Systems - Advisory Broadcast")
	myAlert(getClientBroadcastMessage; "Company Message")
	endErrorTrap
	
	// removed the verification for client preferences
	<>branchID:=getThisComputerBranchID
	READ ONLY:C145([Branches:70])  //modified by TB on Feb 4, 2014 (version 4.022)
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=<>branchID)
	If (Records in selection:C76([Branches:70])>0)
		<>branchName:=[Branches:70]BranchName:2
		<>branchAddress:=[Branches:70]Address:3
	Else 
		//notifyAlert("Missing Info"; "This session/workstation is not linked to a Branch!"; 5)
		<>branchName:=""
		<>branchAddress:=""
	End if 
	
	
	If (getClientIntegrityChkAtStartup)
		checkStartupIntegrity
	End if 
	//displaySplashScreen   ` everything went all right
	
	
	
	menuItemCustomizationUpdate  // for customize menu items
	
End if 


// Read information about if we need to use the automatic shutdown provided by the UPS
quit4DGetUPSConfigInfo


// Import records to tables if is neccessary, Only in Development environment

If (isDevelopmentEnv)
	OnStartupImports
End if 

//populateSanctionLists 
loadCommonLists

GAML_DefinePTRConstants

If (Version type:C495 ?? 64 bit version:K5:25)  //don't try in 64bit mode
Else 
	convertPictures  //controlled by keyValue
End if 



OBJ_initPrototypes
confirmationStartup

If (Application type:C494=4D Remote mode:K5:5)
	WAPI_uploadsFolder(Get 4D folder:C485(Database folder:K5:14)+"WebDocuments")
Else 
	webStartup
End if 

EncryptUserPasswords

checkFor4DInfo

API_startup
initStorageObject