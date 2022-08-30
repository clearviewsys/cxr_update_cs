//%attributes = {}

// setTxHeaderWire($root;$transaction)
// Generate the tag <Transaction> for PTR Report (Inocming Wire)

C_TEXT:C284($1; $transaction; $tmp)

Case of 
	: (Count parameters:C259=1)
		$transaction:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($goAMLDate; $element)

READ ONLY:C145([Branches:70])
QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Wires:8]BranchID:47)

// TODO: Check for Relianz, Lotus only report the transactionnumber and the INvoice number into it
//$element:=GAML_CreateXMLNode ($transaction;"transactionnumber";->[Wires]CXR_WireID)
//$element:=GAML_CreateXMLNode ($transaction;"internal_ref_number";->[Wires]CXR_InvoiceID)

$element:=GAML_CreateXMLNode($transaction; "transactionnumber"; ->[Wires:8]CXR_InvoiceID:12)

$tmp:=Replace string:C233([Branches:70]BranchName:2+", "+[Branches:70]Address:3+", "+[Branches:70]City:4; Char:C90(CR ASCII code:K15:14); "")
If (([Branches:70]Address:3="") | ([Branches:70]City:4=""))
	$tmp:=Replace string:C233($tmp; ", "; "")
End if 
$tmp:=Replace string:C233($tmp; Char:C90(LF ASCII code:K15:11); "")

$element:=GAML_CreateXMLNode($transaction; "transaction_location"; ->$tmp)
//$element:=GAML_CreateXMLNode ($transaction;"transaction_location";->[Branches]BranchName)

//$element:=GAML_CreateXMLNode ($transaction;"transaction_description";->[Wires]AutoComments)
$goAMLDate:=FT_GetStringDate([Wires:8]WireTransferDate:17; "-")+"T"+FT_GetStringTime([Invoices:5]CreationTime:14; ":")
$element:=GAML_CreateXMLNode($transaction; "date_transaction"; ->$goAMLDate)


