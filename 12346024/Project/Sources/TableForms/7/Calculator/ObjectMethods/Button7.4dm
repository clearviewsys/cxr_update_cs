If ((vFromAmount-Int:C8(vFromAmount))>=0.5)
	vFromAmount:=Int:C8(vFromAmount)+1
Else 
	vFromAmount:=Int:C8(vFromAmount)
End if 


lockCalculatorRadioButtons(2)
calcCalculatorVars
