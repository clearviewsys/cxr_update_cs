//%attributes = {}
C_LONGINT:C283($1; $i)
$i:=$1

If (False:C215)
	ARRAY BOOLEAN:C223(feeRulesListBox; 0)
	ARRAY TEXT:C222(arrCustomerID; 0)
	ARRAY INTEGER:C220(arrRuleNo; 0)
	ARRAY TEXT:C222(arrRuleName; 0)
	ARRAY TEXT:C222(arrRecPaid; 0)
	ARRAY TEXT:C222(arrCurrency; 0)
	ARRAY TEXT:C222(arrMethod; 0)
	ARRAY TEXT:C222(arrSubMethod; 0)
	ARRAY REAL:C219(arrLowerLimit; 0)
	ARRAY REAL:C219(arrUpperLimit; 0)
	ARRAY REAL:C219(arrFlatFee; 0)
	ARRAY REAL:C219(arrPercentFee; 0)
	ARRAY BOOLEAN:C223(arrStopEvaluating; 0)
	ARRAY BOOLEAN:C223(arrNeedPassword; 0)
	ARRAY TEXT:C222(arrCURRAlias; 0)
	
End if 

[FeeRules:59]RuleNo:1:=$i

[FeeRules:59]Currency:3:=arrCurrency{$i}
[FeeRules:59]FlatFee:8:=arrFlatFee{$i}
[FeeRules:59]LowerLimit:6:=arrLowerLimit{$i}
[FeeRules:59]UpperLimit:7:=arrUpperLimit{$i}
[FeeRules:59]Method:4:=arrMethod{$i}
[FeeRules:59]PercentFee:9:=arrPercentFee{$i}
[FeeRules:59]RecPaid:2:=arrRecPaid{$i}
[FeeRules:59]RuleName:11:=arrRuleName{$i}
[FeeRules:59]RuleNo:1:=arrRuleNo{$i}
[FeeRules:59]stopEvaluating:10:=arrStopEvaluating{$i}
[FeeRules:59]SubMethod:5:=arrSubMethod{$i}
[FeeRules:59]CustomerGroup:12:=arrCustomerID{$i}
[FeeRules:59]ifRangeInLC:13:=arrIfRangeInLC{$i}
[FeeRules:59]currencyAlias:17:=arrCURRAlias{$i}