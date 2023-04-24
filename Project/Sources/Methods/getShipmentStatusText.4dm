//%attributes = {}
// getShipmentStatusText (num): string


C_LONGINT:C283($1)
C_TEXT:C284($0)

Case of 
	: ($1=0)
		$0:="Preparing"
		
	: ($1=1)
		$0:="Shipped"
		
	: ($1=2)
		$0:="Received"
		
	: ($1=3)
		$0:="Rejected"
		
	: ($1=4)
		$0:="Returned"
		
	Else 
		$0:="Lost"
End case 