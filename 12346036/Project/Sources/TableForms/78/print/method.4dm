C_REAL:C285(vDiff; vShort)


If (Form event code:C388=On Printing Detail:K2:18)
	vDiff:=[TellerProof:78]SystemBalance:7-[TellerProof:78]ManualBalance:8
	vShort:=vDiff*[TellerProof:78]Historic Rate:12
End if 