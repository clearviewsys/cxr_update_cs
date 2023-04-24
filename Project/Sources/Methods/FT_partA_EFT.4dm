//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_PartA_EFT : 
// Information about where the transaction took place
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/2/2019
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)      
C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Report sequence number
C_TEXT:C284($4)  // Reporting entity report reference number

C_TEXT:C284($5)  // Action code
C_TIME:C306($6)  // Time of transaction
C_DATE:C307($7)  // Date of transaction
C_REAL:C285($8)  // Amount of tx
C_TEXT:C284($9)  // 24-hour rule indicator
C_TEXT:C284($10)  // Currency Code
C_REAL:C285($11)  // Exchage Rate

C_TEXT:C284($partId; $repSeqNum; $repEntityRefNum; $actionCode; $timeTx; $dateTx; $amountTx; $rule24Indicator)
C_TEXT:C284($txCurrency; $exchangeRate; $tmp)

C_BLOB:C604($content)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Report sequence number
$repSeqNum:=FT_NumberFormat($3; 0; 5; "0"; "RJ")
TEXT TO BLOB:C554($repSeqNum; $content; UTF8 text without length:K22:17; *)

// Reporting entity report reference number
$repEntityRefNum:=FT_StringFormat($4; 20; " "; "LJ")
TEXT TO BLOB:C554($repEntityRefNum; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Action code

$actionCode:=FT_StringFormat($5; 1)
TEXT TO BLOB:C554($actionCode; $content; UTF8 text without length:K22:17; *)

// Time of Transaction

$timeTx:=FT_GetStringTime($6)
TEXT TO BLOB:C554($timeTx; $content; UTF8 text without length:K22:17; *)

// DTransaction Date

$dateTx:=FT_GetStringDate($7)
TEXT TO BLOB:C554($dateTx; $content; UTF8 text without length:K22:17; *)


If ($10=getKeyValue("TOMCode"; "TOM"))
	$amountTx:=FT_NumberFormat($8*10; 2; 15; "0"; "RJ")  // 1 Toman = 10 IRR
	TEXT TO BLOB:C554($amountTx; $content; UTF8 text without length:K22:17; *)
Else 
	$amountTx:=FT_NumberFormat($8; 2; 15; "0"; "RJ")
	TEXT TO BLOB:C554($amountTx; $content; UTF8 text without length:K22:17; *)
End if 

// 24-hour rule indicator

$rule24Indicator:=FT_StringFormat($9; 1; "0"; "LJ")
TEXT TO BLOB:C554($rule24Indicator; $content; UTF8 text without length:K22:17; *)

READ ONLY:C145([Currencies:6])
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1="IRR")

If ($10=getKeyValue("TOMCode"; "TOM"))
	$txCurrency:="IRR"  // Iranian Real
	TEXT TO BLOB:C554($txCurrency; $content; UTF8 text without length:K22:17; *)
	
	// Tx Exchange rate. Inverse Rate for some customers. Default YES
	
	If (getKeyValue("FT.UseInverseRate"; "YES")="YES")  // Use inverse rate instead of the direct rate
		$exchangeRate:=String:C10(calcSafeDivide(1; ($11/10)))  // Calculate the Inverse Rate
	Else 
		$exchangeRate:=String:C10($11/10)
	End if 
	
	$exchangeRate:=FT_StringFormat($exchangeRate; 12; "0"; "RJ")
	
	TEXT TO BLOB:C554($exchangeRate; $content; UTF8 text without length:K22:17; *)
	
Else 
	$txCurrency:=$10
	TEXT TO BLOB:C554($txCurrency; $content; UTF8 text without length:K22:17; *)
	
	// Tx Exchange rate
	$exchangeRate:=String:C10($11)
	$exchangeRate:=FT_StringFormat($exchangeRate; 12; "0"; "RJ")
	TEXT TO BLOB:C554($exchangeRate; $content; UTF8 text without length:K22:17; *)
	
End if 

//C_TEXT($text)
//If (([eWires]amountLocal<[ServerPrefs]twoIDsLimit) & ($rule24Indicator="0"))
//$tmp:="IR2020"+Substring($repEntityRefNum;7)
//$text:=BLOB to text($content;UTF8 text without length)
//$text:=Replace string($text;$repEntityRefNum;$tmp)
//TEXT TO BLOB($text;$content;UTF8 text without length)
//End if 


AppendBlobToFile($1; $content)






