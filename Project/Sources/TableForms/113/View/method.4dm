handleViewFormMethod

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "txt_auto1"; Not:C34(<>doCheckSanctionLists))
		OBJECT SET VISIBLE:C603(*; "txt_auto2"; Not:C34(<>doCheckSanctionLists))
		OBJECT SET VISIBLE:C603(*; "but_manual"; <>doCheckSanctionLists)
End case 

var $useServer : Text
$useServer:=sl_getSanctionSourceForRecord(\
ds:C1482.SanctionLists.query("ShortName = :1"; [SanctionLists:113]ShortName:2).first()\
)

Case of 
	: ($useServer=sl_useKYC2020)
		var $itemPos; $itemRef : Integer
		var $itemText : Text
		$itemPos:=utils_getValueFromObject([SanctionLists:113]Details:13; 1; \
			"KYC2020"; "responseType")
		var $list : Integer
		$list:=Load list:C383("KYC2020ResponseType")
		GET LIST ITEM:C378($list; $itemPos; $itemRef; $itemText)
		Form:C1466.responseType:=$itemText
		FORM GOTO PAGE:C247(2)
		
	: ($useServer=sl_useOpenSanctions)
		FORM GOTO PAGE:C247(3)
		
	: ($useServer=sl_useLocalBlacklist)
		FORM GOTO PAGE:C247(4)
		
	Else 
		FORM GOTO PAGE:C247(1)
End case 