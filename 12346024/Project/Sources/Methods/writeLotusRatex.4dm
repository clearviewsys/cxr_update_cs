//%attributes = {}
C_TEXT:C284($filePath)

$filePath:=getFilePathByID("RATEX"; getCurrentMachineName)

If ($filePath="")
Else 
	saveTextToFile(makeLotusRatexString; $filePath)
End if 

