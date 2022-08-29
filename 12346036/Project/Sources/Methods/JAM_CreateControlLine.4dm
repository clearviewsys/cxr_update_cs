//%attributes = {}
// JAM_CreateControlLine ($fileName; $separator)
// Create the Report Control Line for BOJ GL Report
// Author: JA


C_TEXT:C284($1; $fileName)
C_TEXT:C284($2; $sep)
C_BLOB:C604($blob)

Case of 
		
	: (Count parameters:C259=1)
		
		$fileName:=$1
		$sep:=""
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$sep:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Create Control Line
TEXT TO BLOB:C554("C"+$sep; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(FT_NumberFormat(JAM_totalDebits; 0; 5)+$sep; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint(FT_NumberFormat(JAM_totalDebitsAmnt; 2; 19))+$sep; $blob; UTF8 text without length:K22:17; *)

TEXT TO BLOB:C554(FT_NumberFormat(JAM_totalCredits; 0; 5)+$sep; $blob; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554(JAM_ReplaceDecimalPoint(FT_NumberFormat(JAM_totalCreditsAmnt; 2; 19))+$sep; $blob; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $blob)