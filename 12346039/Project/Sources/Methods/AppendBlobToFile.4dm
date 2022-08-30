//%attributes = {}


// ------------------------------------------------------------------------------
// Method: AppendBlobToFile: 
// Append text to blob file
// 
// Parameters: 
//   $1: File Name
//   $2: Blob content to add
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 01/12/2016
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $content)  // File name
C_BLOB:C604($2)  // BLOB Content
$content:=BLOB to text:C555($2; UTF8 text without length:K22:17)

$content:=$content+CRLF
$fileName:=$1

C_TIME:C306($vhDoc)
$vhDoc:=Append document:C265($fileName)
SEND PACKET:C103($vhDoc; $content)

// Close the document
CLOSE DOCUMENT:C267($vhDoc)


