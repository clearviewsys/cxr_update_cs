//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		getLatestCheckLogStatusIcon(Table:C252(->[Links:17]); [Links:17]LinkID:1; ->latestLinkIcon11; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
		getLatestCheckLogStatusIcon(Table:C252(->[Links:17]); [Links:17]LinkID:1; ->latestLinkIcon12; [Links:17]CompanyName:42)
		relateManySanctionChecklogRel(->[Links:17]; [Links:17]LinkID:1)
		handleRelateIDFields
End case 
