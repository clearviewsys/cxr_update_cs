//%attributes = {}

Case of 
	: (getDefaultLanguage=1)
		$0:=makeCommentsBooking_FR
		
	Else 
		$0:=makeCommentsBooking_EN
End case 

