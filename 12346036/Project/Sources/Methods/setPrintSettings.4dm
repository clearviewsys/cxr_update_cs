//%attributes = {}
// setPrintSettings(printerName ; orientation:bool ; scale:int ; pageFormat)

C_TEXT:C284($printerName; $1)
C_BOOLEAN:C305($isPortrait; $2)
C_LONGINT:C283($scale; $3)
C_TEXT:C284($pageFormat; $4)

$printerName:=$1
$isPortrait:=$2
$scale:=$3
$pageFormat:=$4

SET CURRENT PRINTER:C787($printerName)
setPrintOrientation($isPortrait)
setPrintScale($scale)
setPrintPaperName($pageFormat)
