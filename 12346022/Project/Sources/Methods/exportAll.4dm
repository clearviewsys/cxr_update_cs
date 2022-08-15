//%attributes = {}

C_LONGINT:C283($tableNum)

For ($tableNum; 1; Get last table number:C254)
	myAlert("exporting for "+Table name:C256($tableNum))
	executeMethodName("export"+Table name:C256($tableNum))
End for 