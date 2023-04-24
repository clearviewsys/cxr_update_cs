//%attributes = {}


// -------------------------------------------------------------------------------------------------------
// Method: FT_GeneratePartC1_EFTO: 
// This part is for information about the reporting entity sending the payment instructions.
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $2; $partID)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$partID:="C1"
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$partID:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)
C_TEXT:C284($tmp; $certNumber; $locNumber)

// Part ID
TEXT TO BLOB:C554($partID; $content; UTF8 text without length:K22:17; *)

// CertificationNumber (Main Form ID)
$certNumber:=FT_NumberFormat(Num:C11(reportingEntityCertificateID); 0; 7; "0"; "RJ")
TEXT TO BLOB:C554($certNumber; $content; UTF8 text without length:K22:17; *)

// Location Number (Main Form Location Number
C_TEXT:C284($locNumber)
//$locNumber:=FT_StringFormat ([Agents]LocationNumber;15)

If ([Branches:70]LocationNumberFT:19="")
	$locNumber:=FT_StringFormat(getKeyValue("FT.MainBranchLocNumber"; " "); 15)
Else 
	$locNumber:=FT_StringFormat([Branches:70]LocationNumberFT:19; 15)
End if 
TEXT TO BLOB:C554($locNumber; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $content)




