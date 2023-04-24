//%attributes = {}
// getOrderStatusText (num): string


C_LONGINT:C283($1)
C_TEXT:C284($0)

Case of 
	: ($1=0)
		$0:="Draft"
		
	: ($1=1)
		$0:="Ordered"
		
	: ($1=2)
		$0:="Processing"
		
	: ($1=3)
		$0:="Shipped"
		
	: ($1=4)
		$0:="Received"
		
	: ($1=5)
		$0:="Lost"
		
	Else 
		$0:="n/a"
End case 