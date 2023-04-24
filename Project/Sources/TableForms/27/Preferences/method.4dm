// see also 
// initServerPrefsArrays
// initServerPrefsVars
// loadServerPreferences
// saveServerPrefs


handleCloseBox

If (Form event code:C388=On Load:K2:1)
	If ([ServerPrefs:27]fromDate:34=nullDate)
		[ServerPrefs:27]fromDate:34:=Current date:C33
	End if 
	
	If ([ServerPrefs:27]toDate:35=nullDate)
		[ServerPrefs:27]toDate:35:=Current date:C33
	End if 
End if 