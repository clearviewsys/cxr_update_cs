//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:28:06
// ----------------------------------------------------
// Method: BKP_XML_StartDocument
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($1; $0; $tiDocRef)
C_TEXT:C284($tNamespace)

$tiDocRef:=$1
$tNamespace:="http://www.4d.com/namespace/reserved/2004/backup"

SAX SET XML DECLARATION:C858($tiDocRef; "UTF-8")

ARRAY TEXT:C222($aAttribNames; 1)
$aAttribNames{1}:="xmlns"

ARRAY TEXT:C222($aAttribValues; 1)
$aAttribValues{1}:=$tNamespace

SAX OPEN XML ELEMENT ARRAYS:C921($tiDocRef; "Preferences4D"; $aAttribNames; $aAttribValues)
SAX OPEN XML ELEMENT:C853($tiDocRef; "Backup")

$0:=$tiDocRef