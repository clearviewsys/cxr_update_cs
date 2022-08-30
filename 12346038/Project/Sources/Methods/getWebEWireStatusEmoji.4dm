//%attributes = {}

//[WebEWires]status
C_TEXT:C284($0)
C_LONGINT:C283($status)
$status:=[WebEWires:149]status:16

Case of 
	: ([WebEWires:149]isCancelled:20)
		$0:="✖"
		
	: ($status=-10)  // denied
		$0:="⚠"
	: ($status=0)  // draft
		$0:="〰"
	: ($status=10)  // Pending Review
		$0:="🔳"
	: ($status=20)  // Approved
		$0:="✔"
	: ($status=30)  // converted to eWire 
		$0:="➡"
	Else 
		$0:="❓"
End case 