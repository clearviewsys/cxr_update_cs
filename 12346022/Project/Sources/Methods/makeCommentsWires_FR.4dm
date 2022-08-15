//%attributes = {}

// makeCommentsWire

C_TEXT:C284(wireComments; $0; $beneficiaryAddress; $bankAddress)
wireComments:="Montant de"+String:C10([Wires:8]Amount:14; "|Currency")+" "+[Wires:8]Currency:15  // Ex: Amount 1000 USD...
//

Case of 
	: ([Wires:8]isOutgoingWire:16=True:C214)  // payment is paid to customer
		wireComments:=wireComments+" envoyé par transfert électronique "+[Wires:8]CXR_AccountID:11+" et transféré au "
		
	: ([Wires:8]isOutgoingWire:16=False:C215)  // payment is received 
		wireComments:=wireComments+" reçu par transfert électronique "
End case 

$beneficiaryAddress:=env_makeAddressText([Wires:8]BeneficiaryAddress:26; [Wires:8]BeneficiaryCity:50; [Wires:8]BeneficiaryState:51; [Wires:8]BeneficiaryZIPCode:52; [Wires:8]BeneficiaryCountry:53)
$bankAddress:=env_makeAddressText([Wires:8]BeneficiaryBankAddress:4; [Wires:8]BeneficiaryBankCityState:5; ""; ""; [Wires:8]BeneficiaryBankCountry:6)

appendLabelString(->wireComments; "Nom du destinataire "; [Wires:8]BeneficiaryFullName:10; True:C214)

appendLabelString(->wireComments; "Nom de la banque: "; [Wires:8]BeneficiaryBankName:3; True:C214)
appendLabelString(->wireComments; "Numéro d'institution: "; [Wires:8]BeneficiaryInstitutionNo:7; True:C214)
appendLabelString(->wireComments; "Numéro du Transit: "; [Wires:8]BeneficiaryBranchTransitNo:8; True:C214)
appendLabelString(->wireComments; "Numéro du compte: "; [Wires:8]BeneficiaryAccountNo:9; True:C214)
appendLabelString(->wireComments; "Code de route banquaire: "; [Wires:8]BeneficiaryRoutingCode:27; True:C214)
appendLabelString(->wireComments; "Numéro SWIFT : "; [Wires:8]BeneficiarySWIFT:28; True:C214)
appendLabelString(->wireComments; "Addresse du destinataire: "; $beneficiaryAddress; True:C214)
appendLabelString(->wireComments; "Destination finale: "; [Wires:8]FurtherCreditTo:32; True:C214)

appendLabelString(->wireComments; "Addresse de la banque: "; $bankAddress; True:C214)
//appendLabelString (->wireComments;"No de. Facsimile: ";[Wires]BeneficiaryBranchFax;True)
appendLabelString(->wireComments; "Objet de la transaction: "; [Wires:8]AML_PurposeOfTransaction:49; True:C214)
appendLabelString(->wireComments; "Origine des fonds: "; [Wires:8]AML_SourceOfFunds:66; True:C214)

appendLabelString(->wireComments; "Commentaires: "; [Wires:8]Memo:19; True:C214)

$0:=wireComments
CLEAR VARIABLE:C89(wireComments)