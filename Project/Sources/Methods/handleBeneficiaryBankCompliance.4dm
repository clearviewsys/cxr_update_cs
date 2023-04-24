//%attributes = {}
// handleBeneficiaryBankCompliance
C_TEXT:C284($sanctionCheckResult; $name; $tip)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced)

Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
	: (Count parameters:C259=1)
		$isForced:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tip:=""
clearPictureField(->latestListCheckBeneficiary2)
OBJECT SET HELP TIP:C1181(*; "latestListCheckBeneficiary2"; $tip)

If (stringHasMinimumLength([Wires:8]BeneficiaryBankName:3; 4))
	
	If ($isForced)
		$sanctionCheckResult:=checkNameAgainstAllLists([Wires:8]BeneficiaryBankName:3; ->$match; False:C215; Table:C252(->[Wires:8]); [Wires:8]CXR_WireID:1; True:C214)  //  Force checking in sanction lists
	Else 
		$sanctionCheckResult:=checkNameAgainstAllLists([Wires:8]BeneficiaryBankName:3; ->$match; False:C215; Table:C252(->[Wires:8]); [Wires:8]CXR_WireID:1)  // Use the server preference for checking in sanction lists
	End if 
	// Beneficiary Bank Sanction List Flags? where?
	
	showSanctionCheckAlert($match; $sanctionCheckResult)
	sl_setSanctionListCheckIcon($match; ->latestListCheckBeneficiary2)
	
End if 

