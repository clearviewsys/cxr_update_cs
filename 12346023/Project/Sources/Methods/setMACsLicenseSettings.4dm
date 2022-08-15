//%attributes = {}
// setMacsLicenseSetting (0-5)

// 0 : disable all

// 1 : demo

// 2 : no ewire

// 3 : no standard

// 4 : pro

// 5 : unlimited


C_LONGINT:C283($1)
setMACsLicenseVars("Null"; Current date:C33; 1; 0)
Case of 
	: ($1=1)  // demo
		
		setMACsVarsToDemoMode
		
	Else 
		setMACsLicenseVars("Unlimited"; !00-00-00!; -1; -1)
		[MACs:18]allowWebServing:21:=True:C214
		
End case 