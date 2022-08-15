//%attributes = {"publishedWeb":true}
// return true if there is a checkError

C_BOOLEAN:C305($0)
//If (◊isWarningDisabled)
//$0:=False
//Else 
If (<>CheckWarnings#"")
	$0:=True:C214
Else 
	$0:=False:C215
End if 
//End if 