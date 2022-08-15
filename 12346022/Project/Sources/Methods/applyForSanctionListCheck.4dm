//%attributes = {}
// applyForSanctionListCheck
// Verify if Customer Apply for a Sanction List Check
// Unit test by @Zoya
C_BOOLEAN:C305($0; $searchInSL)

$searchInSL:=True:C214

If (([Customers:3]AML_isWhitelisted:131) & ([Customers:3]AML_WhitelistExpiryDate:130>=Current date:C33(*)))
	$searchInSL:=False:C215
End if 


$0:=$searchInSL



