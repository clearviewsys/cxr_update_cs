//%attributes = {}
C_POINTER:C301($ptrList; $formNameptr)
C_LONGINT:C283($i)
C_OBJECT:C1216($return)
C_TEXT:C284($payStatus)
C_BOOLEAN:C305($isApproveWorthy; $isProfix)

Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
		$isApproveWorthy:=True:C214  //currently all webewires can be approved/denied... 
		//even if a poliLink is created. that way customer can walk in and pay alternative ways
		$isProfix:=False:C215
		
		tFromParty:=Get_Object_Info(->[WebEWires:149]fromParty:7)
		tToParty:=Get_Object_Info(->[WebEWires:149]toParty:8)
		tAMLInfo:=Get_Object_Info(->[WebEWires:149]AML_Info:9)
		tFromThirdParty:=Get_Object_Info(->[WebEWires:149]fromThirdParty:19)
		ttoThirdParty:=Get_Object_Info(->[WebEWires:149]toThirdParty:23)
		tToBankingInfo:=Get_Object_Info(->[WebEWires:149]toBankingInfo:24)
		
		If (webEwiresIsMoneyGram([WebEWires:149]WebEwireID:1))
			
			Form:C1466.originText:="Origin Profix Web app"
			Form:C1466.paymentInfo:=[WebEWires:149]paymentInfo:35
			Form:C1466.isStaged:=False:C215
			$isProfix:=True:C214
			//If (Windows Ctrl down)  // buttons for MoneyGram certification tests
			//OBJECT SET VISIBLE(*;"b_FS@";True)
			//End if 
			
			If ([WebEWires:149]paymentInfo:35.origin#Null:C1517)
				If ([WebEWires:149]paymentInfo:35.origin="SOAP")
					$isProfix:=False:C215
					Form:C1466.originText:="Origin Web portal/SOAP API"
					If ([WebEWires:149]paymentInfo:35.soap.passed.FormFreeStaging#Null:C1517)
						If ([WebEWires:149]paymentInfo:35.soap.passed.FormFreeStaging="True")
							Form:C1466.isStaged:=True:C214
						End if 
					End if 
					
					
				End if 
			End if 
			
			If ([WebEWires:149]paymentInfo:35.receiptHTML#Null:C1517)
				OBJECT SET ENABLED:C1123(*; "b_printRe@"; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(*; "b_printRe@"; False:C215)
			End if 
			
			C_OBJECT:C1216($datetime)
			C_POINTER:C301($ptr; $timeobjPtr; $dateObjPtr)
			
			$datetime:=mgConvertProfixDateTime(Form:C1466.paymentInfo.result.transactionDateTime)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "checktime1")
			
			If ($ptr#Null:C1517)
				If (Form:C1466.paymentInfo.statusCheck#Null:C1517)
					$ptr->:=Form:C1466.paymentInfo.statusCheck.lastCheckTime
				End if 
			End if 
			
			$timeobjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "resulttransactiontime")
			$dateObjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "resulttransactiondate")
			
			If ($datetime#Null:C1517)
				If ($timeobjPtr#Null:C1517)
					$timeobjPtr->:=$datetime.time
				End if 
				If ($dateObjPtr#Null:C1517)
					$dateObjPtr->:=$datetime.date
				End if 
			End if 
			
			$timeobjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "resulttransactiontime1")
			$dateObjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "resulttransactiondate1")
			
			If ($datetime#Null:C1517)
				If ($timeobjPtr#Null:C1517)
					$timeobjPtr->:=$datetime.time
				End if 
				If ($dateObjPtr#Null:C1517)
					$dateObjPtr->:=$datetime.date
				End if 
			End if 
			
			tPaymentInfo:=JSON Stringify:C1217([WebEWires:149]paymentInfo:35; *)
			//OBJECT SET VISIBLE(*;"btn_deny";False)
			//OBJECT SET VISIBLE(*;"deny@";False)
			//OBJECT SET VISIBLE(*;"btn_approve";False)
			//OBJECT SET VISIBLE(*;"approve@";False)
			
			If (Not:C34(Shift down:C543))
				If ([WebEWires:149]paymentInfo:35.passedToMoneyGram.transactionType="Send")
					FORM GOTO PAGE:C247(3)  // "pretty" view for send transaction
					If (getKeyValue("mg.sendConfirm.isAllowed"; "false")="true")
					Else 
						OBJECT SET VISIBLE:C603(*; "b_confirmStagedSend@"; False:C215)
					End if 
				Else 
					FORM GOTO PAGE:C247(4)  // "pretty view for receive transactions
				End if 
			Else 
				FORM GOTO PAGE:C247(2)  // raw view
			End if 
			
			If ([WebEWires:149]isCancelled:20)
				OBJECT SET RGB COLORS:C628(*; "webewireID"; 0; 0x00FF7F7F)  // red background color
			End if 
			
			$formNameptr:=OBJECT Get pointer:C1124(Object named:K67:5; "formName")
			$formNameptr->:="MoneyGram transaction"
			SET WINDOW TITLE:C213($formNameptr->)
			
		Else 
			tPaymentInfo:=Get_Object_Info(->[WebEWires:149]paymentInfo:35)
		End if 
		
		$payStatus:=setWebEwirePaymentStatus
		
		Case of 
			: ($isProfix)  // dont do anything
				// not stamping here
				
				
				//  //OBJECT SET VISIBLE(*;"b_@";False) // this resets what was done in btn object methods
				//OBJECT SET VISIBLE(*;"btn_approve";False)
				//OBJECT SET VISIBLE(*;"approve@";False)
				//OBJECT SET VISIBLE(*;"btn_deny";False)
				//OBJECT SET VISIBLE(*;"deny@";False)
				
				//OBJECT SET VISIBLE(*;"b_show@";True)
				//OBJECT SET VISIBLE(*;"b_invoice@";True)
				//OBJECT SET VISIBLE(*;"b_checkMGStatus@";True)
				//OBJECT SET VISIBLE(*;"b_printReceipt@";True)
				//OBJECT SET VISIBLE(*;"b_amendTransfer@";True)
				
				
			: ($payStatus="UNDEFINED")  //no payment gateway setup
				stampText("b_payment_Status"; "Payment UNDEFINED"; "red")
			: ($payStatus="UNKNOWN")  //gateway failure to look up
				stampText("b_payment_Status"; "Payment UNKNOWN"; "red")
			: ($payStatus="CANCEL@")  //gateway failure to look up
				stampText("b_payment_Status"; "Payment CANCELLED"; "red")
			: ($payStatus="Completed") | ($payStatus="SUCCESS@")
				stampText("b_payment_Status"; "PAID"; "green")
			: ($payStatus="")
				stampText("b_payment_Status"; "<BLANK>"; "orange")
			Else 
				stampText("b_payment_Status"; $payStatus; "orange")
		End case 
		
		OBJECT SET ENABLED:C1123(*; "b_editRecord@"; False:C215)
		
		
		Case of 
			: ($isProfix)  // dont do anything
				//OBJECT SET VISIBLE(*;"b_@";False) // this resets what was done in btn object methods
				OBJECT SET VISIBLE:C603(*; "btn_approve"; False:C215)
				OBJECT SET VISIBLE:C603(*; "approve@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "btn_deny"; False:C215)
				OBJECT SET VISIBLE:C603(*; "deny@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "b_show@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "invoiceNumberBtn@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "b_checkMGStatus@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "b_printReceipt@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "b_amendTransfer@"; True:C214)
				
			: (([WebEWires:149]status:16>=0) & ([WebEWires:149]status:16<=10)) & ($isApproveWorthy) & ($isProfix=False:C215)  //pending review
				//allow user to approve or deny
			: ((isUserAdministrator) | (isUserDesigner)) & (($payStatus="Fail@") | [WebEWires:149]isCancelled:20)
				//allow user to approve or deny - override for errors with payment gateway - paymark
				
			Else 
				OBJECT SET RGB COLORS:C628(*; "Approve_Color@"; Dark shadow color:K23:3; Dark shadow color:K23:3)
				OBJECT SET RGB COLORS:C628(*; "Deny_Color@"; Dark shadow color:K23:3; Dark shadow color:K23:3)
				
				OBJECT SET ENABLED:C1123(*; "@"; False:C215)
				OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
				
				OBJECT SET ENABLED:C1123(*; "b_@"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "b_@"; True:C214)
				
				If ([WebEWires:149]status:16=20)  //approved
					OBJECT SET ENABLED:C1123(*; "invoiceNewBtn@"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "invoiceNewBtn@"; True:C214)
				End if 
		End case 
		
		// ----STAMP TEXT STATUS ----
		Case of 
				//getWebEWireStatusEmoji
			: ([WebEWires:149]status:16=-20)
				stampText("stamp_Status"; "DENIED")
				
			: ([WebEWires:149]status:16=-10)
				stampText("stamp_Status"; "CANCELLED")
				
			: ([WebEWires:149]status:16=10) & ($payStatus="UNDEFINED")  //should not happen
				stampText("stamp_Status"; "Pending Approval"; "green")
				
			: ([WebEWires:149]status:16=10) & ($payStatus="UNKNOWN")  //should not happen
				stampText("stamp_Status"; "Payment Status Unknown"; "orange")
				
			: ([WebEWires:149]status:16=10) & ($payStatus="Completed")
				stampText("stamp_Status"; "PAID: Pending Approval"; "green")
				
			: ([WebEWires:149]status:16=10)
				stampText("stamp_Status"; "Pending Payment"; "orange")
				
			: ([WebEWires:149]status:16=20)
				stampText("stamp_Status"; "APPROVED"; "green")
				
			: ([WebEWires:149]status:16=30)
				stampText("stamp_Status"; "PROCESSED: Sent"; "green")
				
			: ([WebEWires:149]status:16=40)
				stampText("stamp_Status"; "PROCESSED: Complete"; "green")
				
			: ($isProfix)  // no stamp
			Else 
				stampText("stamp_Status"; String:C10([WebEWires:149]status:16); "orange")
		End case 
		
		
	Else 
		
		
End case 
