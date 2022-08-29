C_LONGINT:C283($i; $j)
$I:=listbox_getSelectedRowNumber(->feeRulesListBox)

listbox_appendRow(->feeRulesListBox)
$j:=LISTBOX Get number of rows:C915(feeRulesListBox)

arrRuleNo{$j}:=$j

If ($j>0)
	arrRuleName{$j}:=arrRuleName{$i}
	arrRecPaid{$j}:=arrRecPaid{$i}
	arrCurrency{$j}:=arrCurrency{$i}
	arrMethod{$j}:=arrMethod{$i}
	arrSubMethod{$j}:=arrSubMethod{$i}
	arrLowerLimit{$j}:=arrLowerLimit{$i}
	arrUpperLimit{$j}:=arrUpperLimit{$i}
	arrFlatFee{$j}:=arrFlatFee{$i}
	arrPercentFee{$j}:=arrPercentFee{$i}
	arrIfRangeInLC{$j}:=arrIfRangeInLC{$i}
	arrStopEvaluating{$j}:=arrStopEvaluating{$i}
	arrCustomerID{$j}:=arrCustomerID{$i}
End if 
EDIT ITEM:C870(arrRuleName; $j)
