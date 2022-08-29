//%attributes = {}
// create4DMethodFromFile
// this method loads a text file and replaces all 4D tags and writes back the result
// this method should be called something else such as replace4DTagsInSource


C_BLOB:C604($Blob_x)
C_BLOB:C604($blob_out)
C_TEXT:C284($inputText_t)
C_TEXT:C284($outputText_t)
C_TEXT:C284($document)
C_TEXT:C284($sourceFolder; $sourceFile; $destinationFolder; $destinationFile)
$sourceFolder:=Select folder:C670
$destinationFolder:=$sourceFolder

$sourceFile:="source.txt"
$destinationFile:="generated.txt"


C_TEXT:C284(vTableName)
C_TEXT:C284(vFieldName)

vTableName:=Table name:C256(->[Customers:3])
vFieldName:=Field name:C257(->[Customers:3]CustomerID:1)
ALL RECORDS:C47([Currencies:6])

DOCUMENT TO BLOB:C525($sourceFolder+$sourceFile; $Blob_x)
$inputText_t:=BLOB to text:C555($Blob_x; UTF8 text without length:K22:17)
PROCESS 4D TAGS:C816($inputText_t; $outputText_t)
TEXT TO BLOB:C554($outputText_t; $blob_out; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($destinationFolder+$destinationFile; $blob_out)

CLEAR VARIABLE:C89(vTableName)
CLEAR VARIABLE:C89(vFieldName)
