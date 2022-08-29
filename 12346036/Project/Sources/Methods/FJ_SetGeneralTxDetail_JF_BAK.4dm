//%attributes = {}
// ------------------------------------------------------------------------------
// FJ_SetGeneralTxDetail ($fileName;$totTxAmount;$txDate;$debitLC)
// Generate the FIJI FIU Tx Detail
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $rptInfo; $purpose; $address)
C_REAL:C285($2; $totTxAmount; $4; $debitLC)
C_DATE:C307($3; $txDate)

C_BOOLEAN:C305($m20)
C_TEXT:C284($n01; $n04)
C_BOOLEAN:C305($hasEwire)
C_OBJECT:C1216($registers; $reg)


Case of 
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$totTxAmount:=$2
		$txDate:=$3
		$debitLC:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
READ ONLY:C145([eWires:13])
$rptInfo:=""
$rptInfo:=$rptInfo+"M01:"+[Branches:70]BranchName:2+CRLF

// TODO: Add The Branch Registration Number to the [Branches] Table
If ([Branches:70]LocationNumberFT:19#"")
	rptInfo:=$rptInfo+"M03:"+[Branches:70]LocationNumberFT:19+CRLF
End if 


If ([Branches:70]Address:3#"")
	$rptInfo:=$rptInfo+":M04:"+[Branches:70]Address:3+CRLF
End if 


// TODO: Transaction Description: mandatory
$purpose:=[Invoices:5]AMLPurposeOfTransaction:85
//[Invoices]TransactionType
If ($purpose="")
	$purpose:="TX Description NOT REPORTED"
End if 

$rptInfo:=$rptInfo+":M08:"+FJ_GetValue(Substring:C12($purpose; 1; 40); "Transaction Description")+CRLF
$rptInfo:=$rptInfo+":M09:"+FJ_FormatDate($txDate; True:C214)+CRLF
// TODO:
$rptInfo:=$rptInfo+":M10:"+String:C10($debitLC; "#########0.00")+CRLF

If ([Branches:70]BranchPhone:5#"")
	$rptInfo:=$rptInfo+":M15:"+FJ_GetValue([Branches:70]BranchPhone:5)+CRLF
End if 
If ([Branches:70]Address:3#"")
	$rptInfo:=$rptInfo+":M16:"+FJ_GetValue([Branches:70]Address:3)+CRLF
End if 

If ([Branches:70]CountryCode:12#"")
	$rptInfo:=$rptInfo+":M17:"+FJ_GetValue([Branches:70]CountryCode:12)+CRLF
End if 

$rptInfo:=$rptInfo+":M18:NC"+CRLF

// M19:Cash Value. The values for each of the cash types.
$rptInfo:=$rptInfo+":M19:"+String:C10($debitLC; "#########0.00")+CRLF
//[Invoices]eWireID
// M20: Direction of CASH PAID. I: Into the financial institution. O: Out of the financial institution

$registers:=ds:C1482.Registers.query("InvoiceNumber = :1 AND CreditLocal > 0"; [Invoices:5]InvoiceID:1)  // "Cash" Out
$m20:=False:C215

$n01:=$n01+"=N01:"
$n04:=$n04+"=N04:"

For each ($reg; $registers)
	
	If (Not:C34($m20))  // Create the mM20 tag only once
		
		If (($reg.InternalTableNumber=Table:C252(->[eWires:13])) | ($reg.InternalTableNumber=Table:C252(->[Cheques:1])))
			$rptInfo:=$rptInfo+":M20:I"+CRLF
		Else 
			$rptInfo:=$rptInfo+":M20:O"+CRLF
		End if 
		$m20:=True:C214
		
	End if 
	
	$hasEwire:=False:C215
	QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$reg.eWireID)
	
	If (Records in selection:C76([eWires:13])>0)
		$hasEwire:=True:C214
		
		$n01:=$n01+FJ_GetValue($reg.Currency; "Foreign Currency Code")+CRLF
		$n04:=$n04+"=N04:"+FJ_GetValue(String:C10($reg.Credit; "#########0.00"); "Foreign Currency Value")+CRLF
	Else 
		$n01:=$n01+"=N01:"+FJ_GetValue([Registers:10]Currency:19; "Foreign Currency Code")+CRLF
		If ([Invoices:5]fromCurrency:3=[Registers:10]Currency:19)
			$n04:=$n04+"=N04:"+FJ_GetValue(String:C10(0; "#########0.00"); "Foreign Currency Value")+CRLF
		Else 
			$n04:=$n04+"=N04:"+FJ_GetValue(String:C10([Registers:10]Debit:8; "#########0.00"); "Foreign Currency Value")+CRLF
		End if 
		
	End if 
End for each 
$rptInfo:=$rptInfo+$n01
$rptInfo:=$rptInfo+$n04


//End if 



// 5.2.4 Party Details

// P01: Party role code
// TODO: Ask for 
// P Person conducting the transaction (Agent), i.e. the person(s) at the counter.
// Q Person on whose behalf transaction is being conducted (Owner)
// W Other person mentioned on a CTR.
// R Recipient person who receives the Cash


// For each =P01

//M P01 Party role code 3*1a
//M P03 Name 2*70x
//MI P04 Business address 4*35x
//MI P08 Business Country 15x
//MI P11 Business/occupation description 30x
//MI P12 Date of birth ccyymmdd
//MI P14 Account number 5*34x
//MI P15 Account type code 5*1a
//MI P16 Account title 5*2*70x
//MI P17 Identification number 5*20x
//MI P18 Identification issuer 5*30x
//MI P19 Identification type code 5*1a
//M P22 Resident of Fiji 1a (Y/N)
//MI P26 Postal Address 4*35x
////MI P27 Business Phone 15x
//MI P28 Residential address 4*35x
//MI P29 Residential country 15x
////MI P30 Residential phone 15x
//MI P32 Temporary Fiji address 4*35x
//MI P33 Temporary Fiji phone 15x
//MI P34 Account Holder Flag 1a
//MI P35 Account Branch 4*35x
//MI P36 Account FI 4*35x


$rptInfo:=$rptInfo+"=P01:P"+CRLF

// P03: Name
$rptInfo:=$rptInfo+":P03:"+FJ_GetValue([Customers:3]FullName:40; "Customer Full Name")+CRLF


// P04: Business address

$rptInfo:=$rptInfo+":P04:"+FJ_GetValue([Customers:3]Address:7; "Customer Address")+CRLF
$rptInfo:=$rptInfo+FJ_GetValue([Customers:3]City:8; "Customer City")+CRLF

If ([Customers:3]CountryCode:113#"")
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[Customers:3]CountryCode:113)
	$rptInfo:=$rptInfo+FJ_GetValue([Countries:62]CountryName:2; "Country Name")+CRLF
	
	// P08: Business country
	$rptInfo:=$rptInfo+":P08:"+FJ_GetValue([Countries:62]CountryName:2; "Business Country Name")+CRLF
End if 

// P11: Business/occupation description (30x)

If ([Customers:3]isCompany:41)
	
	If ([Customers:3]BusinessType:62#"")
		$rptInfo:=$rptInfo+":P11:"+FJ_GetValue([Customers:3]BusinessType:62; "Business occupation Code")+CRLF
	End if 
	
	// P12: INcorporation Date ccyymmdd
	If ([Customers:3]BusinessIncorporationDate:29#!00-00-00!)
		$rptInfo:=$rptInfo+":P12:"+FJ_FormatDate([Customers:3]BusinessIncorporationDate:29; True:C214)+CRLF
	End if 
	
	
	If ([Customers:3]CountryOfResidenceCode:114="FJ")
		$rptInfo:=$rptInfo+":P22:Y"+CRLF
	Else 
		$rptInfo:=$rptInfo+":P22:N"+CRLF
	End if 
	
	If ([Customers:3]HomeTel:6#"")
		$rptInfo:=$rptInfo+":P27:"+FJ_GetValue([Customers:3]HomeTel:6; "Business Phone  Number Code")+CRLF
	End if 
	
Else 
	
	If ([Customers:3]Occupation:21#"")
		$rptInfo:=$rptInfo+":P11:"+FJ_GetValue([Customers:3]Occupation:21; "Occupation description")+CRLF
	End if 
	
	// P12: Date of birth ccyymmdd
	$rptInfo:=$rptInfo+":P12:"+FJ_FormatDate([Customers:3]DOB:5; True:C214)+CRLF
	
	If ([Customers:3]PictureID_Number:69#"")
		$rptInfo:=$rptInfo+":P17:"+FJ_GetValue([Customers:3]PictureID_Number:69; "Identification Number")+CRLF
	End if 
	
	If ([Customers:3]PictureID_Authority:116#"")
		$rptInfo:=$rptInfo+":P18:"+FJ_GetValue([Customers:3]PictureID_Authority:116; "Identification Issuer")+CRLF
	End if 
	
	// P19 Identification Type code
	If ([Customers:3]PictureID_GovernmentCode:20#"")
		$rptInfo:=$rptInfo+":P19:"+FJ_GetValue([Customers:3]PictureID_GovernmentCode:20; "Identification Type code")+CRLF
	End if 
	
	If ([Customers:3]CountryOfResidenceCode:114="FJ")
		$rptInfo:=$rptInfo+":P22:Y"+CRLF
	Else 
		$rptInfo:=$rptInfo+":P22:N"+CRLF
	End if 
	
	
	If ([Customers:3]WorkTel:12#"")
		$rptInfo:=$rptInfo+":P27:"+FJ_GetValue([Customers:3]WorkTel:12; "Business Phone  Number Code")+CRLF
	End if 
	
	
	If ([Customers:3]HomeTel:6#"")
		$rptInfo:=$rptInfo+":P30:"+FJ_GetValue([Customers:3]HomeTel:6; "Residential Phone  Number Code")+CRLF
	End if 
	
End if 


// TODO: Ask? No for Cash
// 5.2.5.1. Content Q01 Instrument type code
// Code to indicate type of instrument involved.
// Value Meaning
// B Bonds, Securities, promissory notes, shares
// C Cheque
// D Draft
// L Telegraphic transfer of cash/currency
// M Money Order
// P Postal Notes
// T Travellers’ Cheque
// Related to 5.2.5.2. Notes L Telegraphic transfer of cash/currency

$rptInfo:=$rptInfo+"=Q01:L"+CRLF

If ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
	READ ONLY:C145([eWires:13])
	//QUERY([eWires];[eWires]eWireID=[Registers]InternalRecordID)
	
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":Q02:"; FJ_MaxString([eWires:13]SenderName:7; 70; 2); True:C214)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":Q03:"; FJ_MaxString([eWires:13]BeneficiaryFullName:5; 70; 2); True:C214)
	
Else 
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Registers:10]CustomerID:5)
	$rptInfo:=$rptInfo+FJ_AddTagToReport(":Q02:"; FJ_MaxString([Customers:3]FullName:40; 70; 2); True:C214)
	
	If (Records in selection:C76([eWires:13])>0)
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":Q03:"; FJ_MaxString([eWires:13]BeneficiaryFullName:5; 70; 2); True:C214)
	Else 
		$rptInfo:=$rptInfo+FJ_AddTagToReport(":Q03:"; FJ_MaxString([Customers:3]FullName:40; 70; 2); True:C214)
	End if 
	
End if 

If (Records in selection:C76([eWires:13])>0)
	$rptInfo:=$rptInfo+":V02:Ewire: "+[eWires:13]eWireID:1+" Invoice: "+[Invoices:5]InvoiceID:1+CRLF
Else 
	$rptInfo:=$rptInfo+":V02:Invoice: "+[Invoices:5]InvoiceID:1+CRLF
End if 

appendToFile($fileName; ->$rptInfo; False:C215)




