//%attributes = {}
C_LONGINT:C283($i; $n; vSelectedRows)
C_REAL:C285(vOffBalance; vTargetBalance; vOpeningBalance)
C_REAL:C285(vSumDebits_C; vSumCredits_C; vSumBalance_C; vSumDebits_H; vSumCredits_H; vSumBalance_H; vSumDebits; vSumCredits; vSumBalance)

$n:=Size of array:C274(arrDates)


vSumDebits_C:=0
vSumCredits_C:=0
vSumBalance_C:=0
vSumDebits_H:=0
vSumCredits_H:=0
vSumBalance_H:=0
vSumDebits:=0
vSumCredits:=0
vSumBalance:=0
For ($i; 1; $n)
	If (arrChecked{$i})
		accumulateReal(->vSumDebits_C; arrDebits{$i})
		accumulateReal(->vSumCredits_C; arrCredits{$i})
		vSumBalance_C:=vSumDebits_C-vSumCredits_C
	End if 
	If (reconcileList{$i}=True:C214)
		accumulateReal(->vSumDebits_H; arrDebits{$i})
		accumulateReal(->vSumCredits_H; arrCredits{$i})
		vSumBalance_H:=vSumDebits_H-vSumCredits_H
	End if 
	//accumulateReal (->vSumDebits;arrDebits{$i})
	//accumulateReal (->vSumCredits;arrCredits{$i})
	vSumBalance:=vSumDebits-vSumCredits
End for 

vOffBalance:=(vSumBalance_C+vOpeningBalance)-vTargetBalance
vSelectedRows:=Count in array:C907(reconcileList; True:C214)