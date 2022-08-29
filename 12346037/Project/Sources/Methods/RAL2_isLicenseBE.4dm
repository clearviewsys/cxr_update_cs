//%attributes = {}
//Method to check if the current RAL License the CXR BE License
//Returns:
//isLicenseBE(Bool)

C_BOOLEAN:C305($0)
C_TEXT:C284($license)

ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])

$license:=[CompanyInfo:7]ApplicationID:30
If (Substring:C12($license; 0; 6)="CXR.BE")
	$0:=True:C214
Else 
	$0:=False:C215
End if 

UNLOAD RECORD:C212([CompanyInfo:7])