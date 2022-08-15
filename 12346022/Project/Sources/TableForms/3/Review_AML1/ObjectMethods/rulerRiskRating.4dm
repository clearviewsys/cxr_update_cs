// this method is already in the form method

C_POINTER:C301($self; $isHighRiskPtr)
$self:=Self:C308

If (Form event code:C388=On Load:K2:1)
	handleRiskRatingDial($self; ->[Customers:3]AML_RiskRating:75)
	
End if 


If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	
	$isHighRiskPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "isHighRisk")
	handleRiskRatingDial($self; ->[Customers:3]AML_RiskRating:75)
	
	Case of 
		: ($self->=0)
			$isHighRiskPtr->:=0
			
		: (($self->>0) & ($self-><4))  // 1, 2, 3
			$isHighRiskPtr->:=2
			
		: (($self->=4) | ($self->=5))
			$isHighRiskPtr->:=1
	End case 
	
	handleHighRiskCheckbox($isHighRiskPtr)
	
End if 