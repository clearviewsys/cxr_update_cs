//%attributes = {}
// makeCommentsWire 

C_TEXT:C284(wireComments; $0)
//wireComments:="Amount of "+String([Wires]Amount;"|Currency")+" "+[Wires]Currency  ` Ex: Amount 1000 USD...
//
wireComments:=""

Case of 
	: ([Wires:8]isOutgoingWire:16=True:C214)  // payment is paid to customer
		wireComments:="TT Wire Payment Order"+CRLF
	: ([Wires:8]isOutgoingWire:16=False:C215)  // payment is received 
		wireComments:="TT Wire Received"+CRLF
End case 

C_TEXT:C284($beneficiaryAddress; $bankAddress)
$beneficiaryAddress:=env_makeAddressText([Wires:8]BeneficiaryAddress:26; [Wires:8]BeneficiaryCity:50; [Wires:8]BeneficiaryState:51; [Wires:8]BeneficiaryZIPCode:52; [Wires:8]BeneficiaryCountry:53)
$bankAddress:=env_makeAddressText([Wires:8]BeneficiaryBankAddress:4; [Wires:8]BeneficiaryBankCityState:5; ""; ""; [Wires:8]BeneficiaryBankCountry:6)

//appendLabelString (->wireComments;"Amount: ";String([Wires]Amount;"|Currency")+" "+[Wires]Currency;True)
appendLabelString(->wireComments; "Beneficiary Full Name: "; [Wires:8]BeneficiaryFullName:10; True:C214)
appendLabelString(->wireComments; "Beneficiary Address: "; $beneficiaryAddress; True:C214)

appendLabelString(->wireComments; "Amount: "; String:C10([Wires:8]Amount:14; "|Currency")+" "+[Wires:8]Currency:15; True:C214)

appendLabelString(->wireComments; "Bank Name: "; [Wires:8]BeneficiaryBankName:3; True:C214)
appendLabelString(->wireComments; "Bank Address: "; $bankAddress; True:C214)
appendLabelString(->wireComments; "Routing No.: "; [Wires:8]BeneficiaryRoutingCode:27; True:C214)
appendLabelString(->wireComments; "SWIFT : "; [Wires:8]BeneficiarySWIFT:28; True:C214)

appendLabelString(->wireComments; "Bank Institution No.: "; [Wires:8]BeneficiaryInstitutionNo:7; True:C214)
appendLabelString(->wireComments; "Branch Transit No.: "; [Wires:8]BeneficiaryBranchTransitNo:8; True:C214)

If (getKeyValue("Module.Wires.AccountNo")="hide")
	appendLabelString(->wireComments; "** Account No.: "; "**********"; True:C214)
Else 
	appendLabelString(->wireComments; "** Account No.: "; [Wires:8]BeneficiaryAccountNo:9; True:C214)
End if 

appendLabelString(->wireComments; "Further Credit to: "; [Wires:8]FurtherCreditTo:32; True:C214)

appendLabelString(->wireComments; "Special Remarks: "; [Wires:8]Memo:19; True:C214)

$0:=wireComments
CLEAR VARIABLE:C89(wireComments)