//%attributes = {}
//Method: isDesignerEnabled
//Purpose: Checks if the Designer account has been disabled due to too many attempts
//Returns: True if the account is enabled, false if disabled

C_BOOLEAN:C305($0; $1; $ret; $showAlert)

Case of 
	: (Count parameters:C259=0)
		$showAlert:=True:C214
	: (Count parameters:C259=1)
		$showAlert:=$1
End case 

$ret:=True:C214

If ((arrUserNames{arrUserNames}="Designer") & (getKeyValue("auth.designerEnabled")="False"))
	$ret:=False:C215
	If ($showAlert)
		myAlert("Designer account has been disabled due to too many attempts")
	End if 
End if 

$0:=$ret