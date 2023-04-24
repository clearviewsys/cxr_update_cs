If (Form event code:C388=On Load:K2:1)
	C_REAL:C285(vSumTotals)
	READ ONLY:C145([TellerProofLines:79])
	QUERY:C277([TellerProofLines:79]; [TellerProofLines:79]TellerProofID:1=[TellerProof:78]TellerProofID:1)
	orderByTellerProofLines
	vSumTotals:=Sum:C1([TellerProofLines:79]Total:6)
	
End if 