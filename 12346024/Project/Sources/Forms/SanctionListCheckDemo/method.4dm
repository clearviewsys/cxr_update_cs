// Author: Wai-Kin
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (OB Is defined:C1231(Form:C1466; "testing"))
			OBJECT SET VISIBLE:C603(*; "check_worker"; Form:C1466.testing)
			If (Form:C1466.testing)
				Form:C1466.useWorker:=1
			Else 
				Form:C1466.useWorker:=0
			End if 
		Else 
			Form:C1466.useWorker:=1
		End if 
		Form:C1466.id:=""
		Form:C1466.table:=""
		Form:C1466.isEntity:=0
		var $collectSanctions : Collection
		$collectSanctions:=ds:C1482.SanctionLists.all().ShortName
		ARRAY TEXT:C222($arrSanctions; 0)
		COLLECTION TO ARRAY:C1562($collectSanctions; $arrSanctions)
		var $listSanctions : Integer
		$listSanctions:=New list:C375
		ARRAY TO LIST:C287($arrSanctions; $listSanctions)
		OBJECT SET LIST BY REFERENCE:C1266(*; "var_useList"; Choice list:K42:19; $listSanctions)
		OBJECT SET LIST BY REFERENCE:C1266(*; "var_useList"; Required list:K42:20; $listSanctions)
		Form:C1466.list:=""
		Form:C1466.manualList:=""
		Form:C1466.autoCheck:=False:C215
		Form:C1466.autoList:=""
		Form:C1466.result:=""
		Form:C1466.showInterface:=1
		Form:C1466.comfirmReject:=0
		Form:C1466.usePep:=False:C215
		Form:C1466.useSL:=False:C215
		Form:C1466.useList:=True:C214
		Form:C1466.resultData:=New object:C1471
		START TRANSACTION:C239
	: (Form event code:C388=On Unload:K2:2)
		CANCEL TRANSACTION:C241
	: (Form event code:C388=On Data Change:K2:15)
		clearPictureField(OBJECT Get pointer:C1124(Object named:K67:5; "var_indicator"))
End case 

If (Form:C1466.autoCheck)
	Form:C1466.list:=""
	OBJECT SET VISIBLE:C603(*; "rad_pep"; False:C215)
	OBJECT SET VISIBLE:C603(*; "rad_sl"; False:C215)
	OBJECT SET VISIBLE:C603(*; "rad_list"; False:C215)
	OBJECT SET VISIBLE:C603(*; "var_useList"; False:C215)
	OBJECT SET VISIBLE:C603(*; "var_autoList"; True:C214)
Else 
	Form:C1466.autoList:=""
	OBJECT SET VISIBLE:C603(*; "rad_pep"; True:C214)
	OBJECT SET VISIBLE:C603(*; "rad_sl"; True:C214)
	OBJECT SET VISIBLE:C603(*; "rad_list"; True:C214)
	OBJECT SET VISIBLE:C603(*; "var_useList"; True:C214)
	OBJECT SET VISIBLE:C603(*; "var_autoList"; False:C215)
End if 

If (Form:C1466.useList)
	OBJECT SET ENABLED:C1123(*; "var_useList"; True:C214)
Else 
	OBJECT SET ENABLED:C1123(*; "var_useList"; False:C215)
	Form:C1466.list:=""
End if 

Case of 
	: (Form:C1466.usePep)
		Form:C1466.manualList:="PEP"
	: (Form:C1466.useSL)
		Form:C1466.manualList:="SL"
	: (Form:C1466.useList)
		Form:C1466.manualList:=""
End case 

If (Form event code:C388=On Timer:K2:25)
	If (OB Is defined:C1231(Form:C1466.signal))
		If (Form:C1466.signal.signaled)
			myAlert("Check Completed!")
			SET TIMER:C645(0)
		End if 
	Else 
		SET TIMER:C645(0)
	End if 
	//slold_handleCheckCompleteEvent(->[Customers]CustomerID; \
						OBJECT Get pointer(Object named; "var_indicator"); \
						OBJECT Get pointer(Object named; "txt_result"))
End if 

Form:C1466.found:=Create entity selection:C1512([SanctionCheckLog:111])