// bindPopUpToIntegerField (->popup;->intField)

C_LONGINT:C283(cust_vRiskRating)  // Jan 17, 2012 13:39:30 -- I.Barclay Berry 

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		cust_vRiskRating:=[Customers:3]AML_RiskRating:75
	: (Form event code:C388#On Load:K2:1)
		[Customers:3]AML_RiskRating:75:=cust_vRiskRating
End case 
