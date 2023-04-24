HandleEntryFormMethod

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// MARK: Sync [SantionList]isEnabled and [SanctionLists]automaticFlags
		sl_fixScreenSettingMismatch
		
		// MARK: Setup details
		If ([SanctionLists:113]Details:13=Null:C1517)
			[SanctionLists:113]Details:13:=New object:C1471
			[SanctionLists:113]Details:13.KYC2020:=New object:C1471
			[SanctionLists:113]Details:13.OpenSanctions:=New object:C1471
			[SanctionLists:113]UseServer:12:="CXBlackList"
		End if 
		
		// MARK: Setup Page 2 (KYC2020)
		Form:C1466.KYC2020:=New object:C1471
		var $mustMatch : Text
		If (Not:C34(OB Is defined:C1231([SanctionLists:113]Details:13.KYC2020; "exact")))
			[SanctionLists:113]Details:13.KYC2020.exact:=True:C214
		End if 
		
		
		If (Not:C34(OB Is defined:C1231([SanctionLists:113]Details:13.KYC2020; "mustMatch")))
			[SanctionLists:113]Details:13.KYC2020.mustMatch:=""
		End if 
		$mustMatch:=[SanctionLists:113]Details:13.KYC2020.mustMatch
		Form:C1466.KYC2020.mustMatchName:=Match regex:C1019("1"; $mustMatch)
		Form:C1466.KYC2020.mustMatchAddress:=Match regex:C1019("2"; $mustMatch)
		Form:C1466.KYC2020.mustMatchID:=Match regex:C1019("3"; $mustMatch)
		
		If (Not:C34(OB Is defined:C1231([SanctionLists:113]Details:13.KYC2020; "recordType")))
			[SanctionLists:113]Details:13.KYC2020.recordType:=1
		End if 
		Form:C1466.KYC2020.forEntities:=[SanctionLists:113]Details:13.KYC2020.recordType#3
		Form:C1466.KYC2020.forPersons:=[SanctionLists:113]Details:13.KYC2020.recordType#2
		
		If (OB Is defined:C1231([SanctionLists:113]Details:13.KYC2020; "responseType"))
			C_LONGINT:C283($ref; $list)
			C_TEXT:C284($text)
			$list:=Load list:C383("KYC2020ResponseType")
			
			GET LIST ITEM:C378($list; [SanctionLists:113]Details:13.KYC2020.responseType; $ref; $text)
			Form:C1466.responseType:=$text
		End if 
		
		// MARK: Setup Page 3 (Open Sacntions)
		Form:C1466.OpenSanctions:=New object:C1471
		Form:C1466.OpenSanctions.fuzzy:=0
		
		
		
		OBJECT SET VISIBLE:C603(*; "txt_auto1"; Not:C34(<>doCheckSanctionLists))
		OBJECT SET VISIBLE:C603(*; "txt_auto2"; Not:C34(<>doCheckSanctionLists))
		OBJECT SET VISIBLE:C603(*; "but_manual"; <>doCheckSanctionLists)
End case 

// MARK:- Changes pages base on [SanctionLists]UseServer
Case of 
	: ([SanctionLists:113]UseServer:12=sl_useKYC2020)
		FORM GOTO PAGE:C247(2)
	: ([SanctionLists:113]UseServer:12=sl_useOpenSanctions)
		FORM GOTO PAGE:C247(3)
	: ([SanctionLists:113]UseServer:12=sl_useLocalBlacklist)
		FORM GOTO PAGE:C247(4)
	Else 
		FORM GOTO PAGE:C247(1)
End case 

sl_handleScreeningTableCheckbox