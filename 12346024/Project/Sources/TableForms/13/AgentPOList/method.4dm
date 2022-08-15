
C_TEXT:C284(vAgentID; vAgentAccountID)
C_REAL:C285(vSumAgentPOs; vSumToAmounts)

If (Form event code:C388=On Load:K2:1)
	vAgentID:=""
	vAgentAccountID:=""
End if 

C_BOOLEAN:C305($true)
$true:=True:C214

vSumAgentPOs:=vecSumConditional(->ewr_arrToAmount; ->ewr_arrIsSelected; ->$true; True:C214)
vSumToAmounts:=Sum:C1(ewr_arrToAmount)
