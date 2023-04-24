// Author: Wai-Kin
Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.options:=cs:C1710.SanctionScreeningOptions.new()
		
		If (OB Is defined:C1231(Form:C1466; "testing"))
			OBJECT SET VISIBLE:C603(*; "check_interface"; Form:C1466.testing)
			OBJECT SET VISIBLE:C603(*; "check_worker"; Form:C1466.testing)
			OBJECT SET VISIBLE:C603(*; "check_confirm"; Form:C1466.testing)
			Form:C1466.options:=cs:C1710.SanctionScreeningOptions.new()
			Form:C1466.options.useWorker:=Form:C1466.testing
		Else 
			Form:C1466.options.useWorker:=True:C214
		End if 
		Form:C1466.options.signalName:="signal"
		Form:C1466.options.handleScreenResult:="sl_handleDemoListResult"
		Form:C1466.results:=New collection:C1472
		
		Form:C1466.isEntity:=False:C215
		Form:C1466.result:=""
		Form:C1466.showInterface:=True:C214
		Form:C1466.alwaysShow:=1
		Form:C1466.names:=New object:C1471(\
			"values"; New collection:C1472("Bernie Sanders"; "Ahmed Ahmed"; "Proud Boys")\
			)
		Form:C1466.comfirmReject:=False:C215
		Form:C1466.resultData:=New object:C1471
		
		START TRANSACTION:C239
	: (Form event code:C388=On Unload:K2:2)
		CANCEL TRANSACTION:C241
	: (Form event code:C388=On Data Change:K2:15)
		clearPictureField(OBJECT Get pointer:C1124(Object named:K67:5; "var_indicator"))
End case 

If (Form event code:C388=On Timer:K2:25)
	If (OB Is defined:C1231(Form:C1466; "signal"))
		If (Form:C1466.signal.signaled)
			SET TIMER:C645(0)
			var $result : cs:C1710.SanctionListResult
			$result:=cs:C1710.SanctionListResult.new(Form:C1466.results)
			$result.displayResults(Form:C1466.options.comfirmReject)
			Form:C1466.results:=New collection:C1472
			OB REMOVE:C1226(Form:C1466; "signal")
		End if 
	Else 
		SET TIMER:C645(0)
	End if 
End if 