If (Form event code:C388=On Data Change:K2:15)
	ARRAY TEXT:C222($arrRisk; 5)
	OBJECT SET TITLE:C194(*; "risklabel"; getRiskRatingString([Occupations:2]AML_Risk:6))
End if 