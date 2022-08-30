//%attributes = {}
// ------------------------------------------------------------------------------
// FJ_SetGeneralTxDetail_Wires ($fileName)
// Generate the FIJI FIU Tx Detail (Wires)
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $rptInfo)
C_TEXT:C284($tmp; $branchRegNum; $Address)

Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$rptInfo:=""

READ ONLY:C145([Invoices:5])
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Wires:8]CXR_InvoiceID:12)

$rptInfo:=$rptInfo+FJ_AddTagToReport("C01:"; FJ_FormatDate([Wires:8]WireTransferDate:17; True:C214); True:C214)  // Mandatory
$rptInfo:=$rptInfo+FJ_AddTagToReport(":C02:"; FJ_FormatTime([Invoices:5]CreationTime:14); False:C215)


// Sesnding institution code
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":C03:";FJ_MaxString (reportingEntityID;24);True)

// OR



READ ONLY:C145([Countries:62])
READ ONLY:C145([Branches:70])

If ([Wires:8]isOutgoingWire:16)
	
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Wires:8]BranchID:47)
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C04:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name 
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C05:"; FJ_MaxString([Branches:70]City:4; 35); True:C214)  // City of the sender Branch 
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C06:"; FJ_MaxString([Countries:62]CountryName:2; 35); True:C214)  // Sending institution country
	//$rptInfo:=$rptInfo+":C07:"+"ASK"  // RECEIVING institution code
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString([Wires:8]BeneficiaryBankName:3; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	
	QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C09:"; FJ_MaxString([WireTemplates:42]BankCity:11; 35); True:C214)
	
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C10:"; FJ_MaxString([WireTemplates:42]BankCountry:12; 35); True:C214)  // Receiving institution country
	
	// C11: Into/out of Fiji flag
	$rptInfo:=$rptInfo+":C11:O"+CRLF
Else 
	// C04-C06: Into/out Wire
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C04:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name 
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C05:"; FJ_MaxString(reportingBranchName; 35); True:C214)  // Reporting Branch Name
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C06:"; FJ_MaxString(sendingCountry; 35); True:C214)  // Sending institution country
	
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C09:"; FJ_MaxString([Branches:70]City:4; 35); True:C214)
	
	// Receiving institution city/location
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C10:"; FJ_MaxString([Countries:62]CountryName:2; 35); True:C214)  // Receiving institution country
	
	// C11: Into/out of Fiji flag
	$rptInfo:=$rptInfo+":C11:I"+CRLF
	
End if 

// Transaction Details
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D01:"; FJ_MaxString([Branches:70]BranchName:2; 20); True:C214)  // D01: Initiating branch name
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D03:"; FJ_MaxString([Wires:8]CXR_InvoiceID:12; 16); False:C215)  // D06 Related reference number (Register?)
If ([Customers:3]isCompany:41)
	$rptInfo:=$rptInfo+":D04:N"+CRLF  // Message type: U: Customer-based EFTR, N: Institution-based EFTR
	
Else 
	$rptInfo:=$rptInfo+":D04:U"+CRLF  // Message type: U: Customer-based EFTR, N: Institution-based EFTR
End if 

$rptInfo:=$rptInfo+FJ_AddTagToReport(":D05:"; FJ_MaxString([Wires:8]CXR_WireID:1; 16))  // D05 Transaction reference number
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D06:"; FJ_MaxString([Wires:8]CXR_InvoiceID:12; 72); False:C215)  // D06 Related reference number (Register?)


$rptInfo:=$rptInfo+FJ_AddTagToReport(":D07:"; FJ_FormatDate([Wires:8]WireTransferDate:17; True:C214); True:C214)

$rptInfo:=$rptInfo+FJ_AddTagToReport(":D08:"; FJ_MaxString([Wires:8]Currency:15; 3); True:C214)  // Currency Code

READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[Wires:8]CXR_RegisterID:13)

C_REAL:C285($totNoFees)
$totNoFees:=[Wires:8]AmountLocal:25-[Registers:10]totalFees:30
$tmp:=String:C10($totNoFees; "#############0.00")

$rptInfo:=$rptInfo+FJ_AddTagToReport(":D09:"; FJ_MaxString(String:C10($tmp); 15); True:C214)  // Amount;

$rptInfo:=$rptInfo+FJ_AddTagToReport(":D10:"; FJ_MaxString([Wires:8]AML_PurposeOfTransaction:49; 35; 4); False:C215)  //Details of payment

If ([Branches:70]LocationNumberFT:19="")
	$branchRegNum:="BRANCH REG#*MISSING* "+[Branches:70]BranchName:2
Else 
	$branchRegNum:=[Branches:70]LocationNumberFT:19+" "+[Branches:70]BranchName:2
End if 
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":D13:";FJ_MaxString ($branchRegNum;20);True)  // Initiating branch registration no

//$sendInst:="EFTR INST# *MISSING*"
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":D26:";FJ_MaxString ($sendInst;20);True)  // D26 EFTR sending instn. Code 

$tmp:=String:C10([Wires:8]Amount:14; "#########0.00")
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D28:"; FJ_MaxString($tmp; 15); True:C214)  // ASK D28 FX Amount


QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Wires:8]CustomerID:2)

// E Ordering customer details and  // 6.4.5 Ordering institution details
If ([Wires:8]isOutgoingWire:16)  // Outgoing Wire  
	
	Case of 
			
		: ([Customers:3]isAccount:34)
			
			READ ONLY:C145([WireTemplates:42])
			
			QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=[Wires:8]CustomerID:2)
			QUERY SELECTION:C341([WireTemplates:42]; [WireTemplates:42]relationship:34="self")
			
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([Customers:3]FullName:40; 70); True:C214)
			$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3; False:C215); True:C214)
			
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E09:"; FJ_MaxString([WireTemplates:42]AccountNo:6; 34); False:C215)
			
			
		: ([Customers:3]isCompany:41=False:C215)
			
			// E Ordering customer details
			// 6.4.4 Ordering customer details
			
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([Customers:3]FullName:40; 70); True:C214)
			
			$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3; False:C215); True:C214)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E09:"; FJ_MaxString("N/A"; 34; 1); False:C215)
			// Postal Address
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E20:"; FJ_MaxString($address; 35; 4); True:C214)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([Countries:62]CountryName:2; 35; 1); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E22:"; FJ_MaxString([Customers:3]WorkTel:12; 15; 1); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E23:"; FJ_MaxString($address; 35; 4); True:C214)
			
			QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Wires:8]BranchID:47)
			QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E24:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
			
			
			If ([Customers:3]HomeTel:6#"")
				$rptInfo:=$rptInfo+FJ_AddTagToReport(":E25:"; FJ_MaxString([Customers:3]HomeTel:6; 15; 1); False:C215)
			Else 
				If ([Customers:3]CellPhone:13#"")
					$rptInfo:=$rptInfo+FJ_AddTagToReport(":E25:"; FJ_MaxString([Customers:3]CellPhone:13; 15; 1); False:C215)
				Else 
					
					If ([Customers:3]WorkTel:12#"")
						$rptInfo:=$rptInfo+FJ_AddTagToReport(":E25:"; FJ_MaxString([Customers:3]WorkTel:12; 15; 1); False:C215)
					End if 
					
				End if 
				
			End if 
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E32:"; FJ_MaxString("N/A"; 35; 4); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E33:"; FJ_MaxString([Customers:3]Occupation:21; 30; 1); False:C215)
			
		: ([Customers:3]isCompany:41)
			
			// F Ordering institution details
			// 6.4.5 Ordering institution details
			
			$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
			//$rptInfo:=$rptInfo+FJ_AddTagToReport (":F02:";FJ_MaxString ([Customers]CompanyName+" "+$address;35;4);True)
			
			
			
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([Customers:3]CompanyName:42; 70); True:C214)
			
			$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3; False:C215); True:C214)
			
			// Postal Address
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E20:"; FJ_MaxString($address; 35; 4); True:C214)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([Countries:62]CountryName:2; 35; 1); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E22:"; FJ_MaxString([Customers:3]WorkTel:12; 15; 1); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":E23:"; FJ_MaxString($address; 35; 4); True:C214)
			
	End case 
	
	
	
Else 
	
	// Incoming Wire: there is not incoming wires? ASK
	// E Ordering customer details: using [Wires]OriginatorFullName for companies and Customers
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([Wires:8]OriginatorFullName:34; 70); True:C214)
	
	$address:=FJ_ContactAddress([Wires:8]OriginatorAddress:36; [Wires:8]OriginatorCity:37; [Wires:8]OriginatorState:38; [Wires:8]OriginatorZIP:40; [Wires:8]OriginatorCountry:39)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3); True:C214)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E23:"; FJ_MaxString($address; 35; 4); False:C215)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E24:"; FJ_MaxString([Wires:8]OriginatorCountry:39; 35); False:C215)
	
	
End if 

// G: Sender’s correspondent details
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":G01:";FJ_MaxString (reportingEntityID;24;1);True)  // Sender’s correspondent details. PUT MISSING FOR NOW. PUT THE NAME OF THE FIELDS
$rptInfo:=$rptInfo+FJ_AddTagToReport(":G01:"; FJ_MaxString("N/A"; 24; 1); True:C214)


// OR H02 Name and address 4*35x

// H: Receiver’s correspondent details

//$rptInfo:=$rptInfo+FJ_AddTagToReport (":H01:";FJ_MaxString (reportingEntityID;24;1);True)  // Receiver’s correspondent details. PUT MISSING FOR NOW. PUT THE NAME OF THE FIELDS
$rptInfo:=$rptInfo+FJ_AddTagToReport(":H01:"; FJ_MaxString("N/A"; 24; 1); True:C214)
// OR H02 Name and address 4*35x

// 6.4.10 Beneficiary institution details and 6.4.11 Beneficiary customer details

If ([Wires:8]isOutgoingWire:16)  // Outgoing Wire  
	
	
	If ([Wires:8]isBeneficiaryEntity:71)
		
		$address:=FJ_ContactAddress([Wires:8]BeneficiaryAddress:26; [Wires:8]BeneficiaryCity:50; [Wires:8]BeneficiaryState:51; [Wires:8]BeneficiaryZIPCode:52; [Wires:8]BeneficiaryCountryCode:78)
		$rptInfo:=$rptInfo+FJ_AddTagToReport("K02:"; FJ_MaxString([Wires:8]BeneficiaryFullName:10+" "+$address; 35; 4); True:C214)
		
	Else 
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=[Wires:8]CustomerID:2)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L01:"; FJ_MaxString([WireTemplates:42]BankCity:11; 20); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L03:"; FJ_MaxString([WireTemplates:42]AccountNo:6; 34); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([Wires:8]BeneficiaryFullName:10; 70); True:C214)
		
		$address:=FJ_ContactAddress([Wires:8]BeneficiaryAddress:26; [Wires:8]BeneficiaryCity:50; [Wires:8]BeneficiaryState:51; [Wires:8]BeneficiaryZIPCode:52; [Wires:8]BeneficiaryCountryCode:78)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString($address; 35; 3); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L20:"; FJ_MaxString($address; 35; 4); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L23:"; FJ_MaxString($address; 35; 4); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L24:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L25:"; FJ_MaxString([Wires:8]BeneficiaryPhone:69; 15); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L30:"; FJ_MaxString([WireTemplates:42]BankName:3; 34); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L32:"; FJ_MaxString([WireTemplates:42]WireTemplateAlias:14; 35; 4); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L33:"; "N/A"; False:C215)
		
		If ([Customers:3]isCompany:41)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
		Else 
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "S"; False:C215)
		End if 
		
		
		
		
	End if 
	
	
Else 
	
	// Incoming Wire: Beneficiary is a customer
	
	If ([Customers:3]isCompany:41)
		// 6.4.10 Beneficiary institution details
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":K02:"; FJ_MaxString([Customers:3]CompanyName:42+" "+$address; 35; 4); True:C214)
		
	Else 
		// 6.4.11 Beneficiary customer details
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([Customers:3]FullName:40; 70); True:C214)
		
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString($address; 35; 3); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L22:"; FJ_MaxString([Customers:3]BusinessPhone1:63; 35; 3); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L24:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L25:"; FJ_MaxString([Customers:3]HomeTel:6; 15); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L33:"; FJ_MaxString([Customers:3]Occupation:21; 30); False:C215)
		If ([Customers:3]isCompany:41)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
		Else 
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "S"; False:C215)
		End if 
		
		
		
	End if 
	
	
End if 

appendToFile($fileName; ->$rptInfo; False:C215)




