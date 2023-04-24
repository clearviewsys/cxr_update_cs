//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_Generate_LCT_Report
// Generate the XML Report for goAML
// 
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/9/2017
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName; $goAMLDate)
C_DATE:C307($2; $refDate)

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)
C_TEXT:C284($from_account; $t_entity; $signatory; $t_person; $t_to; $to_account)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get the config information from the goaml.ini saved in the active 4D Database Folder
//GAML_GetEntityAndContactInfo 

// Generate the XML Header
$root:=DOM Create XML Ref:C861("report")

GAML_SetReportHeader($root; <>Reports_PTR_ReportCodeLCT)

//GAML_SetReportingPerson ($root)
//GAML_SetLocation ($root)


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------
C_LONGINT:C283($maxTx; $i; $type)
C_TEXT:C284($transaction; $tmp)
C_TEXT:C284($t_from_my_client; $element; $fromForeignCurrency; $from_person; $t_to_my_client; $to_person; $toForeignCurrency; $dummy)
C_BLOB:C604($blob)


$maxTx:=Size of array:C274(arrFTCustomerId)

For ($i; 1; $maxTx)
	
	
	READ ONLY:C145([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([ThirdParties:101])
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	
	READ ONLY:C145([AccountInOuts:37])
	QUERY:C277([AccountInOuts:37]; [AccountInOuts:37]InvoiceID:4=[Invoices:5]InvoiceID:1)
	
	// In NZ one Invoice has only one account in Cahs Transactions
	READ WRITE:C146([Sequence_Config:81])
	QUERY:C277([Sequence_Config:81]; [Sequence_Config:81]Name:1=[AccountInOuts:37]AccountInOutID:1)
	
	$type:=GAML_hasEFTRelated([Registers:10]InvoiceNumber:10)
	
	Case of 
			
		: ($type=1)
			GAML_GenerateEwireTx($root; $fileName; [Invoices:5]InvoiceID:1)
		: ($type=2)
			GAML_GenerateWireTx($root; $fileName; [Invoices:5]InvoiceID:1)
		: ($type=3)
			GAML_GenerateCashTx($root; $fileName; [Invoices:5]InvoiceID:1)
		: ($type=4)
			GAML_GenerateAcctTx($root; $fileName; [Invoices:5]InvoiceID:1)
			
	End case 
	
	
End for   // Loop Transactions
setReportIndicator($root)

DOM EXPORT TO FILE:C862($root; $fileName)
DOM CLOSE XML:C722($root)

REDUCE SELECTION:C351([Invoices:5]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)

generatedFiles:=generatedFiles+"\n"+$fileName

DOCUMENT TO BLOB:C525($fileName; $blob)
xmlFile:=BLOB to text:C555($blob; UTF8 text without length:K22:17)

If (hasInvalidTags($fileName))
	myAlert("The File "+$fileName+CRLF+"Has invalid values in some tags. The file cannot be manually submitted to the GoAML Platform. Please review!")
End if 

QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)




