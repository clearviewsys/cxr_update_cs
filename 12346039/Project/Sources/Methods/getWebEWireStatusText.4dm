//%attributes = {"shared":true,"publishedWeb":true}

C_LONGINT:C283($1)  //[WebEWires]status
C_TEXT:C284($0)
C_LONGINT:C283($status)

If (Count parameters:C259>=1)
	$status:=$1
Else 
	$status:=[WebEWires:149]status:16
End if 



Case of 
		//: ([WebEWires]isCancelled)
		//$0:="Cancelled"
	: ($status=-20)  // denied
		$0:="Denied"
	: ($status=-10)  // CANCELLED
		$0:="Cancelled"
	: ($status=0)  // draft
		$0:="Draft"
	: ($status=5)  // Pending payment
		$0:="Pending"
	: ($status=10)  // Pending Review
		$0:="Pending Review"
	: ($status=20)  // Approved
		$0:="Approved"
	: ($status=30)  // converted to eWire and invoiced
		$0:="Sent as eWire"
	: ($status=40)  // completed/fetched  
		$0:="Completed"
	Else 
		$0:="Unknown"
End case 