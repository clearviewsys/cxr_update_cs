//%attributes = {}


// -------------------------------------------------------------------------------------------------------
// Method: FT_GeneratePartE1_EFTI: 
// This part is for information about the reporting entity sending the payment instructions.
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$tmp:="E1"
	: (Count parameters:C259=2)
		$fileName:=$1
		$tmp:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)
C_TEXT:C284($fileName; $tmp; $certNumber; $locNumber)

// Part ID
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

// CertificationNumber (Main Form ID)
$certNumber:=FT_NumberFormat(Num:C11(reportingEntityCertificateID); 0; 7; "0"; "RJ")
TEXT TO BLOB:C554($certNumber; $content; UTF8 text without length:K22:17; *)

// Location Number
If ([Branches:70]LocationNumberFT:19="")
	$locNumber:=FT_StringFormat(getKeyValue("FT.MainBranchLocNumber"; " "); 15)
Else 
	$locNumber:=FT_StringFormat([Branches:70]LocationNumberFT:19; 15)
End if 
TEXT TO BLOB:C554($locNumber; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($fileName; $content)



