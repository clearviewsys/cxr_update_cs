C_TEXT:C284($template)

$template:="chequeTemplateA.txt"

If (Form event code:C388=On Printing Detail:K2:18)
	readChequeCoordinates($template)
End if 