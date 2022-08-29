//%attributes = {}
// FT_generatePartB1
// Generate information about Part B1:  how the transaction was initiated

C_TEXT:C284($1; $fileName)
C_LONGINT:C283($2; $txIdx)

C_TEXT:C284($txDate; $txTime)
C_LONGINT:C283($partSeqNum)
C_REAL:C285($txReceivedAmount)
C_TEXT:C284($partId; $nigthDepDropInd; $postingDate; $txReceivedCurrency; $txCode; $txCodeOtherDesc)


Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$txIdx:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// -----------------------------------------------------------------------------------------------------------------
// Part B1: Information about how the transaction was initiated
// This part is for information about how the transaction was initiated (that is, where the money came from).
// -----------------------------------------------------------------------------------------------------------------


// Part ID
$partId:="B1"

// Part sequence number
$partSeqNum:=1

// Date of transaction
$txDate:=FT_GetStringDate(arrFTPostingDate{$txIdx})

// Time of transaction
$txTime:=FT_GetStringTime(arrFTPostingTime{$txIdx})

// Night deposit or quick drop indicator
$nigthDepDropInd:="0"

//  Date of posting 
$postingDate:=FT_GetStringDate(arrFTTxDate{$txIdx})

// Amount of transaction

$txReceivedAmount:=arrFTTxAmount{$txIdx}

// Transaction currency 
$txReceivedCurrency:=arrFTCurrencies{$txIdx}


// How the transaction was conducted: A-In-branch/Office/Store
$txCode:="A"

// Other description for code  'G' in $txCode. No apply
$txCodeOtherDesc:=" "



// Part B1: Information about how the transaction was initiated
FT_PartB1($fileName; $partId; $partSeqNum; $txDate; $txTime; $nigthDepDropInd; $postingDate; $txReceivedAmount; $txReceivedCurrency; $txCode; $txCodeOtherDesc)

