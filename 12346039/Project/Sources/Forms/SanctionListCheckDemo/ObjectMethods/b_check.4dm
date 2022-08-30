If (Form event code:C388=On Clicked:K2:4)
	clearPictureField(OBJECT Get pointer:C1124(Object named:K67:5; "var_indicator"))
	OBJECT Get pointer:C1124(Object named:K67:5; "txt_result")->:=""
	Form:C1466.ran:=""
	Form:C1466.sanctions:=""
	Form:C1466.peps:=""
	
	C_POINTER:C301($logIdPtr)
	
	var $autoList : Integer
	If (Value type:C1509(Form:C1466.autoList)=Is text:K8:3)
		Case of 
			: (Form:C1466.autoList="Customers")
				$autoList:=sl_CustomersFlag
			: (Form:C1466.autoList="Invoices")
				$autoList:=sl_InvoicesFlag
			: (Form:C1466.autoList="Links")
				$autoList:=sl_LinksFlag
			: (Form:C1466.autoList="eWires")
				$autoList:=sl_eWiresFlag
			: (Form:C1466.autoList="Agents")
				$autoList:=sl_AgentsFlag
			: (Form:C1466.autoList="ThirdParties")
				$autoList:=sl_ThirdPartiesFlag
			: (Form:C1466.autoList="Wires")
				$autoList:=sl_WiresFlag
		End case 
	Else 
		$autoList:=sl_NoFlag
	End if 
	
	C_OBJECT:C1216($options)
	$options:=New object:C1471
	$options.options:=New object:C1471
	$options.options.manualList:=Form:C1466.manualList
	$options.options.list:=Form:C1466.list
	$options.options.query:=""
	$options.options.autoList:=$autoList
	$options.options.interface:=Form:C1466.showInterface=1
	$options.options.comfirmReject:=Form:C1466.comfirmReject=1
	$options.options.useWorker:=Form:C1466.useWorker=1
	$options.pointers:=New object:C1471
	$options.pointers.resultTextPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "txt_result")
	$options.pointers.resultIconPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "var_indicator")
	$options.pointers.handleDetailMethod:="sl_handleDemoListResult"
	
	If (Form:C1466.autoCheck)
		If (Not:C34(<>doCheckSanctionLists))
			OBJECT Get pointer:C1124(Object named:K67:5; "txt_result")->:="(No checking because automatic check option is off)"
		End if 
	End if 
	
	sl_screenMainlyNameWithOptions(Not:C34(Form:C1466.autoCheck); Form:C1466.name; Form:C1466.isEntity=1; \
		$logIdPtr; $options\
		)
	
	//If (Form.isEntity=0)
	//sl_screenPerson(Not(Form.autoCheck); Form.name; \
										$logIdPtr; $options)
	//Else 
	//sl_screenCompany(Not(Form.autoCheck); Form.name; \
										$logIdPtr; $options)
	//End if 
	If (Form:C1466.useWorker=1)
		SET TIMER:C645(1)
	End if 
End if 