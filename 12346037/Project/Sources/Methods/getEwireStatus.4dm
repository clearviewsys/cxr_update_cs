//%attributes = {}


C_TEXT:C284($0; $status)

C_TEXT:C284($finalStatus)

$finalStatus:="Settled"

$status:=""

Case of 
	: ([eWires:13]Status:22="Complete") | ([eWires:13]Status:22="Settled") | ([eWires:13]Status:22=$finalStatus)  //all done so don't change
		$status:=[eWires:13]Status:22  //`don't change
		
	: ([eWires:13]isCancelled:34)
		$status:="Cancelled"
		
	: ([eWires:13]isLocked:79) & ([eWires:13]isSettled:23)  //either settled or complete
		$status:=$finalStatus
		
	: ([eWires:13]isLocked:79) & ([eWires:13]isSettled:23=False:C215) & ([eWires:13]invoiceID_origin:86#"") & ([eWires:13]InvoiceNumber:29#"")
		$status:="Invoiced"
		
		//: ([eWires]InvoiceNumber#"") & ([eWires]invoiceID_origin#"")  //2nd invoice done -ie Lotus FJ does invoice but not transfers
		//$status:="Invoiced"
		
	: ([eWires:13]isLocked:79) & ([eWires:13]isSettled:23=False:C215)
		$status:="Fetched"
		
	: ([eWires:13]isSettled:23 & ([eWires:13]invoiceID_origin:86=""))  //bug need to fix
		$status:=$finalStatus+"*"
		
	: ([eWires:13]isSettled:23 & ([eWires:13]InvoiceNumber:29=""))  //bug need to fix
		$status:=$finalStatus+"*"
		
	: ([eWires:13]InvoiceNumber:29#"") & ([eWires:13]invoiceID_origin:86="")  //first invoice done
		$status:="Sent"
		
		
		
	Else 
		$status:="UNKNOWN"
End case 


$0:=$status