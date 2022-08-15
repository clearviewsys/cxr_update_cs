listbox_appendRow(->feeRulesListBox)
C_LONGINT:C283($i)
$i:=LISTBOX Get number of rows:C915(feeRulesListBox)
arrRuleNo{$i}:=$i
arrRuleName{$i}:="Rule "+String:C10($i)
arrLowerLimit{$i}:=-1
arrUpperLimit{$i}:=-1

EDIT ITEM:C870(arrRuleName; $i)
