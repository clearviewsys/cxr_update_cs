//%attributes = {}
C_TEXT:C284($1)
C_BOOLEAN:C305($0)

If (($1="true") | ($1="checked") | ($1="yes"))
	$0:=True:C214
Else 
	$0:=False:C215
End if 