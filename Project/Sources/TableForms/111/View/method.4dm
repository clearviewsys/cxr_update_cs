handleViewFormMethod

If (Form event code:C388=On Load:K2:1)
	var $entity : cs:C1710.SanctionCheckLogEntity
	
	$entity:=Create entity selection:C1512([SanctionCheckLog:111])[Selected record number:C246([SanctionCheckLog:111])-1]
	
	C_TEXT:C284($version)
	$version:=sl_getSanctionSourceForRecord($entity)
	
	Case of 
		: ($version=sl_useCXBlackListJSON)
			If (Form event code:C388=On Load:K2:1)
				FORM GOTO PAGE:C247(2)
				Form:C1466.CXRBlacklist:=sl_combineCXRBlacklistResults(\
					New collection:C1472(\
					ds:C1482.SanctionCheckLog.query("UUID = :1"; [SanctionCheckLog:111]UUID:14)\
					.first()))
				sl_handleSanctionListMatches(Form:C1466.CXRBlacklist)
			End if 
			sl_handleReviewFormEvent(Form:C1466.CXRBlacklist)
		: ($version=sl_useOpenSanctions)
			Form:C1466.OpenSanctions:=sl_formatOpenSanctionResult($entity)
			FORM GOTO PAGE:C247(3)
		: ($version=sl_useLocalBlacklist)
			Form:C1466.localBlacklist:=sl_formatLocalBlacklistResult($entity)
			FORM GOTO PAGE:C247(4)
		: ($version=sl_useKYC2020)
			Form:C1466.KYC2020:=sl_formatKYC2020Result($entity)
			FORM GOTO PAGE:C247(5)
	End case 
End if 