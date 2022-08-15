//%attributes = {}
// handlePaidReceived ( Amount;isPaid;->vReceived;->vPaid)
C_REAL:C285($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3; $4)

If ((Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
	If ($2)
		$4->:=$1
		$3->:=0
	Else 
		$4->:=0
		$3->:=$1
	End if 
End if 