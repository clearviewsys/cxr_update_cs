//%attributes = {}

Case of 
	: (getDefaultLanguage=0)
		$0:=makeCommentsCashTransactions_EN
		
	: (getDefaultLanguage=1)
		$0:=makeCommentsCashTransactions_FR
		
	Else 
		$0:=makeCommentsCashTransactions_EN
End case 

