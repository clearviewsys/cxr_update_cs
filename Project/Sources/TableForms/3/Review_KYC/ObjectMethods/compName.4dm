applyFocusRect
If (Form event code:C388=On Data Change:K2:15)
	clearPictureField(->latestCheckStatus2)
	//sl_handleCompanyNameCompliance
	sl_handleCustomerScreening(sl_CustomerCompany+sl_ForInputBox)
End if 