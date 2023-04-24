//%attributes = {}
// makeCommentsWire 

Case of 
	: (getDefaultLanguage=0)
		$0:=makeCommentsWires_EN
		
	: (getDefaultLanguage=1)
		$0:=makeCommentsWires_FR
		
	Else 
		$0:=makeCommentsWires_EN
End case 

