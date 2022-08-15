//%attributes = {}

Case of 
	: (getDefaultLanguage=0)
		$0:=makeCommentsAccountInOuts_EN
		
	: (getDefaultLanguage=1)
		$0:=makeCommentsAccountInOuts_FR
		
	Else 
		$0:=makeCommentsAccountInOuts_EN
End case 

