//%attributes = {}


// ---------------------------------------------------------------------------------------------------
// Method: FT_PartC: 
// Account information (if applicable)
// This part is for information about the account if the transaction was in fact related to an account.
//
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/10/2015
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $repFileParh)  // Report file path (include file name)   


C_TEXT:C284($2)  // Part ID
C_LONGINT:C283($3)  // Part sequence number
C_TEXT:C284($4)  // Branch or transit number where account held

C_TEXT:C284($5)  // Account number
C_TEXT:C284($6)  // Account type
C_TEXT:C284($7)  // Account type Other description for code  'D' in $acctType

C_TEXT:C284($8)  // Account currency
C_TEXT:C284($9)  // Account holder 1
C_TEXT:C284($10)  // Account holder 2
C_TEXT:C284($11)  // Account holder 3

C_BLOB:C604($content)
C_TEXT:C284($partId; $partSeqNum; $branchNum; $acctNum; $acctType; $txAcctOtherDesc; $acctCurrency; $acctHolder1; $acctHolder2; $acctHolder3)
// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

// Part sequence number
$partSeqNum:=FT_NumberFormat($3; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Branch or transit number where account held
$branchNum:=FT_StringFormat($4; 12)
TEXT TO BLOB:C554($branchNum; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------

// Account number
$acctNum:=FT_StringFormat(FT_Clean($5); 30)
TEXT TO BLOB:C554($acctNum; $content; UTF8 text without length:K22:17; *)

// Account type
$acctType:=FT_StringFormat(FT_Clean($6); 1)
TEXT TO BLOB:C554($acctType; $content; UTF8 text without length:K22:17; *)

// Other description: Account type Other description for code  'D' in $acctType
$txAcctOtherDesc:=FT_StringFormat(FT_Clean($7); 20)
TEXT TO BLOB:C554($txAcctOtherDesc; $content; UTF8 text without length:K22:17; *)

// -----------------------------------------------------------

// Account currency


$acctCurrency:=FT_StringFormat($8; 3)
If ($acctCurrency="TOM")
	$acctCurrency:="IRR"
End if 

TEXT TO BLOB:C554($acctCurrency; $content; UTF8 text without length:K22:17; *)

// Account holder 1
$acctHolder1:=FT_StringFormat(FT_Clean($9); 45)
TEXT TO BLOB:C554($acctHolder1; $content; UTF8 text without length:K22:17; *)

// Account holder 2
$acctHolder2:=FT_StringFormat(FT_Clean($10); 45)
TEXT TO BLOB:C554($acctHolder2; $content; UTF8 text without length:K22:17; *)

// Account holder 3
$acctHolder3:=FT_StringFormat(FT_Clean($11); 45)
TEXT TO BLOB:C554($acctHolder3; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($1; $content)







