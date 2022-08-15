//%attributes = {}


// ------------------------------------------------------------------------------
// Method:  AUS_Generate_IFTI_DRA_Wires
// Generate the XML Report for AUSTRAC EFT Wires
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez,12/10/2021
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $goAMLDate)
C_DATE:C307($2; $refDate)

C_BLOB:C604($blob)
ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

C_TEXT:C284($rootRef; $root; $element; $transcation; $phones; $tmp)
C_TEXT:C284($transaction; $root; $header; $ttr; $reportingBranch; $address; $customer; $mainAddress; $occupation; $customer)
C_TEXT:C284($identification; $representedOrganisation; $fullAddress; $individualConductingTxn; $sameAsCustomer; $recipient; $lastCust; $sameAsCustomer)
C_TEXT:C284($txnDate; $suburb; $addr; $foreignCash; $cash; $amount; $moneyProvided; $ausCash; $thridParty; $direction; $valueDate)
C_TEXT:C284($sameAsReceivingInstn; $beneficiaryBranch)
C_LONGINT:C283($maxTx; $seqTx; $seqAddr; $seqCust; $seqOCup; $seqId; $seqInd; $seqOrg; $seqRcp; $seqAmt)
C_LONGINT:C283($segMrv; $seqCsh; $seqFca; $seqMpr; $i)

ARRAY TEXT:C222($arrAttrNames; 0)
ARRAY TEXT:C222($arrAttrValues; 0)

C_TEXT:C284($country; $initiatingInstn; $sameAsCustomer; $country; $sameAsOrderingInstn; $sendingInstn; $receivingInstn; $fullName)
C_TEXT:C284($mainAddress; $suburb; $beneficiaryInstn; $transferee; $fullName; $dob; $phone; $tmp)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

AUS_Get_IFTI_DRA_Wires($refDate)
C_TEXT:C284($transaction; $root; $header; $currencyAmount; $tfrType; $money)
C_LONGINT:C283($i)

// Generate the XML root element
$tmp:=""
$root:=DOM Create XML Ref:C861("ifti-draList")

APPEND TO ARRAY:C911($arrAttrNames; "xmlns")
APPEND TO ARRAY:C911($arrAttrValues; "http://austrac.gov.au/schema/reporting/IFTI-DRA-1-2")
AUS_SetXmlAttrs($root; ->$arrAttrNames; ->$arrAttrValues)

AUS_SetReportHeader($root; $fileName; "IFTI-DRA"; False:C215)


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------

C_LONGINT:C283($maxTx; $seqTx; $seqAddr; $seqCust; $seqInst; $seqBranch; $i; $seqAddr)
C_TEXT:C284($ifti; $tx; $currency; $amount; $transferor; $email; $custNo; $dob)
C_TEXT:C284($branch; $mainAddress; $fullName; $postcode; $foreignBased; $phone; $orderingInstn)

$maxTx:=Records in selection:C76([Wires:8])

$seqAddr:=1
$seqCust:=1
$seqInst:=1
$seqBranch:=1
READ WRITE:C146([Wires:8])
FIRST RECORD:C50([Wires:8])

For ($i; 1; $maxTx)
	//MESSAGE("Processing transaction "+String($i)+" of "+String($maxTx)+"On Date: "+String($refDate))
	
	CLEAR VARIABLE:C89($arrAttrNames)
	CLEAR VARIABLE:C89($arrAttrValues)
	APPEND TO ARRAY:C911($arrAttrNames; "id")
	APPEND TO ARRAY:C911($arrAttrValues; "rpt-"+FT_NumberFormat($i; 0; 2))
	$ifti:=GAML_CreateXMLNode($root; "ifti-dra")
	AUS_SetXmlAttrs($ifti; ->$arrAttrNames; ->$arrAttrValues)
	
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([ThirdParties:101])
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Registers:10])
	READ ONLY:C145([Branches:70])
	READ ONLY:C145([WireTemplates:42])
	
	
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Wires:8]CXR_InvoiceID:12)
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Wires:8]CustomerID:2)
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Wires:8]BranchID:47)
	QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
	
	CLEAR VARIABLE:C89($arrAttrNames)
	CLEAR VARIABLE:C89($arrAttrValues)
	APPEND TO ARRAY:C911($arrAttrNames; "id")
	
	// ----- Header Node --------- //
	$header:=AUS_CreateXMLElement($ifti; "header"; "id"; "hdr-"; ->$i; False:C215)
	$element:=GAML_CreateXMLNode($header; "txnRefNo"; ->[Wires:8]CXR_WireID:1; True:C214)
	
	// ----- Start Transaction Node --------- //
	$tx:=AUS_CreateXMLElement($ifti; "transaction"; "id"; "tx-"; ->$i; False:C215)
	
	$tmp:=FT_GetStringDate([Invoices:5]CreationDate:13; "-")
	$txnDate:=GAML_CreateXMLNode($tx; "txnDate"; ->$tmp)
	
	
	$currencyAmount:=AUS_CreateXMLElement($tx; "currencyAmount"; "id"; "curr-"; ->$i; False:C215)
	$tmp:="AUD"
	$currency:=GAML_CreateXMLNode($currencyAmount; "currency"; ->$tmp; True:C214)
	$amount:=GAML_CreateXMLNode($currencyAmount; "amount"; ->[Wires:8]AmountLocal:25; True:C214)
	
	// Direction i: I-Incoming, O-Out
	$tmp:="I"
	If ([Wires:8]isOutgoingWire:16)
		$tmp:="O"
	End if 
	
	
	$direction:=GAML_CreateXMLNode($tx; "direction"; ->$tmp; True:C214)
	
	
	$tfrType:=AUS_CreateXMLElement($tx; "tfrType"; "id"; "tfrType-"; ->$i; False:C215)
	$money:=GAML_CreateXMLNode($tfrType; "money")
	
	$tmp:=FT_GetStringDate([Wires:8]WireTransferDate:17; "-")
	$valueDate:=GAML_CreateXMLNode($tx; "valueDate"; ->$tmp; True:C214)
	
	// ----- End Transaction Node --------- //
	
	
	// ----- Begin Transferor Node --------- //
	
	
	$transferor:=AUS_CreateXMLElement($ifti; "transferor"; "id"; "transferor-"; ->$i; False:C215)
	
	If ([Wires:8]isOutgoingWire:16)  // Outgoing wire
		// The sender info is in [customers] table and the beneficiary is in [Links] table
		
		$fullName:=GAML_CreateXMLNode($transferor; "fullName"; ->[Customers:3]FullName:40; True:C214)
		
		$mainAddress:=AUS_CreateXMLElement($transferor; "mainAddress"; "id"; "mainAddress-"; ->$seqAddr; True:C214)
		$addr:=GAML_CreateXMLNode($mainAddress; "addr"; ->[Customers:3]Address:7; True:C214)
		$suburb:=GAML_CreateXMLNode($mainAddress; "suburb"; ->[Customers:3]City:8; False:C215)
		$country:=GAML_CreateXMLNode($mainAddress; "country"; ->[Customers:3]CountryCode:113; True:C214)
		
		
		$phone:=GAML_CreateXMLNode($transferor; "phone"; ->[Customers:3]HomeTel:6; True:C214)
		$email:=GAML_CreateXMLNode($transferor; "email"; ->[Customers:3]Email:17; False:C215)
		$custNo:=GAML_CreateXMLNode($transferor; "custNo"; ->[Customers:3]CustomerID:1; False:C215)
		
		If ([Customers:3]isCompany:41=False:C215)
			$tmp:=FT_GetStringDate([Customers:3]DOB:5; "-")
			$dob:=GAML_CreateXMLNode($transferor; "dob"; ->$tmp; False:C215)
		End if 
		
		$identification:=AUS_CreateXMLElement($transferor; "identification"; "id"; "identification-"; ->$i; False:C215)
		GAML_CreateXMLNode($identification; "type"; ->[Customers:3]PictureID_GovernmentCode:20; True:C214)
		GAML_CreateXMLNode($identification; "number"; ->[Customers:3]PictureID_Number:69; False:C215)
		GAML_CreateXMLNode($identification; "issuer"; ->[Customers:3]PictureID_Authority:116; False:C215)
		
	End if 
	
	
	// ----- End Transferor Node --------- //
	
	// ----- Begin orderingInstn Node --------- //
	
	$orderingInstn:=AUS_CreateXMLElement($ifti; "orderingInstn"; "id"; "orderingInstn-"; ->$i; False:C215)
	
	$branch:=AUS_CreateXMLElement($orderingInstn; "branch"; "id"; "branch-"; ->$i; False:C215)
	
	$tmp:=[CompanyInfo:7]organizationNo:18+"-"+[Branches:70]BranchSiteID:16+"-"+[Branches:70]BranchName:2
	//$fullName:=GAML_CreateXMLNode ($branch;"fullName";->[Branches]BranchName;False)
	$fullName:=GAML_CreateXMLNode($branch; "fullName"; ->$tmp; False:C215)
	
	$mainAddress:=AUS_CreateXMLElement($branch; "mainAddress"; "id"; "mainAddress-"; ->$seqAddr; True:C214)
	$addr:=GAML_CreateXMLNode($branch; "addr"; ->[Branches:70]Address:3; True:C214)
	$suburb:=GAML_CreateXMLNode($branch; "suburb"; ->[Branches:70]City:4; False:C215)
	$postcode:=GAML_CreateXMLNode($branch; "postcode"; ->[Branches:70]PostalCode:11; False:C215)
	$country:=GAML_CreateXMLNode($branch; "country"; ->[Branches:70]CountryCode:12; False:C215)
	
	$tmp:="Y"
	$foreignBased:=GAML_CreateXMLNode($branch; "foreignBased"; ->$tmp; False:C215)
	
	
	$phone:=GAML_CreateXMLNode($orderingInstn; "phone"; ->[CompanyInfo:7]Tel1:3; False:C215)
	$email:=GAML_CreateXMLNode($orderingInstn; "email"; ->[CompanyInfo:7]Email:6; False:C215)
	
	// ----- End orderingInstn Node --------- //
	
	
	
	// ----- Start initiatingInstn and sendingInstn Node --------- //
	$tmp:="Y"
	$initiatingInstn:=AUS_CreateXMLElement($ifti; "initiatingInstn"; "id"; "initiatingInstn-"; ->$i; False:C215)
	$sameAsOrderingInstn:=GAML_CreateXMLNode($initiatingInstn; "sameAsOrderingInstn"; ->$tmp; True:C214)
	
	$sendingInstn:=AUS_CreateXMLElement($ifti; "sendingInstn"; "id"; "sendingInstn-"; ->$seqInst; True:C214)
	$sameAsOrderingInstn:=GAML_CreateXMLNode($sendingInstn; "sameAsOrderingInstn"; ->$tmp; True:C214)
	// ----- End initiatingInstn and sendingInstn Node --------- //
	
	
	// ----- start receivingInstn --------- // 
	
	$receivingInstn:=AUS_CreateXMLElement($ifti; "receivingInstn"; "id"; "receivingInstn-"; ->$i; False:C215)
	$tmp:=getKeyValue("NZ_PTR.Receiving.Instn.FullName")
	//$fullName:=GAML_CreateXMLNode ($receivingInstn;"fullName";->[Agents]FullName;True)
	$fullName:=GAML_CreateXMLNode($receivingInstn; "fullName"; ->$tmp; True:C214)
	
	$tmp:=getKeyValue("NZ_PTR.Receiving.Instn_Address")
	$mainAddress:=AUS_CreateXMLElement($receivingInstn; "mainAddress"; "id"; "mainAddress-"; ->$seqAddr; True:C214)
	$addr:=GAML_CreateXMLNode($mainAddress; "addr"; ->$tmp; True:C214)
	
	$tmp:=getKeyValue("NZ_PTR.Receiving.Instn_City")
	$suburb:=GAML_CreateXMLNode($mainAddress; "suburb"; ->$tmp; False:C215)
	
	$tmp:=getKeyValue("NZ_PTR.Receiving.Instn_Country")
	$country:=GAML_CreateXMLNode($mainAddress; "country"; ->$tmp; True:C214)
	
	//$fullName:=GAML_CreateXMLNode ($receivingInstn;"fullName";->[WireTemplates]BankName;True)
	
	
	//$mainAddress:=AUS_CreateXMLElement ($receivingInstn;"mainAddress";"id";"mainAddress-";->$seqAddr;True)
	//$addr:=GAML_CreateXMLNode ($mainAddress;"addr";->[WireTemplates]BankAddress;True)
	//$suburb:=GAML_CreateXMLNode ($mainAddress;"suburb";->[WireTemplates]BankCity;False)
	//$country:=GAML_CreateXMLNode ($mainAddress;"country";->[WireTemplates]BankCountry;True)
	// ----- End receivingInstn --------- //
	
	
	// ----- start beneficiaryInstn --------- //  // Agent sameAsReceivingInstn //
	$beneficiaryInstn:=AUS_CreateXMLElement($ifti; "beneficiaryInstn"; "id"; "beneficiaryInstn-"; ->$i; False:C215)
	$sameAsReceivingInstn:=GAML_CreateXMLNode($beneficiaryInstn; "sameAsReceivingInstn"; ->$tmp; True:C214)
	// ----- End beneficiaryInstn --------- //  // Agent sameAsReceivingInstn //
	
	// Provide details of the beneficiary customer receiving money or property.
	$transferee:=AUS_CreateXMLElement($ifti; "transferee"; "id"; "transferee-"; ->$i; False:C215)
	
	
	If ([Wires:8]isOutgoingWire:16)  // Outgoing
		
		// Outgoing wire: Beneficiary is the person that receive the money. is in Wire templates table
		
		
		If ([WireTemplates:42]BeneficiaryIsCompany:39)
			$fullName:=GAML_CreateXMLNode($transferee; "fullName"; ->[WireTemplates:42]BeneficiaryFullName:9; True:C214)
		Else 
			
			If (([WireTemplates:42]BeneficiaryFirstName:40#"") & ([WireTemplates:42]BeneficiaryLastName:41#""))
				$tmp:=[WireTemplates:42]BeneficiaryFirstName:40+"  "+[WireTemplates:42]BeneficiaryLastName:41
				$fullName:=GAML_CreateXMLNode($transferee; "fullName"; ->$tmp; True:C214)
			Else 
				$fullName:=GAML_CreateXMLNode($transferee; "fullName"; ->[WireTemplates:42]BeneficiaryFullName:9; True:C214)
			End if 
			
		End if 
		
		$mainAddress:=AUS_CreateXMLElement($transferee; "mainAddress"; "id"; "mainAddress-"; ->$seqAddr; True:C214)
		$addr:=GAML_CreateXMLNode($mainAddress; "addr"; ->[WireTemplates:42]BeneficiaryAddress:19; True:C214)
		$suburb:=GAML_CreateXMLNode($mainAddress; "suburb"; ->[WireTemplates:42]BeneficiaryCity:24; False:C215)
		$tmp:=getCountryNameByCode([WireTemplates:42]BeneficiaryCountryCode:27)
		$country:=GAML_CreateXMLNode($mainAddress; "country"; ->$tmp; True:C214)
		
		$phone:=GAML_CreateXMLNode($transferee; "phone"; ->[WireTemplates:42]BeneficiaryPhone:30; False:C215)
	End if 
	
	C_TEXT:C284($additionalDetails)
	C_TEXT:C284($reasonForTransfer)
	
	If ([Invoices:5]AMLPurposeOfTransaction:85#"")
		$additionalDetails:=AUS_CreateXMLElement($ifti; "additionalDetails"; "id"; "additionalDetails-"; ->$i; False:C215)
		$reasonForTransfer:=GAML_CreateXMLNode($additionalDetails; "reasonForTransfer"; ->[Invoices:5]AMLPurposeOfTransaction:85; False:C215)
	End if 
	
	
	If (operationMode=0)  // Production  Mode?
		GAML_SaveAMLReport("IFTI-DRA")  // Send report Type
		
		//[Wires]wasReported:=True
		//SAVE RECORD([Wires])
		
	End if 
	APPEND TO ARRAY:C911(arrWiresReport; [Wires:8]CXR_WireID:1)
	APPEND TO ARRAY:C911(arrInvoicesReport; [Invoices:5]InvoiceID:1)
	NEXT RECORD:C51([Wires:8])
	
End for   // Loop wires

DOM EXPORT TO FILE:C862($root; $fileName)
DOM CLOSE XML:C722($root)

REDUCE SELECTION:C351([ThirdParties:101]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)
REDUCE SELECTION:C351([Branches:70]; 0)
REDUCE SELECTION:C351([WireTemplates:42]; 0)

If (Records in selection:C76([Wires:8])>0)
	generatedFiles:=generatedFiles+"\n"+$fileName
	APPEND TO ARRAY:C911(arrFilesReport; $fileName)
	DOCUMENT TO BLOB:C525($fileName; $blob)
	xmlFile:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
Else 
	DELETE DOCUMENT:C159($fileName)
End if 


