//%attributes = {}

// CreateDetailsForSelling
// Create 3 lines of the BOJ accounting system when transaction is Sell
// Author: JA


C_OBJECT:C1216($1; $register; $users; $u)
C_LONGINT:C283($2; $lineNum)
C_TEXT:C284($3; $fileName)
C_TEXT:C284($4; $separator; $msg)

$separator:=""


Case of 
		
	: (Count parameters:C259=3)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$separator:=""
		
	: (Count parameters:C259=4)
		$register:=$1
		$lineNum:=$2
		$fileName:=$3
		$separator:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($user)
C_BLOB:C604($blob)
C_REAL:C285($debit)

C_TEXT:C284($recordType; $appCode; $debitCreditCode; $txDate; $acctNumber; $costCenterUser; $txAmount; $txAmountForCurr)
C_TEXT:C284($comment; $currCode; $ourRate; $txDesc; $lineNumStr)

// ----------------------------------------------------------------------
// Create Line 1
// ----------------------------------------------------------------------

$recordType:="D"+$separator
$appCode:="40"+$separator  // 20= C/A  40=GL
$debitCreditCode:="0"+$separator  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate($register.RegisterDate)+$separator
$user:=ds:C1482.Users.query("UserName = :1"; $register.CreatedByUserID).first()
//$users:=ds.Users.query("UserID = :1";"QSUSE101")  // TODO:
//If ($user.length>0)

If ($user#Null:C1517)
	//If ($user.length>0)
	// $u:=$users[0]
	$acctNumber:=FT_NumberFormat(Num:C11($user.accountNumber); 0; 13)+$separator
	$costCenterUser:=FT_NumberFormat(Num:C11($user.costCenter); 0; 5)+$separator
Else 
	// If User is Administrator, Designer or Support must be '9999*' becuase these user are not allowed to create transactions
	invalidTxs:=True:C214
	$acctNumber:=FT_NumberFormat(9999999999999; 0; 13)+$separator
	$costCenterUser:=FT_NumberFormat(99999; 0; 5)+$separator  // costCenter=0 Because $appCode = 20
	
	$msg:="Invoice # :"+$register.InvoiceNumber+" was created by an unauthorized user"
	UTIL_Log("JAM_GL_report"; $msg)
	
End if 
$txAmount:=FT_NumberFormat($register.Credit; 2; 17)+$separator
$txAmountForCurr:=FT_NumberFormat($register.CreditLocal; 2; 17)+$separator
$comment:="FX SELL "+$register.Currency+" "+String:C10($register.Credit)+$separator
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



// ----------------------------------------------------------------------
// Create Line 2
// ----------------------------------------------------------------------

$recordType:="D"+$separator
$appCode:="20"+$separator  // 20= C/A  40=GL
$debitCreditCode:="6"+$separator  // 0-Credit 6-Debit

$txDate:=FT_GetStringDate($register.RegisterDate)+$separator
//$users:=ds.Users.query("UserID = :1";$register.CreatedByUserID)
//$users:=ds.Users.query("UserID = :1";"QSUSE101")  // TODO:

//$acctNumber:=FT_NumberFormat (999999;0;13)+$separator
//$costCenter:=FT_NumberFormat (0;0;5)+$separator  // costCenter=0 Because $appCode = 20

//QUERY([Accounts];[Accounts]AccountID=[Registers]AccountID)
//QUERY([Accounts];[Accounts]CustomerID=[Registers]CustomerID)
C_OBJECT:C1216($account)
$account:=ds:C1482.Accounts.query("CustomerID = :1"; $register.CustomerID).first()

If ($account#Null:C1517)
	$acctNumber:=FT_NumberFormat(Num:C11($account.AccountCode); 0; 13)+$separator
Else 
	// If User is Administrator, Designer or Support must be '9999*' becuase these user are not allowed to create transactions
	invalidTxs:=True:C214
	$acctNumber:=FT_NumberFormat(9999999999999; 0; 13)+$separator
	$costCenterUser:=FT_NumberFormat(99999; 0; 5)+$separator  // costCenter=0 Because $appCode = 20
	
	$msg:="Invoice # :"+$register.InvoiceNumber+" was created by an unauthorized user"
	UTIL_Log("JAM_GL_report"; $msg)
	
End if 

$debit:=$register.Credit*$register.SpotRate
$debit:=Round:C94($debit; 2)
$txAmount:=FT_NumberFormat($debit; 2; 17)+$separator
$txAmountForCurr:=FT_NumberFormat(0; 2; 17)+$separator
JAM_totalDebitsAmnt:=JAM_totalDebitsAmnt+$debit

//$currCode:=FT_StringFormat (getBOJCurrencyCode ($register.Currency);3;" ")
$currCode:=FT_NumberFormat(0; 0; 3)+$separator

//$ourRate:=JAM_ReplaceDecimalPoint (FT_NumberFormat ($register.OurRate;7;15))
$ourRate:=JAM_ReplaceDecimalPoint(FT_NumberFormat(0; 7; 15))+$separator

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
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmount); $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint($txAmountForCurr); $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554($currCode; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($ourRate; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($txDesc; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($lineNumStr; $blob; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $blob)
JAM_totalDebits:=JAM_totalDebits+1
CLEAR VARIABLE:C89($blob)

// ----------------------------------------------------------------------
// Create Line 3
// ----------------------------------------------------------------------
JAM_SumUnrealizedGains:=JAM_SumUnrealizedGains+Num:C11($register.UnrealizedGain)

// TODO: Delete next if lines


