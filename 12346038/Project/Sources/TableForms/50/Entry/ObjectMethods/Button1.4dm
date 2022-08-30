
C_TEXT:C284($beneficiary)

pickWireTemplateForCustomer(->$beneficiary; [Bookings:50]CustomerID:2)
If (OK=1)
	$beneficiary:=""
	appendLabelString(->$beneficiary; "Beneficiary Name: "; [WireTemplates:42]BeneficiaryFullName:9; True:C214)
	appendLabelString(->$beneficiary; "Bank Name: "; [WireTemplates:42]BankName:3; True:C214)
	appendLabelString(->$beneficiary; "Branch No.: "; [WireTemplates:42]BranchTransitNo:5; True:C214)
	appendLabelString(->$beneficiary; "Transit No.: "; [WireTemplates:42]BankInstitutionNo:4; True:C214)
	appendLabelString(->$beneficiary; "Account No.: "; [WireTemplates:42]AccountNo:6; True:C214)
	appendLabelString(->$beneficiary; "Routing No.: "; [Wires:8]BeneficiaryRoutingCode:27; True:C214)
	appendLabelString(->$beneficiary; "SWIFT : "; [WireTemplates:42]SWIFT:8; True:C214)
	
	//Corrected @Zoya 13 Aug 2021
	//If ([Bookings]ourRemarks="")
	
	[Bookings:50]ourRemarks:13:=$beneficiary
	
	//OBJECT SET FONT STYLE(*;ourRemarks;Bold and Italic)
	//ST SET ATTRIBUTES(*;ourRemarks;0;1;Attribute bold style;1)
	//Else 
	//[Bookings]ourRemarks:=[Bookings]ourRemarks+CRLF +$beneficiary
	//End if 
	
End if 


