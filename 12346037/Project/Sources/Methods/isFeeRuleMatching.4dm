//%attributes = {}
// isFeeRuleMatching (recPaid; method; subMethod; amount; curr) : bool
// PRE: the record for FeeRules should be loaded

C_TEXT:C284($1; $recPaid)
C_TEXT:C284($2; $method)
C_TEXT:C284($3; $subMethod)
C_REAL:C285($4; $amount)
C_TEXT:C284($5; $curr)
C_REAL:C285($6; $amountLC)
C_TEXT:C284($7; $customerGroup)

C_BOOLEAN:C305($0; $match)

$recPaid:=$1
$method:=$2
$subMethod:=$3
$amount:=$4
$curr:=$5
$amountLC:=$6
$customerGroup:=$7

$match:=True:C214  // assume it's a match unless the opposite is proven


If ([FeeRules:59]ifRangeInLC:13)  // if the range is in Local Currency do the exact same checks with the LC amount
	$amount:=$amountLC
End if 

If (($recPaid#[FeeRules:59]RecPaid:2) & ([FeeRules:59]RecPaid:2#""))
	$match:=False:C215
End if 

If (($method#[FeeRules:59]Method:4) & ([FeeRules:59]Method:4#""))
	$match:=False:C215
End if 

If (($subMethod#[FeeRules:59]SubMethod:5) & ([FeeRules:59]SubMethod:5#""))
	$match:=False:C215
End if 

If (([FeeRules:59]LowerLimit:6#-1) & ($amount<[FeeRules:59]LowerLimit:6))
	$match:=False:C215
End if 

If (([FeeRules:59]UpperLimit:7#-1) & ($amount>=[FeeRules:59]UpperLimit:7))
	$match:=False:C215
End if 

If (($curr#[FeeRules:59]Currency:3) & ([FeeRules:59]Currency:3#""))
	$match:=False:C215
End if 

If (($customerGroup#[FeeRules:59]CustomerGroup:12) & ([FeeRules:59]CustomerGroup:12#""))
	$match:=False:C215
End if 

$0:=$match