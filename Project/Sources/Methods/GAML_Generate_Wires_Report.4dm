//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_Generate_Wires_Report
// Generate the XML Report for Wire Transactions
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 6/10/2018
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName)
C_DATE:C307($2; $refDate)

C_LONGINT:C283($i; $maxTx)
C_TEXT:C284($root; $transaction)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($blob)

// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------
CLEAR VARIABLE:C89(xmlFile)

$maxTx:=Records in selection:C76([Wires:8])
FIRST RECORD:C50([Wires:8])

$root:=DOM Create XML Ref:C861("report")
GAML_SetReportHeaderFT($root)


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
	If (operationMode=0)  // Production  Mode?
		GAML_SaveAMLReport("IFT")  // Send report Type
		READ WRITE:C146([Wires:8])
		APPLY TO SELECTION:C70([Wires:8]; [eWires:13]wasReported:117:=True:C214)
	End if 
	
	NEXT RECORD:C51([Wires:8])
	
End for   // Loop Transactions

setReportIndicator($root)


DOM EXPORT TO FILE:C862($root; $fileName)
DOM CLOSE XML:C722($root)

REDUCE SELECTION:C351([Invoices:5]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)
REDUCE SELECTION:C351([Wires:8]; 0)

generatedFiles:=generatedFiles+"\n"+$fileName

DOCUMENT TO BLOB:C525($fileName; $blob)
xmlFile:=BLOB to text:C555($blob; UTF8 text without length:K22:17)

If (hasInvalidTags($fileName))
	myAlert("The File "+$fileName+CRLF+"Has invalid values in some tags. The file cannot be manually submitted to the GoAML Platform. Please review!")
End if 


QUERY WITH ARRAY:C644([Wires:8]WireNo:48; arrALLEFT)





