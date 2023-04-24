//%attributes = {}
// cab_isCustomerHighRisk
// PRE: customer record must be loaded
// returns true if the customer is high risk. The conditions are based on CAB conditions for high risk


#DECLARE()->$hr : Boolean

$hr:=False:C215

If ([Customers:3]isCompany:41)
	$hr:=$hr | ([Customers:3]isMSB:85)  // MONEY SERVICE
	$hr:=$hr | ([Customers:3]isWholesaler:87)  // Bank or Wholesaler
	$hr:=$hr | (([Customers:3]IndustryCode:122#"") & (isHighRiskIndustryCode([Customers:3]IndustryCode:122)))  // or works in a high risk industry (e.g. gambling, military)
Else 
	
	$hr:=$hr | ([Customers:3]AML_isPEP:80=1)  // if customer is PEP
	$hr:=$hr | ([Customers:3]AML_isHIO:124=1)  // or customer is HIO 
	$hr:=$hr | (([Customers:3]CountryOfBirthCode:18#"") & (isHighRiskCountryCode([Customers:3]CountryOfBirthCode:18)))  // or high risk country of birth
	$hr:=$hr | (([Customers:3]Occupation:21#"") & (isHighRiskOccupation([Customers:3]Occupation:21)))  // or has a high risk occupation
	$hr:=$hr | (([Customers:3]IndustryCode:122#"") & (isHighRiskIndustryCode([Customers:3]IndustryCode:122)))  // or works in a high risk industry (e.g. gambling, military)
	$hr:=$hr | (([Customers:3]CountryCode:113#"") & ([Customers:3]CountryCode:113#"KH"))  // or is non-resident of cambodia
	
End if 