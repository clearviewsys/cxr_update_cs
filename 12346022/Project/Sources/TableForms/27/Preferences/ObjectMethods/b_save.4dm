checkInit
validateServerPrefs
If (isValidationConfirmed)
	[ServerPrefs:27]ftpUploadPath:41:=strTrim([ServerPrefs:27]ftpUploadPath:41)  // madamov 20200721 - trim leading and trailing spaces
	saveServerPrefs
	saveServerPrefsOnServer
Else 
	REJECT:C38
End if 