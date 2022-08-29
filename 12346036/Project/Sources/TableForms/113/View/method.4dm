handleViewFormMethod

If ([SanctionLists:113]UseServer:12="KYC2020")
	var $itemPos; $itemRef : Integer
	var $itemText : Text
	$itemPos:=utils_getValueFromObject([SanctionLists:113]Details:13; 1; \
		"Details"; "KYC2020"; "responseType")
	GET LIST ITEM:C378(*; "KYC2020ResponseType"; $itemPos; $itemRef; $itemText)
	Form:C1466.responseType:=$itemText
	FORM GOTO PAGE:C247(2)
Else 
	FORM GOTO PAGE:C247(1)
End if 