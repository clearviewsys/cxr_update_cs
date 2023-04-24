//%attributes = {}
// cab_setCustomerRisk
// PRE: customer record must be loaded
#DECLARE()->$hr : Boolean

$hr:=cab_isCustomerHighRisk

If ($hr)
	[Customers:3]AML_HighRisk:24:=1
	[Customers:3]AML_RiskRating:75:=4  // high Risk
	[Customers:3]AML_BasisOfRiskRating:106:="Automated Rule for CAB"
Else 
	// if customer is not high risk leave the risk rating alone
End if 
