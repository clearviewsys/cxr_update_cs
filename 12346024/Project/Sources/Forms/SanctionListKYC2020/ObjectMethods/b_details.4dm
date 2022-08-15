Case of 
	: (Form event code:C388=On Clicked:K2:4)
		var $detail : Object
		$detail:=New object:C1471("list"; Form:C1466.selectedList["List Name"]; \
			"detail"; sl_getKYC2020RecordDetails(Form:C1466.kyc2020.details; \
			Form:C1466.selectedList["Search Reference ID"]; \
			Date:C102(Form:C1466.kyc2020.date)=Current date:C33(*); Form:C1466.kyc2020.logId))
		var $winRef : Integer
		$winRef:=Open form window:C675("SanctionListKYC2020Details")
		DIALOG:C40("SanctionListKYC2020Details"; $detail)
		CLOSE WINDOW:C154($winRef)
End case 
