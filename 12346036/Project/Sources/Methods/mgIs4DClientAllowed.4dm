//%attributes = {}
C_BOOLEAN:C305($0)

$0:=False:C215

If (getKeyValue("mg."+getBranchID+".isAllowed")="true")
	$0:=True:C214
End if 
