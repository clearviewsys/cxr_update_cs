//%attributes = {}

C_TEXT:C284($1; $invoiceNum)
C_LONGINT:C283($type; $0)

Case of 
	: (Count parameters:C259=1)
		$invoiceNum:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$type:=0

C_OBJECT:C1216($registers; $obj; $ewires; $wires; $r; $accts)


$registers:=ds:C1482.Registers.query("InvoiceNumber == :1"; $invoiceNum)
$ewires:=$registers.query("InternalTableNumber == :1"; Table:C252(->[eWires:13]))
$wires:=$registers.query("InternalTableNumber == :1"; Table:C252(->[Wires:8]))
$accts:=$registers.query("InternalTableNumber == :1"; Table:C252(->[AccountInOuts:37]))

If ($ewires.length>0)
	$type:=1
Else 
	If ($wires.length>0)
		$type:=2
	Else 
		If ($accts.length>0)
			$type:=4
		Else 
			$type:=3
		End if 
		
	End if 
	
End if 


$0:=$type
