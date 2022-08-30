//%attributes = {}
// setPrintOrientation ({true:portrait; false:landscape})

C_BOOLEAN:C305($isPortrait; $1)
$isPortrait:=$1

If ($isPortrait)
	SET PRINT OPTION:C733(2; 1)  // Portrait
Else 
	SET PRINT OPTION:C733(2; 2)  // Landscape
End if 