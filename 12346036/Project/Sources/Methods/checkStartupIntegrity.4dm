//%attributes = {}
READ ONLY:C145([Registers:10])
ALL RECORDS:C47([Registers:10])

C_REAL:C285($debitTotal; $creditTotal)


If (Application type:C494#4D Server:K5:6)
	$debitTotal:=Sum:C1([Registers:10]DebitLocal:23)
	$creditTotal:=Sum:C1([Registers:10]CreditLocal:24)
	
	If (Abs:C99($debitTotal-$creditTotal)>=1)
		C_TEXT:C284($msg)
		$msg:="The journal is not balanced."
		myAlert($msg)
		displayHelpRequestForm("Journal is not balanced. Difference is "+String:C10($debitTotal-$creditTotal))
	End if 
	
End if 
