//Author: Wai-Kin
sl_handleReviewFormEvent

If (Form event code:C388=On Load:K2:1)
	Form:C1466.sanctionLists:=New object:C1471("values"; New collection:C1472; "index"; 0)
	Form:C1466.kyc2020Result:=New object:C1471
	Form:C1466.showList:=0
	var $changePage : Boolean
	If (Form:C1466.lists.length#0)
		Form:C1466.sanctionLists.values.push("CXRBlackList")
	End if 
	If (Form:C1466.kyc2020.length#0)
		var $list : Object
		For each ($list; Form:C1466.kyc2020)
			Form:C1466.sanctionLists.values.push($list.shortName)
		End for each 
	End if 
	
	sl_handleSanctionLogPages(On Data Change:K2:15)
End if 