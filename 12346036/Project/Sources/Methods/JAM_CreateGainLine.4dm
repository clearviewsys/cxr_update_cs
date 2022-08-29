//%attributes = {}
// JAM_CreateGainLine
// Create the Acumulated Gain Diff line for a GL Report
// Author: JA, 02/24/2020

C_TEXT:C284($1; $fileName)
C_LONGINT:C283($2; $lineNum)
C_TEXT:C284($3; $sep)
C_BLOB:C604($blob)

$sep:=""

Case of 
	: (Count parameters:C259=3)
		$fileName:=$1
		$lineNum:=$2
		$sep:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($recordType; $appCode; $debitCreditCode; $txDate; $acctNumber; $costCenterUser; $txAmount)
C_TEXT:C284($txAmountForCurr; $comment; $lineNumStr; $recordType; $debitCreditCode; $lineNumStr)
C_TEXT:C284($currCode; $ourRate; $txDesc; $costCenter; $credit; $txAmount)

$recordType:="D"+$sep
$appCode:="40"+$sep
$debitCreditCode:="6"+$sep  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate(fromDate)+$sep

$acctNumber:=getKeyValue("JAM.Equalization.Exchange.Acct"; String:C10(8110012))
$acctNumber:=FT_NumberFormat(Num:C11($acctNumber); 0; 13)+$sep
$costCenterUser:="00003"+$sep

$txAmount:=FT_NumberFormat(JAM_SumUnrealizedGains; 2; 17)+$sep
$txAmountForCurr:=FT_NumberFormat(0; 2; 17)+$sep
JAM_totalDebitsAmnt:=JAM_totalDebitsAmnt+JAM_SumUnrealizedGains
$comment:="ACUM. EXCH DIFF ON "+String:C10(fromDate)


$currCode:=FT_NumberFormat(0; 0; 3)+$sep
$ourRate:=FT_NumberFormat(0; 7; 15)+$sep
$txDesc:=FT_StringFormat($comment; 30)+$sep
$lineNumStr:=FT_NumberFormat($lineNum; 0; 5)

// Save the line into a file
TEXT TO BLOB:C554($recordType; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($appCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($debitCreditCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDate; $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($acctNumber; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($costCenterUser; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmount); $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmountForCurr); $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($currCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($ourRate); $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDesc; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($lineNumStr; $blob; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $blob)
JAM_totalDebits:=JAM_totalDebits+1
CLEAR VARIABLE:C89($blob)