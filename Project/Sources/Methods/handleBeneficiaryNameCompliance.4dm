//%attributes = {}
// handleBeneficaryNameCompliance
C_TEXT:C284($sanctionCheckResult; $name; $tip)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced)

If (False:C215)
	C_PICTURE:C286(latestListCheckBeneficiary1)
End if 

Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
	: (Count parameters:C259=1)
		$isForced:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tip:=""
clearPictureField(->latestListCheckBeneficiary1)
OBJECT SET HELP TIP:C1181(*; "latestListCheckBeneficiary1"; $tip)

If (stringHasMinimumLength([Wires:8]BeneficiaryFullName:10; 4))
	
	If ($isForced)
		$sanctionCheckResult:=checkNameAgainstAllLists([Wires:8]BeneficiaryFullName:10; ->$match; False:C215; Table:C252(->[Wires:8]); [Wires:8]CXR_WireID:1; True:C214)  //  Force checking in sanction lists
	Else 
		$sanctionCheckResult:=checkNameAgainstAllLists([Wires:8]BeneficiaryFullName:10; ->$match; False:C215; Table:C252(->[Wires:8]); [Wires:8]CXR_WireID:1)  // Use the server preference for checking in sanction lists
	End if 
	// Beneficiary Sanction List Flags? where?
	showSanctionCheckAlert($match; $sanctionCheckResult)
	sl_setSanctionListCheckIcon($match; ->latestListCheckBeneficiary1)
End if 

