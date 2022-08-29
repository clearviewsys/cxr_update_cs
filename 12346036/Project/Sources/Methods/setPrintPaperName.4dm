//%attributes = {}
//setPrintPaperName (paperFormat)

C_TEXT:C284($paper; $1)
$paper:=$1

If ($paper#"")
	
	SET PRINT OPTION:C733(Paper option:K47:1; $paper)
	
End if 

