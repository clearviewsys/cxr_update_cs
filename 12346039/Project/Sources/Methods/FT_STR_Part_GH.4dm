//%attributes = {}

// FT_STR_Part_GH


C_TEXT:C284($1; $fileName)  // Report file path (include file name)      
C_TEXT:C284($2; $partId)  // Part ID
C_TEXT:C284($3; $notes)
C_BLOB:C604($content)


Case of 
		
	: (Count parameters:C259=3)
		$fileName:=$1
		$partID:=$2
		$notes:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($j)
C_TEXT:C284($partSeqNum; $chunck)

// Part ID
$partId:=FT_StringFormat($2; 2)
TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)

$j:=1

// Part sequence number
$partSeqNum:=FT_NumberFormat($j; 0; 2; "0"; "RJ")
TEXT TO BLOB:C554($partSeqNum; $content; UTF8 text without length:K22:17; *)

// Description of suspicious activity
$chunck:=FT_StringFormat($notes; 400)
TEXT TO BLOB:C554($chunck; $content; UTF8 text without length:K22:17; *)


AppendBlobToFile($fileName; $content)

