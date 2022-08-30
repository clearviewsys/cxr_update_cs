//%attributes = {}
C_LONGINT:C283($i; $1)
$i:=$1

If (False:C215)
	initFeeRulesLBArrays
End if 

arrCurrency{$i}:=[FeeRules:59]Currency:3
arrFlatFee{$i}:=[FeeRules:59]FlatFee:8
arrLowerLimit{$i}:=[FeeRules:59]LowerLimit:6
arrUpperLimit{$i}:=[FeeRules:59]UpperLimit:7
arrMethod{$i}:=[FeeRules:59]Method:4
arrPercentFee{$i}:=[FeeRules:59]PercentFee:9
arrRecPaid{$i}:=[FeeRules:59]RecPaid:2
arrRuleName{$i}:=[FeeRules:59]RuleName:11
arrRuleNo{$i}:=[FeeRules:59]RuleNo:1
arrStopEvaluating{$i}:=[FeeRules:59]stopEvaluating:10
arrSubMethod{$i}:=[FeeRules:59]SubMethod:5
arrCustomerID{$i}:=[FeeRules:59]CustomerGroup:12
arrIfRangeInLC{$i}:=[FeeRules:59]ifRangeInLC:13
ARRCURRAlias{$i}:=[FeeRules:59]currencyAlias:17
