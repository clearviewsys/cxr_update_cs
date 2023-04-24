//%attributes = {}


// -------------------------------------------------------------------------------------------------------
// Method: FT_PartB2: Information about transaction disposition (where the money went)
//
// This part is for information about how the transaction was completed (i.e., where the money went). 
// If the disposition was on behalf of an entity (other than an individual), refer to Part F.
// If the disposition was on behalf of another individual, refer to Part G.
//
// Provide information about the individual conducting the transaction as explained in Part D or Part E. If the
// transaction had no other dispositions than a deposit to a business account, refer to Part E. 
//
// If the transaction involved a disposition that was not a deposit to a business account, refer to Part D.
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/09/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1)  // Report file path (include file name)   

C_TEXT:C284($2)  // Part ID (B2)
C_LONGINT:C283($3)  // Part sequence number
C_TEXT:C284($4)  // Disposition of funds

C_TEXT:C284($5)  // Other description
C_TEXT:C284($6)  // Life insurance policy number
C_REAL:C285($7)  // Amount of disposition

C_TEXT:C284($8)  // Disposition currency
C_TEXT:C284($9)  // Other institution name and number or other person or entity
C_TEXT:C284($10)  // Other person or entity account or policy number
C_TEXT:C284($11)  // On behalf of indicator



C_BLOB:C604($content)
C_TEXT:C284($partId; $dFunds; $otherDesc; $lifeInsurance; $dCurrency; $otherInst; $otherPerson; $onBehalfInd; $partSeqNum; $dAmount)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------

// Disposition of funds
$dFunds:=FT_StringFormat($4; 1)
TEXT TO BLOB:C554($dFunds; $content; UTF8 text without length:K22:17; *)

// Other description
$otherDesc:=FT_StringFormat($5; 20)
TEXT TO BLOB:C554($otherDesc; $content; UTF8 text without length:K22:17; *)

// Life insurance policy number
$lifeInsurance:=FT_StringFormat($6; 30)
TEXT TO BLOB:C554($lifeInsurance; $content; UTF8 text without length:K22:17; *)

// Amount of disposition
If ($8="TOM")
	$dAmount:=FT_NumberFormat($7*10; 2; 15; "0"; "RJ")
	$dCurrency:="IRR"
Else 
	$dCurrency:=$8
	$dAmount:=FT_NumberFormat($7; 2; 15; "0"; "RJ")
End if 

TEXT TO BLOB:C554($dAmount; $content; UTF8 text without length:K22:17; *)


// Amount of disposition
//$dAmount:=FT_NumberFormat ($7;2;15;"0";"RJ")
//TEXT TO BLOB($dAmount;$content;UTF8 text without length;*)

// Disposition currency
$dCurrency:=FT_StringFormat($dCurrency; 3)
TEXT TO BLOB:C554($dCurrency; $content; UTF8 text without length:K22:17; *)

// Other institution name and number or other person or entity
$otherInst:=FT_StringFormat($9; 35)
TEXT TO BLOB:C554($otherInst; $content; UTF8 text without length:K22:17; *)

// Other person or entity account or policy number
$otherPerson:=FT_StringFormat($10; 30)
TEXT TO BLOB:C554($otherPerson; $content; UTF8 text without length:K22:17; *)

// On behalf of indicator
$onBehalfInd:=FT_StringFormat($11; 1)
TEXT TO BLOB:C554($onBehalfInd; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)
