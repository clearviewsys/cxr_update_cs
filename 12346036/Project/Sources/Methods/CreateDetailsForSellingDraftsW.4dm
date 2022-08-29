//%attributes = {}
// CreateDetailsForSellingDraftsW
// Create Debit and Credit lines of the BOJ accounting system when transaction is Sell (Drafs and Wires)
// Author: JA


C_OBJECT:C1216($1; $register; $users; $u)
C_LONGINT:C283($2; $lineNum)
C_TEXT:C284($3; $fileName)
C_POINTER:C301($4; $seqPtr)
C_TEXT:C284($5; $separator)


Case of 
		
	: (Count parameters:C259=4)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$seqPtr:=$4
		$separator:=""
		
	: (Count parameters:C259=5)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$seqPtr:=$4
		$separator:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($recordType; $appCode; $debitCreditCode; $txDate; $acctNumber; $costCenterUser; $txAmount)
C_TEXT:C284($txAmountForCurr; $comment; $lineNumStr; $recordType; $debitCreditCode; $lineNumStr)
C_TEXT:C284($currCode; $ourRate; $txDesc; $costCenter; $credit; $txAmount)
C_BLOB:C604($blob)


// ----------------------------------------------------------------------
// Create Line 1
// ----------------------------------------------------------------------

$recordType:="D"+$separator
$appCode:="40"+$separator  // 20= C/A  40=GL
$debitCreditCode:="0"+$separator  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate($register.RegisterDate)+$separator
JAM_GetCurrencyAccountAndCC($register; ->$acctNumber; ->$costCenterUser)

$acctNumber:=FT_StringFormat($acctNumber; 13; "0"; "RJ")+$separator
$costCenterUser:=FT_StringFormat($costCenterUser; 5; "0"; "RJ")+$separator


$txAmount:=FT_NumberFormat($register.Credit; 2; 17)+$separator
$txAmountForCurr:=FT_NumberFormat($register.CreditLocal; 2; 17)+$separator
//$txDesc:=FT_StringFormat ($register.Comments;30)
Case of 
	: ($register.InternalTableNumber=1)  // Checks
		$comment:="Sale of Draft "+$register.customer.FullName+$separator
	: ($register.InternalTableNumber=8)  // Wires
		$comment:="ASD PENSION DEPOSIT"
	Else 
		$comment:=$register.Comments
		$seqPtr->:=$seqPtr->+1
End case 


JAM_totalCreditsAmnt:=JAM_totalCreditsAmnt+$register.CreditLocal

$currCode:=FT_StringFormat(getBOJCurrencyCode($register.Currency); 3; " ")+$separator

$ourRate:=JAM_ReplaceDecimalPoint(FT_NumberFormat($register.OurRate; 7; 15))+$separator


//$txDesc:=FT_StringFormat ($register.Comments;30)
$txDesc:=FT_StringFormat($comment; 30)+$separator

$lineNumStr:=FT_NumberFormat($lineNum; 0; 5)

// Save the line into a file
TEXT TO BLOB:C554($recordType; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($appCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($debitCreditCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDate; $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($acctNumber; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($costCenterUser; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmountForCurr); $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmount); $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($currCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($ourRate; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDesc; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($lineNumStr; $blob; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $blob)
JAM_totalCredits:=JAM_totalCredits+1
CLEAR VARIABLE:C89($blob)


JAM_SumUnrealizedGains:=JAM_SumUnrealizedGains+Num:C11($register.UnrealizedGain)
