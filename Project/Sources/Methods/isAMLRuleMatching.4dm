//%attributes = {}
// isAMLRuleMatching (recPaid; method; subMethod; amount; curr) : bool
// PRE: the record for AMLRules and Customers should be loaded
// This is the part where the conditionals are tested in the AML Rule - All the ifs are checked here
// getBuild

C_TEXT:C284($1; $recPaid)
C_TEXT:C284($2; $method)
C_TEXT:C284($3; $subMethod)
C_REAL:C285($4; $amount)
C_TEXT:C284($5; $curr)
C_REAL:C285($6; $amountLC)
//C_BOOLEAN($7;$isLocal)


C_BOOLEAN:C305($0; $match)

$recPaid:=$1
$method:=$2
$subMethod:=$3
$amount:=$4
$curr:=$5
$amountLC:=$6
//$isLocal:=$7

$match:=True:C214  // assume it's a match unless the opposite is proven

// TEMPLATE of a match *********************************************
//If (([customers]field#[AMLRules]field)&([AMLRules]field#""))
// $match:=false
//end if


// ****** IGNORE the rules in the following conditions
If (([Customers:3]CustomerID:1=getSelfCustomerID) & ([AMLRules:74]ignoreRuleForSelf:49))  // if customer is self and we want the rule to be ignored for ourselves then dont' pass the rule
	$match:=False:C215
End if 

If (([Customers:3]isCompany:41) & ([AMLRules:74]ignoreRuleForCompanies:50))  // if customer is self and we want the rule to be ignored for ourselves then dont' pass the rule
	$match:=False:C215
End if 

If (([Customers:3]GroupName:90=[AMLRules:74]ignoreRuleForGroup:48) & ([AMLRules:74]ignoreRuleForGroup:48#""))
	$match:=False:C215
End if 
//******  END OF IGNORE RULES

If ([AMLRules:74]ifRangeisInLC:8)  // if the range is in Local Currency do the exact same checks with the LC amount
	$amount:=$amountLC
End if 

If (($recPaid#[AMLRules:74]RecPaid:2) & ([AMLRules:74]RecPaid:2#""))
	$match:=False:C215
End if 

If (($method#[AMLRules:74]ifMethod:4) & ([AMLRules:74]ifMethod:4#""))
	$match:=False:C215
End if 

If (($subMethod#[AMLRules:74]ifSubMethod:5) & ([AMLRules:74]ifSubMethod:5#""))
	$match:=False:C215
End if 

If (([AMLRules:74]ifLowerBound:6#-1) & ($amount<[AMLRules:74]ifLowerBound:6))
	$match:=False:C215
End if 

If (([AMLRules:74]ifUpperBound:7#-1) & ($amount>=[AMLRules:74]ifUpperBound:7))
	$match:=False:C215
End if 

If (($curr#[AMLRules:74]ifCurrency:3) & ([AMLRules:74]ifCurrency:3#""))
	$match:=False:C215
End if 

// CUSTOMER MATCHING RULES

If (([Customers:3]CustomerID:1#[AMLRules:74]ifCustomerID:10) & ([AMLRules:74]ifCustomerID:10#""))  // if customerID is
	$match:=False:C215
End if 

If (([Customers:3]GroupName:90#[AMLRules:74]ifCustomerIsInGroup:11) & ([AMLRules:74]ifCustomerIsInGroup:11#""))  // if belongs to group
	$match:=False:C215
End if 

If (([Customers:3]isCompany:41#[AMLRules:74]ifCustomerIsCorporate:27) & ([AMLRules:74]ifCustomerIsCorporate:27#True:C214))  // if is corporate
	$match:=False:C215
End if 

If (([Customers:3]isWholesaler:87#[AMLRules:74]ifCustomerIsBank:29) & ([AMLRules:74]ifCustomerIsBank:29#True:C214))  // is bank or wholesaler
	$match:=False:C215
End if 

If (([Customers:3]isMSB:85#[AMLRules:74]ifCustomerIsMSB:28) & ([AMLRules:74]ifCustomerIsMSB:28#True:C214))  // is MSB
	$match:=False:C215
End if 

If (([Customers:3]AML_isSuspicious:49#[AMLRules:74]ifCustomerIsSuspicous:14) & ([AMLRules:74]ifCustomerIsSuspicous:14#True:C214))  // is suspicious
	$match:=False:C215
End if 

If (([Customers:3]AML_RiskRating:75<[AMLRules:74]ifCustomerhasRiskRating:12) & ([AMLRules:74]ifCustomerhasRiskRating:12#0))  // TB - Added to check Customer Risk Rating
	$match:=False:C215
End if 
// more matches to be done here

$0:=$match