C_POINTER:C301($dialPtr; $self)

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	handleHighRiskCheckbox(Self:C308)
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	$self:=Self:C308
	$dialPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "rulerRiskRating")
	// cust_vRiskRating
	Case of 
		: ($self->=0)  // unchecked
			$dialPtr->:=0
			
		: ($self->=1)  // checked (high risk)
			[Customers:3]AML_RiskRating:75:=4
			$dialPtr->:=4
			
		: ($Self->=2)  // mixed state (not high risk)
			[Customers:3]AML_RiskRating:75:=3
			$dialPtr->:=3
	End case 
	
	handleRiskRatingDial($dialPtr; ->[Customers:3]AML_RiskRating:75)
End if 
