//%attributes = {}
[Wires:8]BeneficiaryGender:72:=[WireTemplates:42]BeneficiaryGender:32

[Wires:8]BeneficiaryFullName:10:=[WireTemplates:42]BeneficiaryFullName:9

[Wires:8]BeneficiaryBankName:3:=[WireTemplates:42]BankName:3
[Wires:8]BeneficiaryInstitutionNo:7:=[WireTemplates:42]BankInstitutionNo:4
[Wires:8]BeneficiaryBranchTransitNo:8:=[WireTemplates:42]BranchTransitNo:5
[Wires:8]BeneficiaryAccountNo:9:=[WireTemplates:42]AccountNo:6
[Wires:8]BeneficiaryRoutingCode:27:=[WireTemplates:42]RoutingCode:7
[Wires:8]BeneficiarySWIFT:28:=[WireTemplates:42]SWIFT:8

[Wires:8]BeneficiaryAddress:26:=[WireTemplates:42]BeneficiaryAddress:19
[Wires:8]BeneficiaryCity:50:=[WireTemplates:42]BeneficiaryCity:24
[Wires:8]BeneficiaryState:51:=[WireTemplates:42]BeneficiaryState:25
[Wires:8]BeneficiaryZIPCode:52:=[WireTemplates:42]BeneficiaryZIPCode:26
[Wires:8]BeneficiaryCountryCode:78:=[WireTemplates:42]BeneficiaryCountryCode:27

[Wires:8]BeneficiaryBankAddress:4:=[WireTemplates:42]BankAddress:10
[Wires:8]BeneficiaryBankCityState:5:=[WireTemplates:42]BankCity:11
[Wires:8]BeneficiaryBankCountry:6:=[WireTemplates:42]BankCountry:12
[Wires:8]BeneficiaryBranchPhone:30:=[WireTemplates:42]Phone:15
[Wires:8]BeneficiaryBranchFax:31:=[WireTemplates:42]Fax:16
[Wires:8]BeneficiaryBankCountryCode:77:=[WireTemplates:42]BankCountryCode:35

[Wires:8]FurtherCreditTo:32:=[WireTemplates:42]FurtherCreditTo:18

If ([Wires:8]AML_PurposeOfTransaction:49="")
	[Wires:8]AML_PurposeOfTransaction:49:=[WireTemplates:42]ReasonForTransaction:21
End if 

[Wires:8]BeneficiaryPhone:69:=[WireTemplates:42]BeneficiaryPhone:30
[Wires:8]BeneficiaryGender:72:=[WireTemplates:42]BeneficiaryGender:32
[Wires:8]BeneficiarySalutation:73:=[WireTemplates:42]BeneficiarySaludation:33
[Wires:8]AML_RelationshipWithSender:67:=[WireTemplates:42]relationship:34

If ([Wires:8]Memo:19="")
	[Wires:8]Memo:19:=[WireTemplates:42]Remarks:13
End if 
