//%attributes = {}
// CreateDetailsForBuying
// Create 3 lines of the BOJ accounting system when transaction is Buy
// Author: JA

C_OBJECT:C1216($1; $register; $users; $u)
C_LONGINT:C283($2; $lineNum)
C_TEXT:C284($3; $fileName)
C_TEXT:C284($4; $sep)
C_REAL:C285($credit)
$sep:=""

Case of 
		
	: (Count parameters:C259=3)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$sep:=""
		
	: (Count parameters:C259=4)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$sep:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// ----------------------------------------------------------------------
// Create Line 1
// ----------------------------------------------------------------------
C_TEXT:C284($recordType; $appCode; $debitCreditCode; $txDate; $acctNumber; $costCenterUser; $txAmount)
C_TEXT:C284($txAmountForCurr; $comment; $lineNumStr; $recordType; $debitCreditCode; $lineNumStr)
C_TEXT:C284($currCode; $ourRate; $txDesc; $costCenter; $txAmount)

C_BLOB:C604($blob)
$recordType:="D"+$sep
$appCode:="40"+$sep  // 20= C/A  40=GL
$debitCreditCode:="6"+$sep  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate($register.RegisterDate)+$sep
$users:=ds:C1482.Users.query("UserName = :1"; $register.CreatedByUserID)
//$users:=ds.Users.query("UserName = :1";"QSUSE101")  // TODO:

If ($users.length=1)
	// $u:=$users[0]
	
	For each ($u; $users)  // Must be only one
		$acctNumber:=FT_NumberFormat(Num:C11($u.accountNumber); 0; 13)+$sep
		$costCenterUser:=FT_NumberFormat(Num:C11($u.costCenter); 0; 5)+$sep
	End for each 
	
Else 
	// User is Administrator, Designer or Support
	$acctNumber:=FT_NumberFormat(9999999999999; 0; 13)+$sep
	$costCenterUser:=FT_NumberFormat(99999; 0; 5)+$sep  // costCenter=0 Because $appCode = 20
End if 

$txAmount:=FT_NumberFormat($register.Debit; 2; 17)+$sep
$txAmountForCurr:=FT_NumberFormat($register.DebitLocal; 2; 17)+$sep
$comment:="FX PUR "+$register.Currency+" "+String:C10($register.Debit)+$sep
JAM_totalDebitsAmnt:=JAM_totalDebitsAmnt+$register.DebitLocal


$currCode:=FT_StringFormat(getBOJCurrencyCode($register.Currency); 3; " ")+$sep

$ourRate:=JAM_ReplaceDecimalPoint(FT_NumberFormat($register.OurRate; 7; 15))+$sep

//$txDesc:=FT_StringFormat ($register.Comments;30)
$txDesc:=FT_StringFormat($comment; 30)+$sep

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
JAM_totalDebits:=JAM_totalDebits+1
CLEAR VARIABLE:C89($blob)



// ----------------------------------------------------------------------
// Create Line 2
// ----------------------------------------------------------------------

$recordType:="D"+$sep
$appCode:="20"+$sep  // 20= C/A  40=GL
$debitCreditCode:="0"+$sep  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate($register.RegisterDate)+$sep

$acctNumber:=FT_NumberFormat(999999; 0; 13)+$sep
$costCenter:=FT_NumberFormat(0; 0; 5)+$sep  // costCenter=0 Because $appCode = 20

$credit:=$register.Debit*$register.SpotRate
$credit:=Round:C94($credit; 2)
$txAmount:=FT_NumberFormat($credit; 2; 17)+$sep
$txAmountForCurr:=FT_NumberFormat(0; 2; 17)+$sep
JAM_totalCreditsAmnt:=JAM_totalCreditsAmnt+$credit


//$currCode:=FT_StringFormat (getBOJCurrencyCode ($register.Currency);3;" ")
$currCode:=FT_NumberFormat(0; 0; 3)+$sep

//$ourRate:=JAM_ReplaceDecimalPoint (FT_NumberFormat ($register.OurRate;7;15))
$ourRate:=JAM_ReplaceDecimalPoint(FT_NumberFormat(0; 7; 15))+$sep

//$txDesc:=FT_StringFormat ($register.Comments;30)
$txDesc:=FT_StringFormat($comment; 30)+$sep

$lineNumStr:=FT_NumberFormat($lineNum; 0; 5)

// Save the line into a file
TEXT TO BLOB:C554($recordType; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($appCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($debitCreditCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDate; $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($acctNumber; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($costCenter; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmount); $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmountForCurr); $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($currCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($ourRate; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDesc; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($lineNumStr; $blob; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $blob)
JAM_totalCredits:=JAM_totalCredits+1
CLEAR VARIABLE:C89($blob)

// ----------------------------------------------------------------------
// Create Line 3
// ----------------------------------------------------------------------

JAM_SumUnrealizedGains:=JAM_SumUnrealizedGains+Num:C11($register.UnrealizedGain)

