//%attributes = {}
checkUniqueKey(->[Wires:8]; ->[Wires:8]CXR_WireID:1; "Wire ID")
checkIfValidDate(->[Wires:8]WireTransferDate:17; "Wire Date")
checkGreaterThan(->[Wires:8]Amount:14; "Amount"; 0)
checkifRecordExists(->[Flags:19]; ->[Flags:19]CurrencyCode:1; ->[Wires:8]Currency:15; "Currency")


checkIfAccountIDExists(->[Wires:8]CXR_AccountID:11)
checkifAccountisOfCurrency([Wires:8]CXR_AccountID:11; [Wires:8]Currency:15)

If ([Wires:8]isOutgoingWire:16)
	checkIfNullString(->[Wires:8]BeneficiaryBankName:3; "Bank Name")
	checkIfNullString(->[Wires:8]BeneficiaryAccountNo:9; "Account No")
	
	checkIfNullString(->[Wires:8]BeneficiaryFullName:10; "Beneficiary Fullname")
	checkIfNullString(->[Wires:8]BeneficiaryBankAddress:4; "Bank Address"; "warn")
	checkIfNullString(->[Wires:8]BeneficiaryBankCityState:5; "Bank City/State"; "warn")
	checkIfNullString(->[Wires:8]BeneficiaryBankCountryCode:77; "Beneficiary Bank Country Code")
	checkIfNullString(->[Wires:8]BeneficiaryCountryCode:78; "Beneficiary Country Code")
	If (<>COUNTRYCODE="NZ")
		checkIfNullString(->[Wires:8]fromMOP_Code:79; "Method of Payment at source")  // in NZ
	End if 
Else 
	
End if 

If ([Wires:8]AML_didMatchOnWatchList:55=True:C214)
	checkAddWarning("Beneficiary name has a positive match on watch list")
	If ([Wires:8]AML_isFalsePositive:56=True:C214)  // false positive is okay
		checkIfNullString(->[Wires:8]AML_DueDiligence:57; "Due diligence must be done for false positive matches.")
	Else 
		checkAddError("Cannot send an outgoing wire to anyone on the sanction lists.")
	End if 
End if 

checkAddErrorIf(([Wires:8]isReleased:64=True:C214) & ([Wires:8]isVerified:62=False:C215); "You cannot release a wire before it's been approved")  // wire cannot be relased unled approved first
If ([Wires:8]isReleased:64 & [Wires:8]isVerified:62)
	checkAddErrorIf(([Wires:8]ReleasedBy:65=[Wires:8]verfifiedBy:63); "Wire cannot be released unless approved by another person first.")  // wire cannot be relased unled approved first
End if 

checkAddErrorIf((Old:C35([Wires:8]isReleased:64)=True:C214); "This record cannot be modified anymore (already paid)")  // wire released cannot be unreleased

