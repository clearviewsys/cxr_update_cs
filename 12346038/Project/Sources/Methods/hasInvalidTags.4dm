//%attributes = {}
C_TEXT:C284($1; $fileContent)
C_BLOB:C604($blob)

DOCUMENT TO BLOB:C525($1; $blob)
$fileContent:=BLOB to text:C555($blob; UTF8 text without length:K22:17)

$0:=(Position:C15("*MISSING*"; $fileContent)>0)

