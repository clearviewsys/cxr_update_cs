If (Form event code:C388=On Load:K2:1)
	If ([Questions:131]question:2#"")
		If ([Questions:131]answer1:3=[Questions:131]correctAnswer:7)
			Form:C1466.answer1Checkbox:=True:C214
		End if 
		If ([Questions:131]answer2:4=[Questions:131]correctAnswer:7)
			Form:C1466.answer2Checkbox:=True:C214
		End if 
		If ([Questions:131]answer3:5=[Questions:131]correctAnswer:7)
			Form:C1466.answer3Checkbox:=True:C214
		End if 
		If ([Questions:131]answer4:6=[Questions:131]correctAnswer:7)
			Form:C1466.answer4Checkbox:=True:C214
		End if 
		
	Else 
		Form:C1466.answer1Checkbox:=True:C214
	End if 
End if 

