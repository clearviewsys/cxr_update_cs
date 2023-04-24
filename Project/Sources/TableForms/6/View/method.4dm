handleViewForm

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11) | (Form event code:C388=On Close Detail:K2:24) | (Form event code:C388=On Open Detail:K2:23))
	handleTabCurrenciesView
End if 

If (Form event code:C388=On Unload:K2:2)
	CLEAR SET:C117("SetBuy")
	CLEAR SET:C117("SetSell")
	CLEAR SET:C117("SetBoth")
End if 
setArrowState(->vArrowPict; [Currencies:6]pctChange:42)  // arrowPict is the name of the picture button

hideObjectsOnTrue(Not:C34([Currencies:6]hasFailedUpdate:37); "failedUpdate")
