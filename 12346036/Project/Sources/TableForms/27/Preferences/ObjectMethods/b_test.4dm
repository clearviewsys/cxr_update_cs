checkInit
checkIfNullString(->[ServerPrefs:27]ftpHostName:37; "Host Name")
checkIfNullString(->[ServerPrefs:27]ftpUserName:38; "User Name")
checkIfNullString(->[ServerPrefs:27]ftpPassword:39; "FTP Password")


If (isValidationConfirmed)
	// Modified by: Milan (12/4/2019)
	// Modified by #TB (Jan 21, 2020)
	
	// Modified by: Milan (Sep 24, 2020) - added creation of local panelratesInput.txt file if not present
	
	C_TEXT:C284($supportFilePath; documentContent)
	
	$supportFilePath:=getSupportFilesPath+c_PanelRatesInputFilename
	
	If (Test path name:C476($supportFilePath)=Is a document:K24:1)
	Else 
		TEXT TO DOCUMENT:C1237($supportFilePath; "CAD;USD;EUR;JPY;IRR;MXN;JPY"; "UTF-8")
	End if 
	
	If (ftpUpload($supportFilePath; [ServerPrefs:27]ftpUploadPath:41; [ServerPrefs:27]ftpHostName:37; [ServerPrefs:27]ftpUserName:38; [ServerPrefs:27]ftpPassword:39; [ServerPrefs:27]ftpUseSecure:114))
		myAlert("Upload successfull!")
	Else 
		myAlert("Upload failed!"+CRLF+<>CheckErrors)
	End if 
	
End if 
