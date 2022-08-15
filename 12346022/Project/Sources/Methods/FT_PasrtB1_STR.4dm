//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_PasrtB1_STR: Information about transaction.
// This part is for information about the large cash transaction.
// If the large cash transaction was two or more cash transactions of less than 
// $10,000 made within 24 consecutive hours of each other that total $10,000 or more, 
// include those in the same report. 
//
// If there are more than 99 such transactions that make up a large cash transaction, 
// you will have to use more than one report.
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/10/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)   

C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number
C_TEXT:C284($4)  // Date of transaction

C_TEXT:C284($5)  // Time of transaction
C_TEXT:C284($6)  // Night deposit or quick drop indicator
C_TEXT:C284($7)  // Date of posting 

C_REAL:C285($8)  // Amount of transaction
C_TEXT:C284($9)  //Transaction currency 
C_TEXT:C284($10)  // How the transaction was conducted
C_TEXT:C284($11)  // Other description for code  'G' in $txCode

C_BLOB:C604($content)
C_TEXT:C284($partId; $partSeqNum; $txDate; $txTime; $nigthDepDropInd; $postingDate; $dAmount; $txCurrency; $txCode; $txCodeOtherDesc)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Date of transaction
$txDate:=FT_StringFormat($4; 8)
TEXT TO BLOB:C554($txDate; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Time of transaction
$txTime:=FT_StringFormat($5; 6)
TEXT TO BLOB:C554($txTime; $content; UTF8 text without length:K22:17; *)

// Night deposit or quick drop indicator
$nigthDepDropInd:=FT_StringFormat($6; 1)
TEXT TO BLOB:C554($nigthDepDropInd; $content; UTF8 text without length:K22:17; *)

//  Date of posting 
$postingDate:=FT_StringFormat($7; 8)
TEXT TO BLOB:C554($postingDate; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------


// Amount of disposition
//$dAmount:=FT_StringFormat (String($8);15;"0";"RJ")  // TODO: is there cash txs in Toman? ask Tiran
$dAmount:=FT_NumberFormat($8; 2; 15; "0"; "RJ")
TEXT TO BLOB:C554($dAmount; $content; UTF8 text without length:K22:17; *)

// Transaction currency 
$txCurrency:=FT_StringFormat($9; 3)
TEXT TO BLOB:C554($txCurrency; $content; UTF8 text without length:K22:17; *)

// How the transaction was conducted
$txCode:=FT_StringFormat($10; 1)
TEXT TO BLOB:C554($txCode; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Other description for code  'G' in $txCode
$txCodeOtherDesc:=FT_StringFormat($11; 20)
TEXT TO BLOB:C554($txCodeOtherDesc; $content; UTF8 text without length:K22:17; *)

//$cr:=Char(CR ASCII code)
//TEXT TO BLOB($cr;$content;UTF8 text without length;*)

AppendBlobToFile($1; $content)






