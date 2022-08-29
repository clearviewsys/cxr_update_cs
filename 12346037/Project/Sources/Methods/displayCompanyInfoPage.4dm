//%attributes = {"shared":true}
C_LONGINT:C283($iProcess)
C_TEXT:C284($sProcessName; $sSessionUser; $sUser)

READ WRITE:C146([CompanyInfo:7])

ALL RECORDS:C47([CompanyInfo:7])
FORM SET INPUT:C55([CompanyInfo:7]; "CompanyInfo")
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675([CompanyInfo:7]; "CompanyInfo"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)

If (Records in selection:C76([CompanyInfo:7])=0)
	ADD RECORD:C56([CompanyInfo:7]; *)
Else 
	FIRST RECORD:C50([CompanyInfo:7])
	If (Locked:C147([CompanyInfo:7]))
		LOCKED BY:C353([CompanyInfo:7]; $iProcess; $sUser; $sSessionUser; $sProcessName)
		myAlert(Table name:C256(->[CompanyInfo:7])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName)
	Else 
		MODIFY RECORD:C57([CompanyInfo:7]; *)
	End if 
End if 

//If (OK=1)
//assignCompanyInfoVars 
//End if 

UNLOAD RECORD:C212([CompanyInfo:7])  //2/2/16 IBB -- was locking the record here
READ ONLY:C145([CompanyInfo:7])
LOAD RECORD:C52([CompanyInfo:7])

CLOSE WINDOW:C154

