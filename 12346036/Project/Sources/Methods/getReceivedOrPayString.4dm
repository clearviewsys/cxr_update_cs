//%attributes = {}
// getReceivedOrPayString ({0;1;2})
C_LONGINT:C283($1)
C_TEXT:C284($0)

Case of 
	: ($1=0)
		$0:=""
		
	: ($1=1)
		$0:=c_Received
		
	: ($1=2)
		$0:=c_Paid
		
	Else 
		$0:=""
End case 