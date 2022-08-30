//%attributes = {}

// ------------------------------------------------------------------------------
// Method: AUS_Generate_TTR_Report 
// Generate the XML Report for AUSTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 7/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $goAMLDate)
C_DATE:C307($2; $refDate)

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)


ARRAY TEXT:C222($arrAttrNames; 0)
ARRAY TEXT:C222($arrAttrValues; 0)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($transaction; $root; $header; $ttr; $reportingBranch; $address; $customer; $mainAddress; $occupation; $customer)
C_TEXT:C284($identification; $representedOrganisation; $fullAddress; $individualConductingTxn; $sameAsCustomer; $recipient; $lastCust; $sameAsCustomer)
C_TEXT:C284($foreignCash; $cash; $amount; $moneyProvided; $ausCash; $thridParty)
C_LONGINT:C283($maxTx; $seqTx; $seqAddr; $seqCust; $seqOCup; $seqId; $seqInd; $seqOrg; $seqRcp; $seqAmt)
C_LONGINT:C283($segMrv; $seqCsh; $seqFca; $seqMpr; $i)
C_TEXT:C284($fullName; $totalAmount; $moneyReceived; $nonCashProvided)
C_BLOB:C604($blob)

// Get Transactions
AUS_Get_TTR_Transactions($refDate)


// Generate the XML root element
$tmp:=""
$root:=DOM Create XML Ref:C861("ttr-msbList")

APPEND TO ARRAY:C911($arrAttrNames; "xmlns")
APPEND TO ARRAY:C911($arrAttrValues; "http://austrac.gov.au/schema/reporting/TTR-MSB-2-0")
AUS_SetXmlAttrs($root; ->$arrAttrNames; ->$arrAttrValues)

AUS_SetReportHeader($root; $fileName; "TTR-MSB")


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------

$maxTx:=Size of array:C274(arrFTCustomerId)
$seqTx:=1
$seqAddr:=1
$seqCust:=1
$seqOcup:=1
$seqId:=1
$seqInd:=1
$seqOrg:=1
$seqRcp:=1
$seqAmt:=1
$segMrv:=1
$seqCsh:=1
$seqFca:=1
$seqMpr:=1

For ($i; 1; $maxTx)
	//MESSAGE("Processing transaction "+String($i)+" of "+String($maxTx)+"On Date: "+String($refDate))
	
	
	$ttr:=AUS_CreateXMLElement($root; "ttr-msb"; "id"; "rpt-"; ->$seqTx; True:C214)
	
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([ThirdParties:101])
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Registers:10])
	READ ONLY:C145([Branches:70])
	READ ONLY:C145([CompanyInfo:7])
	
	ALL RECORDS:C47([CompanyInfo:7])
	
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=arrFTInvoiceNumber{$i})
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=arrFTInvoiceNumber{$i})
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	
	$header:=AUS_CreateXMLElement($ttr; "header"; "id"; "hdr-"; ->$i; False:C215)
	
	$element:=GAML_CreateXMLNode($header; "txnRefNo"; ->arrFTRegisterID{$i}; False:C215)
	$reportingBranch:=GAML_CreateXMLNode($header; "reportingBranch")
	
	
	CLEAR VARIABLE:C89($arrAttrNames)
	CLEAR VARIABLE:C89($arrAttrValues)
	APPEND TO ARRAY:C911($arrAttrNames; "id")
	APPEND TO ARRAY:C911($arrAttrValues; "rbr-"+[Branches:70]BranchID:1)
	AUS_SetXmlAttrs($reportingBranch; ->$arrAttrNames; ->$arrAttrValues)
	
	$tmp:=[CompanyInfo:7]organizationNo:18+"-"+[Branches:70]BranchSiteID:16
	$element:=GAML_CreateXMLNode($reportingBranch; "branchId"; ->$tmp; True:C214)
	$element:=GAML_CreateXMLNode($reportingBranch; "name"; ->[Branches:70]BranchName:2; True:C214)
	
	$address:=GAML_CreateXMLNode($reportingBranch; "address")
	$arrAttrValues{1}:="adr-"+FT_NumberFormat($seqAddr; 0; 3)
	AUS_SetXmlAttrs($address; ->$arrAttrNames; ->$arrAttrValues)
	
	$element:=GAML_CreateXMLNode($address; "addr"; ->[Branches:70]Address:3; True:C214)
	$element:=GAML_CreateXMLNode($address; "suburb"; ->[Branches:70]City:4; True:C214)
	$element:=GAML_CreateXMLNode($address; "state"; ->[Branches:70]Province:10; False:C215)
	$element:=GAML_CreateXMLNode($address; "postcode"; ->[Branches:70]PostalCode:11; False:C215)
	
	$seqAddr:=$seqAddr+1
	
	// Create Customers node
	
	$customer:=GAML_CreateXMLNode($ttr; "customer")
	$arrAttrValues{1}:="cust-"+FT_NumberFormat($seqCust; 0; 3)
	$lastCust:=$arrAttrValues{1}
	AUS_SetXmlAttrs($customer; ->$arrAttrNames; ->$arrAttrValues)
	$seqCust:=$seqCust+1
	
	If ([Customers:3]isCompany:41)
		$element:=GAML_CreateXMLNode($customer; "fullName"; ->[Customers:3]CompanyName:42; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($customer; "fullName"; ->[Customers:3]FullName:40; True:C214)
	End if 
	
	// Create Customers' address Element
	
	$mainAddress:=GAML_CreateXMLNode($customer; "mainAddress")
	$arrAttrValues{1}:="adr-"+FT_NumberFormat($seqAddr; 0; 3)
	AUS_SetXmlAttrs($mainAddress; ->$arrAttrNames; ->$arrAttrValues)
	$seqAddr:=$seqAddr+1
	
	$element:=GAML_CreateXMLNode($mainAddress; "addr"; ->[Customers:3]Address:7; True:C214)
	$element:=GAML_CreateXMLNode($mainAddress; "suburb"; ->[Customers:3]City:8; True:C214)
	$element:=GAML_CreateXMLNode($mainAddress; "state"; ->[Customers:3]Province:9; False:C215)
	$element:=GAML_CreateXMLNode($mainAddress; "postcode"; ->[Customers:3]PostalCode:10; False:C215)
	$tmp:=getCountryNameByCode([Customers:3]CountryCode:113)
	$element:=GAML_CreateXMLNode($mainAddress; "country"; ->$tmp; False:C215)
	// Create Customers' Occupation Element
	
	If ([Customers:3]Occupation:21#"")
		$occupation:=GAML_CreateXMLNode($customer; "indOcc")
		$arrAttrValues{1}:="ioc-"+FT_NumberFormat($seqOcup; 0; 3)
		AUS_SetXmlAttrs($occupation; ->$arrAttrNames; ->$arrAttrValues)
		
		$element:=GAML_CreateXMLNode($occupation; "description"; ->[Customers:3]Occupation:21; True:C214)
	End if 
	
	$tmp:=FT_GetStringDate([Customers:3]DOB:5; "-")
	//$dob:=GAML_CreateXMLNode ($customer;"dob")
	$element:=GAML_CreateXMLNode($customer; "dob"; ->$tmp; True:C214)
	
	$identification:=GAML_CreateXMLNode($customer; "identification")
	$arrAttrValues{1}:="id-"+FT_NumberFormat($seqId; 0; 3)
	AUS_SetXmlAttrs($identification; ->$arrAttrNames; ->$arrAttrValues)
	
	$element:=GAML_CreateXMLNode($identification; "type"; ->[Customers:3]PictureID_GovernmentCode:20; True:C214)
	$element:=GAML_CreateXMLNode($identification; "number"; ->[Customers:3]PictureID_Number:69; False:C215)
	$element:=GAML_CreateXMLNode($identification; "country"; ->[Customers:3]PictureID_IssueCountry:73; False:C215)
	$element:=GAML_CreateXMLNode($identification; "issuer"; ->[Customers:3]PictureID_Authority:116; False:C215)
	$tmp:=getCountryNameByCode([Customers:3]PictureID_CountryCode:118)
	$element:=GAML_CreateXMLNode($identification; "country"; ->$tmp; False:C215)
	
	If (False:C215)
		
		If ([Customers:3]isCompany:41)
			$representedOrganisation:=GAML_CreateXMLNode($ttr; "representedOrganisation")
			$arrAttrValues{1}:="org-"+FT_NumberFormat($seqOrg; 0; 3)
			AUS_SetXmlAttrs($representedOrganisation; ->$arrAttrNames; ->$arrAttrValues)
			$seqOrg:=$seqOrg+1
			
			$element:=GAML_CreateXMLNode($representedOrganisation; "fullName"; ->[Customers:3]CompanyName:42; True:C214)
			
			$fullAddress:=GAML_CreateXMLNode($representedOrganisation; "mainAdress")
			$arrAttrValues{1}:="adr-"+FT_NumberFormat($seqAddr; 0; 3)
			AUS_SetXmlAttrs($fullAddress; ->$arrAttrNames; ->$arrAttrValues)
			$seqAddr:=$seqAddr+1
			
			$element:=GAML_CreateXMLNode($fullAddress; "addr"; ->[Customers:3]Address:7; True:C214)
			$element:=GAML_CreateXMLNode($fullAddress; "suburb"; ->[Customers:3]City:8; True:C214)
			$element:=GAML_CreateXMLNode($fullAddress; "state"; ->[Customers:3]Province:9; False:C215)
			$element:=GAML_CreateXMLNode($fullAddress; "postcode"; ->[Customers:3]PostalCode:10; False:C215)
			$seqAddr:=$seqAddr+1
			
		End if 
		
		
	End if 
	
	$individualConductingTxn:=GAML_CreateXMLNode($ttr; "individualConductingTxn")
	$arrAttrValues{1}:="id-"+FT_NumberFormat($seqInd; 0; 3)
	AUS_SetXmlAttrs($individualConductingTxn; ->$arrAttrNames; ->$arrAttrValues)
	$seqInd:=$seqInd+1
	
	If ([Invoices:5]ThirdPartyisInvolved:22)
		$fullName:=[ThirdParties:101]FirstName:4+" "+[ThirdParties:101]LastName:3
		$thridParty:=GAML_CreateXMLNode($individualConductingTxn; "fullName"; ->$fullName; True:C214)
		
		$mainAddress:=GAML_CreateXMLNode($individualConductingTxn; "mainAddress")
		$arrAttrValues{1}:="adr-"+FT_NumberFormat($seqAddr; 0; 3)
		AUS_SetXmlAttrs($mainAddress; ->$arrAttrNames; ->$arrAttrValues)
		$seqAddr:=$seqAddr+1
		
		$element:=GAML_CreateXMLNode($mainAddress; "addr"; ->[ThirdParties:101]Address:6; True:C214)
		$element:=GAML_CreateXMLNode($mainAddress; "suburb"; ->[ThirdParties:101]City:7; True:C214)
		$element:=GAML_CreateXMLNode($mainAddress; "state"; ->[ThirdParties:101]theState:29; False:C215)
		$element:=GAML_CreateXMLNode($mainAddress; "postcode"; ->[ThirdParties:101]ZipCode:9; False:C215)
		
		
		$element:=GAML_CreateXMLNode($individualConductingTxn; "phone"; ->[ThirdParties:101]HomePhone:10; False:C215)
		
		// Create ThirdParty' Occupation Element
		
		
		If ([ThirdParties:101]Occupation:20#"")
			$occupation:=GAML_CreateXMLNode($customer; "occupation")
			$arrAttrValues{1}:="ioc-"+FT_NumberFormat($seqOcup; 0; 3)
			AUS_SetXmlAttrs($occupation; ->$arrAttrNames; ->$arrAttrValues)
			
			$element:=GAML_CreateXMLNode($occupation; "description"; ->[ThirdParties:101]Occupation:20; True:C214)
		End if 
		
		$tmp:=FT_GetStringDate([ThirdParties:101]DOB:13; "-")
		$element:=GAML_CreateXMLNode($individualConductingTxn; "dob"; ->$tmp; False:C215)
		
		
		$identification:=GAML_CreateXMLNode($individualConductingTxn; "identification")
		$arrAttrValues{1}:="id-"+FT_NumberFormat($seqId; 0; 3)
		AUS_SetXmlAttrs($identification; ->$arrAttrNames; ->$arrAttrValues)
		
		$tmp:=Substring:C12([ThirdParties:101]IdType:14; 1; 1)
		$element:=GAML_CreateXMLNode($individualConductingTxn; "type"; ->$tmp; True:C214)
		$element:=GAML_CreateXMLNode($individualConductingTxn; "number"; ->[ThirdParties:101]IdNumber:16; False:C215)
		$element:=GAML_CreateXMLNode($individualConductingTxn; "country"; ->[ThirdParties:101]IdCountryOfIssue:18; False:C215)
		
		
	Else 
		$sameAsCustomer:=GAML_CreateXMLNode($individualConductingTxn; "sameAsCustomer")
		$arrAttrNames{1}:="refId"
		$arrAttrValues{1}:=$lastCust
		AUS_SetXmlAttrs($sameAsCustomer; ->$arrAttrNames; ->$arrAttrValues)
	End if 
	
	
	
	$recipient:=GAML_CreateXMLNode($ttr; "recipient")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="rcp-"+FT_NumberFormat($seqRcp; 0; 3)
	AUS_SetXmlAttrs($recipient; ->$arrAttrNames; ->$arrAttrValues)
	$seqRcp:=$seqRcp+1
	
	
	$sameAsCustomer:=GAML_CreateXMLNode($recipient; "sameAsCustomer")
	$arrAttrNames{1}:="refId"
	$arrAttrValues{1}:=$lastCust
	AUS_SetXmlAttrs($sameAsCustomer; ->$arrAttrNames; ->$arrAttrValues)
	
	// Trnasaction Element
	
	$transaction:=GAML_CreateXMLNode($ttr; "transaction")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="txn-"+[Registers:10]RegisterID:1
	AUS_SetXmlAttrs($transaction; ->$arrAttrNames; ->$arrAttrValues)
	
	$tmp:=FT_GetStringDate([Registers:10]CreationDate:14; "-")
	$element:=GAML_CreateXMLNode($transaction; "txnDate"; ->$tmp; False:C215)
	
	// Total Amount
	$totalAmount:=AUS_CreateXMLElement($transaction; "totalAmount"; "id"; "tam-"; ->$seqAmt; True:C214)
	$tmp:=[Registers:10]Currency:19
	$element:=GAML_CreateXMLNode($totalAmount; "currrency"; ->$tmp; True:C214)
	$tmp:=String:C10([Registers:10]DebitLocal:23)
	$element:=GAML_CreateXMLNode($totalAmount; "amount"; ->$tmp; True:C214)
	$seqAmt:=$seqAmt+1
	
	$tmp:="CUR_EXCH"
	$element:=GAML_CreateXMLNode($transaction; "designatedSvc"; ->$tmp; True:C214)
	
	
	// --------------------------
	// Money Received
	// --------------------------
	$moneyReceived:=GAML_CreateXMLNode($ttr; "moneyReceived")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="mrv-"+FT_NumberFormat($segMrv; 0; 3)
	AUS_SetXmlAttrs($moneyReceived; ->$arrAttrNames; ->$arrAttrValues)
	
	$cash:=GAML_CreateXMLNode($moneyReceived; "cash")
	
	$foreignCash:=GAML_CreateXMLNode($cash; "foreignCash")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="fca-"+FT_NumberFormat($seqFca; 0; 3)
	AUS_SetXmlAttrs($foreignCash; ->$arrAttrNames; ->$arrAttrValues)
	$seqFca:=$seqFca+1
	
	
	$element:=GAML_CreateXMLNode($foreignCash; "currrency"; ->[Registers:10]Currency:19; True:C214)
	$amount:=String:C10([Registers:10]Debit:8)
	$element:=GAML_CreateXMLNode($foreignCash; "amount"; ->$amount; True:C214)
	$seqAmt:=$seqAmt+1
	
	// --------------------------
	// Money Provided
	// --------------------------
	
	$moneyProvided:=GAML_CreateXMLNode($ttr; "moneyProvided")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="mpr-"+FT_NumberFormat($seqMpr; 0; 3)
	AUS_SetXmlAttrs($moneyProvided; ->$arrAttrNames; ->$arrAttrValues)
	$seqMpr:=$seqMpr+1
	
	$cash:=GAML_CreateXMLNode($moneyProvided; "cash")
	$ausCash:=GAML_CreateXMLNode($moneyProvided; "ausCash")
	$arrAttrNames{1}:="id"
	$arrAttrValues{1}:="csh-"+FT_NumberFormat($seqCsh; 0; 3)
	AUS_SetXmlAttrs($moneyProvided; ->$arrAttrNames; ->$arrAttrValues)
	$seqCsh:=$seqCsh+1
	
	$element:=GAML_CreateXMLNode($ausCash; "currrency"; -><>baseCurrency; True:C214)
	$amount:=String:C10([Registers:10]DebitLocal:23)
	$element:=GAML_CreateXMLNode($ausCash; "amount"; ->$amount; True:C214)
	$seqAmt:=$seqAmt+1
	
	
	$cash:=GAML_CreateXMLNode($moneyProvided; "cash")
	$nonCashProvided:=GAML_CreateXMLNode($moneyProvided; "nonCashProvided")
	
	
	If (operationMode=0)  // Production  Mode?
		GAML_SaveAMLReport("TTR-MSB")  // Send report Type
		
		
		READ WRITE:C146([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
		If (Records in selection:C76([Registers:10])=1)
			
			[Registers:10]isExported:44:=True:C214
			SAVE RECORD:C53([Registers:10])
		End if 
	End if 
	
	
	
End for   // Loop Transactions

DOM EXPORT TO FILE:C862($root; $fileName)
DOM CLOSE XML:C722($root)

REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)

If (Records in selection:C76([Invoices:5])>0)
	generatedFiles:=generatedFiles+"\n"+$fileName
	APPEND TO ARRAY:C911(arrFilesReport; $fileName)
	DOCUMENT TO BLOB:C525($fileName; $blob)
	xmlFile:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
	
	//If (hasInvalidTags ($fileName))
	//myAlert ("The File "+$fileName+CRLF +"Has invalid values in some tags. The file cannot be manually submitted to the AUSTRAC Platform. Please review!")
	//End if 
Else 
	DELETE DOCUMENT:C159($fileName)
End if 





