//%attributes = {}
// FT_GeneratePartB2: Generates information about the disposition

C_TEXT:C284($1; $fileName; $2; $txDispositionCurrency)
C_REAL:C285($3; $txDispositionAmount)
C_LONGINT:C283($4; $partSeqNum)

Case of 
	: (Count parameters:C259=3)
		$fileName:=$1
		$txDispositionCurrency:=$2
		$txDispositionAmount:=$3
		$partSeqNum:=1
		
	: (Count parameters:C259=4)
		$fileName:=$1
		$txDispositionCurrency:=$2
		$txDispositionAmount:=$3
		$partSeqNum:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// -----------------------------------------------------------------------------------------------------------
// Part B2: Information about the disposition
// This part is for information about how the transaction was completed(that is, where the money went)
// -----------------------------------------------------------------------------------------------------------
C_TEXT:C284($partId; $dFunds; $otherDesc; $lifeInsurance; $otherInst; $otherPerson; $onBehalfInd)
// Part ID
$partId:="B2"

// Part sequence number
//$partSeqNum:=1

// Enter the appropriate code to indicate what happened to the funds involved in the transaction. 
// If the selections provided do not cover this particular disposition, indicate “Other” and provide details in field B8A.

// Code-Description
// A-Deposit to an account
// B-Outgoing electronic funds transfer
// C-Conducted currency exchange
// D-Purchase of casino chips
// E-Purchase of bank draft
// F-Purchase of money order
// G-Purchase of traveller's cheques
// H-Life insurance policy purchase or deposit(provide number in field B8B)
// I-Securities purchase or deposit
// J-Real estate purchase or deposit
// K-Cash out
// L-Other
// M-Purchase diamonds
// N-Purchase jewellery
// O-Purchase precious metals
// P-Purchase stones (excl. diamonds)


// Disposition of funds
$dFunds:="C"
$otherInst:=" "
Case of 
	: ([Registers:10]InternalTableNumber:17=1)  // Checks
		// E-Purchase of bank draft
		$dFunds:="C"
		QUERY:C277([Cheques:1]; [Cheques:1]ChequeID:1=[Registers:10]InternalRecordID:18)
		$otherInst:=[Cheques:1]PayTo:15
		$txDispositionCurrency:=[Cheques:1]Currency:9
		$txDispositionAmount:=[Cheques:1]Amount:8
		
	: ([Registers:10]InternalTableNumber:17=13)  // Ewires
		
		READ ONLY:C145([eWires:13])
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)
		
		If ([eWires:13]isPaymentSent:20)
			$dFunds:="B"  //   //B-Outgoing electronic funds transfer
		End if 
		
	: ([Registers:10]InternalTableNumber:17=Table:C252(->[CashTransactions:36]))
		// TODO: Create a key Value to ask if we are going to classify the Disposition, else =C
		$dFunds:="K"  // K-Cash out, C-Conducted currency exchange
		$otherInst:=" "
		//$txDispositionCurrency:=[Registers]baseCURR
		//$txDispositionAmount:=[Registers]DebitLocal
		
		//$txDispositionAmount:=$txDispositionAmount
		
		READ ONLY:C145([Wires:8])
		//QUERY([Wires];[Wires]=[Registers]InternalRecordID)
		READ ONLY:C145([CashTransactions:36])
		QUERY:C277([CashTransactions:36]; [CashTransactions:36]CashTransactionID:1=[Registers:10]InternalRecordID:18)
		READ ONLY:C145([Accounts:9])
		QUERY:C277([Accounts:9]; [Accounts:9]AccountCode:4=[CashTransactions:36]CashAccountID:9)
		
		
	Else 
		//  // C-Conducted currency exchange,
		$dFunds:="C"
End case 




// Other description
$otherDesc:=" "

// Life insurance policy number
$lifeInsurance:=" "

// Amount of disposition
// Enter the amount of funds involved in the disposition, including two decimal pla
// This field is mandatory. If it is not included, the report will be rejected.

// $txDispositionAmount

// Disposition currency
// Enter the currency of the disposition, even if it was in Canadian funds. Refer to the currency code table in the technical documentation area of the Publications page on FINTRAC's Web site.
// This field is mandatory. If it is not included, the report will be rejected.

// $txDispositionCurrency


// Other institution name and number or other person or entity
//$otherInst:=" "

// Other person or entity account or policy number
$otherPerson:=" "

// On behalf of indicator
$onBehalfInd:=FT_OnBehalfOfIndicator

// Part B2: Information about the disposition (where the money went)
FT_PartB2($fileName; $partId; $partSeqNum; $dFunds; $otherDesc; $lifeInsurance; $txDispositionAmount; $txDispositionCurrency; $otherInst; $otherPerson; $onBehalfInd)

