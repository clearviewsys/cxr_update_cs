C_REAL:C285(vAmount1; vAmount2; vTotal)

If (Form event code:C388=On Printing Detail:K2:18)
	vAmount1:=[TellerProofLines:79]Count1:4*[TellerProofLines:79]Denomination:3
	vAmount2:=[TellerProofLines:79]Count2:5*[TellerProofLines:79]Denomination:3
	
End if 

If (Form event code:C388=On Printing Break:K2:19)
	vTotal:=Subtotal:C97([TellerProofLines:79]Total:6)
End if 

