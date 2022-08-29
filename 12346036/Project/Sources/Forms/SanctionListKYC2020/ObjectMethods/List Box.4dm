Case of 
	: (Form event code:C388=On Data Change:K2:15)
		var $enable : Boolean
		$enable:=sl_getKYC2020RecordDetails(Form:C1466.kyc2020.details; \
			Form:C1466.selectedList["Search Reference ID"]; \
			Date:C102(Form:C1466.kyc2020.date)=Current date:C33(*); Form:C1466.kyc2020.logId)#Null:C1517
		OBJECT SET ENABLED:C1123(*; "b_details"; $enable)
End case 