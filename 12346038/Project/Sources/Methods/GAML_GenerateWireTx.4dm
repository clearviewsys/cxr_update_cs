//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_Generate_WiresTx
// Generate the XML Report for Wire Transactions
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 6/10/2018
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $root)
C_TEXT:C284($2; $fileName; $goAMLDate; $3; $number)

C_LONGINT:C283($i; $maxTx)
C_TEXT:C284($root; $transaction)

Case of 
	: (Count parameters:C259=3)
		$root:=$1
		$fileName:=$2
		$number:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($blob)

// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------
READ ONLY:C145([Wires:8])
QUERY:C277([Wires:8]; [Wires:8]CXR_InvoiceID:12=$number)

$maxTx:=Records in selection:C76([Wires:8])

FIRST RECORD:C50([Wires:8])

For ($i; 1; $maxTx)
	
	getRelatedRecordsWire
	
	$transaction:=GAML_CreateXMLNode($root; "transaction")
	setTxHeaderWire($transaction)
	
	Case of 
			
		: ([Wires:8]isOutgoingWire:16)
			setTxOutgoingWire($root; $transaction)
		Else 
			setTxIncomingWire($root; $transaction)
	End case 
	
	NEXT RECORD:C51([Wires:8])
	
End for   // Loop Transactions






