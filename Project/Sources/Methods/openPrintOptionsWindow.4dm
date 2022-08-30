//%attributes = {}
C_OBJECT:C1216($1; $s_obj; $form)
C_BOOLEAN:C305($isDoNotAskAgain)
C_LONGINT:C283($winRef)

Case of 
	: (Count parameters:C259=1)
		$s_obj:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Use ($s_obj)
	$winRef:=Open form window:C675("printingOptions"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	
	$form:=New object:C1471
	$form.isDisplaySignature:=Bool:C1537(getKeyValue("print.format.isDisplaySignature"; "false"))
	$form.isDisplayAddress:=Bool:C1537(getKeyValue("print.format.isDisplayAddress"; "false"))
	$form.isDisplayPhone:=Bool:C1537(getKeyValue("print.format.isDisplayPhone"; "false"))
	$form.isDisplayPurposeOfTransaction:=Bool:C1537(getKeyValue("print.format.isDisplayPurposeOfTransaction"; "false"))
	$form.isDisplaySourceOfFunds:=Bool:C1537(getKeyValue("print.format.isDisplaySourceOfFunds"; "false"))
	$form.isDoNotAskAgain:=Bool:C1537($isDoNotAskAgain)
	
	DIALOG:C40("printingOptions"; $form)
	CLOSE WINDOW:C154($winRef)
	
	// Mark process as done to be checked
	$s_obj.isDone:=True:C214
End use 