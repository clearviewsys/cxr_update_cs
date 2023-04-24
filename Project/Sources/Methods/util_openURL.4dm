//%attributes = {}
#DECLARE($websiteParam : Text)

var $website : Text
Case of 
	: (Count parameters:C259=0)
		$website:="www.google.com"
	: (Count parameters:C259=1)
		$website:=$websiteParam
End case 

var $form : Object
$form:=New object:C1471("website"; $website)

C_LONGINT:C283($winref)
$winref:=Open form window:C675("InternalBrowser")
DIALOG:C40("InternalBrowser"; $form)