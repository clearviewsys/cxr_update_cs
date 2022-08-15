//%attributes = {}

// ------------------------------------------------------------------------------
// FJ_SetGeneralTxDetail_Ewire ($fileName)
// Generate the FIJI FIU Tx Detail
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $rptInfo)

Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($branch; $tmp; $branchRegNum; $Address)
$rptInfo:=""

If ([eWires:13]isSettled:23)
	$rptInfo:=$rptInfo+FJ_AddTagToReport("C01:"; FJ_FormatDate([eWires:13]ReceiveDate:18; True:C214); True:C214)  // Mandatory
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C02:"; FJ_FormatTime([eWires:13]ReceiveTime:19); False:C215)
Else 
	$rptInfo:=$rptInfo+FJ_AddTagToReport("C01:"; FJ_FormatDate([eWires:13]SendDate:2; True:C214); True:C214)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C02:"; FJ_FormatTime([eWires:13]creationTime:54); False:C215)
End if 


READ ONLY:C145([Invoices:5])
QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[eWires:13]InvoiceNumber:29)

If ([eWires:13]isPaymentSent:20)  // outgoing eWires
	
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[eWires:13]BranchID:50)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C04:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name 
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C05:"; FJ_MaxString([Branches:70]City:4; 35); True:C214)  // City of the sender Branch 
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C06:"; FJ_MaxString([Countries:62]CountryName:2; 35); True:C214)  // Sending institution country
	//$rptInfo:=$rptInfo+":C07:"+"ASK"  // RECEIVING institution code
	
	If ([eWires:13]doTransferToBank:33)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	Else 
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	End if 
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C09:"; FJ_MaxString([eWires:13]BeneficiaryCity:60; 35); True:C214)  // Sending institution country
	
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[eWires:13]toCountryCode:112)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C10:"; FJ_MaxString([Countries:62]CountryName:2; 35); True:C214)  // Receiving institution country
	
	// C11: Into/out of Fiji flag
	$rptInfo:=$rptInfo+":C11:O"+CRLF
	
	
Else   // incoming eWires
	
	
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[eWires:13]BranchID:50)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C04:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name 
	If ([eWires:13]fromCountryCode:111="NZ")
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C05:"; FJ_MaxString("AUCKLAND"; 35); True:C214)  // Sending institution country
	Else 
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C05:"; FJ_MaxString([Branches:70]City:4; 35); True:C214)  // City of the sender Branch 
	End if 
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C06:"; FJ_MaxString([eWires:13]fromCountry:9; 35); True:C214)  // Sending institution country
	If ([eWires:13]doTransferToBank:33)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	Else 
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":C08:"; FJ_MaxString(contactEntityName; 35); True:C214)  // Sending institution name. Ashnil Requeriment Ago 22/2020
	End if 
	
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C09:"; FJ_MaxString([Branches:70]City:4; 35); True:C214)
	
	// Receiving institution city/location
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Branches:70]CountryCode:12)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":C10:"; FJ_MaxString([Countries:62]CountryName:2; 35); True:C214)  // Receiving institution country
	
	
	// C11: Into/out of Fiji flag
	$rptInfo:=$rptInfo+":C11:I"+CRLF
	//Report branch where the customer is paid at.
End if 


$branch:=[Branches:70]BranchName:2
If ($branch="")
	$branch:="BRANCH NAME *MISSING*"
End if 

// Transaction Details
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D01:"; FJ_MaxString($branch; 20); True:C214)  // D01: Initiating branch name
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D03:"; FJ_MaxString([eWires:13]InvoiceNumber:29; 72); False:C215)  // Additional information

If ([Customers:3]isCompany:41)
	$rptInfo:=$rptInfo+":D04:N"+CRLF  // Message type: U: Customer-based EFTR, N: Institution-based EFTR
	
Else 
	$rptInfo:=$rptInfo+":D04:U"+CRLF  // Message type: U: Customer-based EFTR, N: Institution-based EFTR
End if 

$rptInfo:=$rptInfo+FJ_AddTagToReport(":D05:"; FJ_MaxString([eWires:13]eWireID:1; 16))  // D05 Transaction reference number
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D06:"; FJ_MaxString([Registers:10]RegisterID:1; 16); False:C215)  // D06 Related reference number (Register?)


If ([eWires:13]isSettled:23)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":D07:"; FJ_FormatDate([eWires:13]ReceiveDate:18; True:C214); True:C214)
Else 
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":D07:"; FJ_FormatDate([eWires:13]SendDate:2; True:C214); True:C214)
End if 

Case of 
	: ([eWires:13]fromCountryCode:111="NZ")
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":D08:"; "NZD"; True:C214)  // Currency Code
		
		
	: ([eWires:13]fromCountryCode:111="AU")
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":D08:"; "AUD"; True:C214)  // Currency Code
		
	Else 
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":D08:"; FJ_MaxString([eWires:13]Currency:12; 3); True:C214)  // Currency Code
		
End case 


READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[eWires:13]RegisterID:24)
C_REAL:C285($totNoFees)
$totNoFees:=[eWires:13]amountLocal:45-[Registers:10]totalFees:30
$tmp:=String:C10($totNoFees; "##############.00")

//$tmp:=Replace string(String([eWires]amountLocal-[Registers]totalFees);".";",")
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D09:"; FJ_MaxString(String:C10($tmp); 15); True:C214)  // Amount;
$rptInfo:=$rptInfo+FJ_AddTagToReport(":D10:"; FJ_MaxString([eWires:13]PurposeOfTransaction:65; 35; 4); False:C215)  //Details of payment


If ([Branches:70]LocationNumberFT:19="")
	$branchRegNum:="BRANCH REG#*MISSING* "+[Branches:70]BranchName:2
Else 
	$branchRegNum:=[Branches:70]LocationNumberFT:19+" "+[Branches:70]BranchName:2
End if 


$rptInfo:=$rptInfo+FJ_AddTagToReport(":D13:"; FJ_MaxString($branchRegNum; 20); True:C214)  // Initiating branch registration no

//$sendInst:=getKeyValue ("FJ.sending.instn.code";"0059")

//$sendInst:="EFTR INST# *MISSING*"
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":D26:";FJ_MaxString ($sendInst;20);True)  // D26 EFTR sending instn. Code 

//Hash reported this value should be 0.0


If ([eWires:13]isPaymentSent:20)  // Outgoing eWire 
	// $rptInfo:=$rptInfo+FJ_AddTagToReport (":D28:";string([Registers]DebitLocal;"############.00");True)  // ASK D28 FX Amount
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":D28:"; String:C10([eWires:13]ToAmount:14; "###########0.00"); True:C214)  // ASK D28 FX Amount
	
	If ([Customers:3]isCompany:41=False:C215)
		
		// E Ordering customer details
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([Customers:3]FullName:40; 70); True:C214)
		
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3); True:C214)
		
		//$rptInfo:=$rptInfo+FJ_AddTagToReport (":E20:";FJ_MaxString ($address;35;4);True)
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([Countries:62]CountryName:2; 35; 1); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E22:"; FJ_MaxString([Customers:3]WorkTel:12; 15; 1); False:C215)
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E23:"; FJ_MaxString($address; 35; 4); False:C215)
		
		READ ONLY:C145([Countries:62])
		QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[eWires:13]fromCountryCode:111)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E24:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E25:"; FJ_MaxString([Customers:3]HomeTel:6; 15; 1); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E33:"; FJ_MaxString([Customers:3]Occupation:21; 30; 1); False:C215)
		
	Else 
		// E Ordering customer details
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([eWires:13]SenderName:7; 70); True:C214)
		
		$address:=FJ_ContactAddress([eWires:13]senderAddress:96; [eWires:13]senderCity:98; [eWires:13]senderState:99; [eWires:13]senderPostalCode:100; [eWires:13]fromCountryCode:111)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3); True:C214)
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([eWires:13]fromCountry:9; 35); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E22:"; FJ_MaxString([eWires:13]senderPhone:97; 15); False:C215)
		
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":E33:"; FJ_MaxString([Customers:3]Occupation:21; 30; 1); False:C215)
		
		// F Ordering institution details
		
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":F02:"; FJ_MaxString([Customers:3]CompanyName:42+" "+$address; 35; 4); True:C214)
		
		
	End if 
	
Else 
	// Incoming eWire  
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":D28:"; String:C10(0; "0.00"); True:C214)  // ASK D28 FX Amount
	
	If (False:C215)
		// We don't know if a sender is a company
		$address:=FJ_ContactAddress([eWires:13]senderAddress:96; [eWires:13]senderCity:98; [eWires:13]senderState:99; [eWires:13]senderPostalCode:100; [eWires:13]fromCountryCode:111)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":F02:"; FJ_MaxString([eWires:13]SenderName:7+" "+$address; 35; 4); True:C214)
		
	End if 
	
	// E Ordering customer details
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E01:"; FJ_MaxString([eWires:13]SenderName:7; 70); True:C214)
	
	$address:=FJ_ContactAddress([eWires:13]senderAddress:96; [eWires:13]senderCity:98; [eWires:13]senderState:99; [eWires:13]senderPostalCode:100; [eWires:13]fromCountryCode:111)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E02:"; FJ_MaxString($address; 35; 3); True:C214)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E21:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E22:"; FJ_MaxString([eWires:13]senderPhone:97; 15); False:C215)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E23:"; FJ_MaxString($address; 35; 4); False:C215)
	
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[eWires:13]fromCountryCode:111)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E24:"; FJ_MaxString([Countries:62]CountryName:2; 35); False:C215)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":E25:"; FJ_MaxString([eWires:13]senderPhone:97; 15); False:C215)
	
End if 

// G: Sender’s correspondent details
//$rptInfo:=$rptInfo+FJ_AddTagToReport (":G01:";FJ_MaxString (reportingEntityID;24;1);True)  // Sender’s correspondent details. PUT MISSING FOR NOW. PUT THE NAME OF THE FIELDS
$rptInfo:=$rptInfo+FJ_AddTagToReport(":G01:"; FJ_MaxString("N/A"; 24; 1); True:C214)



// OR H02 Name and address 4*35x

// H: Receiver’s correspondent details

//$rptInfo:=$rptInfo+FJ_AddTagToReport (":H01:";FJ_MaxString (reportingEntityID;24;1);True)  // Receiver’s correspondent details. PUT MISSING FOR NOW. PUT THE NAME OF THE FIELDS
$rptInfo:=$rptInfo+FJ_AddTagToReport(":H01:"; FJ_MaxString("N/A"; 24; 1); True:C214)

// OR H02 Name and address 4*35x


If ([eWires:13]isPaymentSent:20)  // Outgoing eWire  
	
	If ([eWires:13]isBeneficiaryCompany:93)
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":K02:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92+" "+[eWires:13]BeneficiaryAddress:59; 35; 4); True:C214)
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L01:"; FJ_MaxString([eWires:13]BeneficiaryCity:60; 20); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L03:"; FJ_MaxString([eWires:13]BeneficiaryBankAccountNo:66; 34); True:C214)
		End if 
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92; 70); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString([eWires:13]BeneficiaryAddress:59; 35; 3); False:C215)
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L30:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 34); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L32:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92; 70); False:C215)
			QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L33:"; FJ_MaxString([Links:17]occupation:46; 30); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
			QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
			
		End if 
		
	Else 
		QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L01:"; FJ_MaxString([eWires:13]BeneficiaryCity:60; 20); False:C215)
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L03:"; FJ_MaxString([eWires:13]BeneficiaryBankAccountNo:66; 34); True:C214)
		End if 
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([Links:17]FullName:4; 70); True:C214)
		
		$address:=[Links:17]Address:19+" "+[Links:17]City:11+" "+[Links:17]Country:12
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString($address; 35; 3); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L23:"; FJ_MaxString($address; 35; 3); False:C215)
		READ ONLY:C145([Countries:62])
		QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[eWires:13]toCountryCode:112)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L24:"; FJ_MaxString([Countries:62]CountryName:2; 35; 4); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L25:"; FJ_MaxString([eWires:13]BeneficiaryCellPhone:61; 15); False:C215)
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L30:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 34); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L32:"; FJ_MaxString([eWires:13]BeneficiaryFullName:5; 35; 4); False:C215)
			
			If ([Customers:3]isCompany:41)
				$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
			Else 
				$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "S"; False:C215)
			End if 
			QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[eWires:13]BranchID:50)
			
			
		End if 
	End if 
	
Else 
	// Incoming eWire: The beneficiary info is in [Customers] Table
	READ ONLY:C145([Countries:62])
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Customers:3]CountryCode:113)
	
	If ([Customers:3]isCompany:41)
		
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":K02:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92+" "+[eWires:13]BeneficiaryAddress:59; 35; 4); True:C214)
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L01:"; FJ_MaxString([Branches:70]City:4; 20); False:C215)
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L03:"; FJ_MaxString([eWires:13]BeneficiaryBankAccountNo:66; 34); True:C214)
		End if 
		
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92; 70); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString([eWires:13]BeneficiaryAddress:59; 35; 3); False:C215)
		
		If ([eWires:13]doTransferToBank:33)  // Don't revamp becuase we need to keep the order
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L30:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 34); False:C215)
		End if 
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L32:"; FJ_MaxString([eWires:13]BeneficiaryCompanyName:92; 70); False:C215)
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
		End if 
		
		
	Else   // Is a Person
		
		$address:=FJ_ContactAddress([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]CountryCode:113)
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L01:"; FJ_MaxString([Branches:70]City:4; 20); False:C215)
		
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L03:"; FJ_MaxString([eWires:13]BeneficiaryBankAccountNo:66; 34); True:C214)
		End if 
		
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L04:"; FJ_MaxString([Customers:3]FullName:40; 70); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L05:"; FJ_MaxString($address; 35; 3); True:C214)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L23:"; FJ_MaxString($address; 35; 3); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L24:"; FJ_MaxString([Countries:62]CountryName:2; 35; 4); False:C215)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":L25:"; FJ_MaxString([Customers:3]HomeTel:6; 15); False:C215)
		
		
		If ([eWires:13]doTransferToBank:33)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L30:"; FJ_MaxString([eWires:13]BeneficiaryBankName:76; 34); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L32:"; FJ_MaxString([Customers:3]FullName:40; 35; 4); False:C215)
			$rptInfo:=$rptInfo+FJ_AddTagToReport(":L33:"; FJ_MaxString([Customers:3]Occupation:21; 30); False:C215)
			
			If ([Customers:3]isCompany:41)
				$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "C"; False:C215)
			Else 
				$rptInfo:=$rptInfo+FJ_AddTagToReport(":L36:"; "S"; False:C215)
			End if 
			
			
		End if 
	End if 
	
End if 



appendToFile($fileName; ->$rptInfo; False:C215)





