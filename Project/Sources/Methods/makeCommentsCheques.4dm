//%attributes = {}

Case of 
	: (getDefaultLanguage=1)
		$0:=makeCommentsCheques_FR
		
	Else 
		$0:=makeCommentsCheques_EN
End case 

