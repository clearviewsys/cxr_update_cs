//%attributes = {"shared":true}
C_POINTER:C301($1)  // Jan 16, 2012 19:21:44 -- I.Barclay Berry 

C_LONGINT:C283($winRef)
If (isSLAValid)  // only works when the SLA is valid
	$winRef:=Open form window:C675([CompanyInfo:7]; "updatePanel"; Palette window:K34:3; On the left:K39:2; At the bottom:K39:6)
	DIALOG:C40([CompanyInfo:7]; "updatePanel")
Else 
	writeLog("Couldn't display Rate Update panel - SLA expired")
End if 
