//%attributes = {}

// FT_OnBehalfOfIndicator
// Generate the correct OnBehalfOfIndicator

// Part B2: On Behalf Of Indicator:
// C-Not applicable (on behalf of self, complete Part D)
// E-On behalf of an entity (complete Part D or Part E, as appropriate, and complete Part F)
// F-On behalf of another individual (complete Part D and Part G)
// G-Employee depositing cash to employer's business account (complete Part E). 
//   To include Part E, for all dispositions within a transaction, the disposition of funds in field 
//   B8 must be "A" (deposit to an account) and account type in field C3 must be "B" (business).

// Questions: 

// How do I know if the disposition is on behalf of Self?   On Behalf Of Indicator: C-Not applicable 
//    Because the conductor is an individual and we don't have a third party created (customer is the conductor)

// How do I know if the disposition is on behalf of a Company? On Behalf Of Indicator: E-On behalf of an entity 
//    Because the conductor is a Company and third party is an Individual (The conductor)

// How do I know if the disposition is on behalf of another Person? On Behalf Of Indicator: F-On behalf of another individual
//    Because the conductor is an individual and the third party is a different Individual  (The conductor)

C_TEXT:C284($0; $OnBehalfOfIndicator)
$OnBehalfOfIndicator:="C"

Case of 
		
	: (([Invoices:5]ThirdPartyisInvolved:22) & ([Customers:3]isCompany:41) & ([ThirdParties:101]IsCompany:2=False:C215))
		$OnBehalfOfIndicator:="E"  //E-On behalf of an entity
		
	: (([Invoices:5]ThirdPartyisInvolved:22) & ([Customers:3]isCompany:41=False:C215) & ([ThirdParties:101]IsCompany:2=False:C215) & (getCustomerFullName#getThirdPartiesFullName))
		$OnBehalfOfIndicator:="F"  // F-On behalf of another individual
		
		// DOESN'T APPLY: G-Employee depositing cash to employer's business account (complete Part E). 
		
End case 

$0:=$OnBehalfOfIndicator