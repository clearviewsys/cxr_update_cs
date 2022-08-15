HandleEntryFormMethod
Case of 
	: (Form event code:C388=On Load:K2:1)
		var $version : Text
		$version:=sl_getSanctionSourceForRecord(\
			Create entity selection:C1512([SanctionLists:113])[Selected record number:C246([SanctionLists:113])]\
			)
		Case of 
			: ($version="v2")
				Form:C1466.type:="CXBlacklist"
				FORM GOTO PAGE:C247(1)
			: ($version="v1")
				Form:C1466.type:="CXBlacklist"
				FORM GOTO PAGE:C247(1)
			: ($version="KYC2020")
				Form:C1466.type:=[SanctionLists:113]UseServer:12
				FORM GOTO PAGE:C247(2)
		End case 
		If ([SanctionLists:113]Details:13=Null:C1517)
			[SanctionLists:113]Details:13:=New object:C1471
			[SanctionLists:113]Details:13.KYC2020:=New object:C1471
			[SanctionLists:113]UseServer:12:="CXBlackList"
		End if 
		Form:C1466.KYC2020:=New object:C1471
		var $mustMatch : Text
		$mustMatch:=utils_getValueFromObject([SanctionCheckLog:111]Details:18; "true"; "KYC2020"; "mustMatch")
		If ($mustMatch="true")
			Form:C1466.KYC2020.exact:=True:C214
			Form:C1466.KYC2020.fuzzy:=False:C215
			Form:C1466.KYC2020.name:=0
			Form:C1466.KYC2020.address:=0
			Form:C1466.KYC2020.id:=0
		Else 
			Form:C1466.KYC2020.exact:=False:C215
			Form:C1466.KYC2020.fuzzy:=True:C214
			Form:C1466.KYC2020.name:=0
			Form:C1466.KYC2020.address:=0
			Form:C1466.KYC2020.id:=0
			var $value : Text
			For each ($value; Split string:C1554($mustMatch; "|"))
				Case of 
					: ($value="1")
						Form:C1466.KYC2020.name:=1
					: ($value="2")
						Form:C1466.KYC2020.address:=1
					: ($value="3")
						Form:C1466.KYC2020.id:=1
				End case 
			End for each 
		End if 
		sl_handleKYC2020MatchTypes(Form event code:C388; False:C215)
		
		If (OB Is defined:C1231([SanctionLists:113]Details:13.KYC2020; "responseType"))
			C_LONGINT:C283($ref; $list)
			C_TEXT:C284($text)
			$list:=Load list:C383("KYC2020ResponseType")
			
			GET LIST ITEM:C378($list; [SanctionLists:113]Details:13.KYC2020.responseType; $ref; $text)
			Form:C1466.responseType:=$text
		Else 
			
		End if 
		[SanctionLists:113]Details:13.KYC2020.excludeTerms:=0
		[SanctionLists:113]Details:13.KYC2020.filterThreshold:=0
End case 



Case of 
	: ([SanctionLists:113]UseServer:12="KYC2020")
		FORM GOTO PAGE:C247(2)
	Else 
		FORM GOTO PAGE:C247(1)
End case 