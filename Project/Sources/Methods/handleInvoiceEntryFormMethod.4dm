//%attributes = {}
C_TEXT:C284(vInvoiceNumber; vLabelDue; INV_vNextAccountCode)
C_REAL:C285(vCustomerBalanceDue)
C_REAL:C285(vTotalFees; vSumDebits; vSumCredits)
C_LONGINT:C283(cbEditFees; vTotalCount)
C_TEXT:C284(vBranchID; vUserID)
C_REAL:C285(vBalanceOnHand)
C_TEXT:C284(VCUSTOMERGROUP)
C_DATE:C307(vValueDate)
C_BOOLEAN:C305(isEwirePrinted)  // force user to save invoice

C_BOOLEAN:C305($condition; $isBalanced)
C_REAL:C285(<>epsilon)

// [invoices];"Entry"


Case of 
	: ((Form event code:C388=On Load:K2:1))
		
		setApplicationUserForTable(->[Invoices:5]; ->[Invoices:5]CreatedByUserID:19; ->[Invoices:5]ModifiedByUserID:20; ->[Invoices:5]BranchID:53; ->[Invoices:5]modBranchID:94)
		
		//isEwirePrinted:=False
		
		ARRAY TEXT:C222(vecAccounts; 0)
		vBranchID:=getBranchID
		vUserID:=getApplicationUser
		INV_vNextAccountCode:=""
		
		If ([Invoices:5]BranchID:53="")  //10/25/17
			[Invoices:5]BranchID:53:=vBranchID
		End if 
		
		startInvoice
		setFormObjectCustomProperties
		
		
		
		If (Is new record:C668([Invoices:5]))
			initInvoiceVars(True:C214)
			[Invoices:5]InvoiceID:1:=vInvoiceNumber
			[Invoices:5]invoiceDate:44:=Current date:C33
		Else 
			initInvoiceVars(False:C215)
			setInvoiceVarsToFields2  // set the variable to their saved field values
			//vInvoiceNumber:=[Invoices]InvoiceID
		End if 
		//starttransaction 
		// Modified by: Tiran Behrouz (2012-11-04)
		
		READ ONLY:C145(*)  // 1/11/22 IBB
		READ ONLY:C145([Registers:10])
		RELATE ONE:C42([Invoices:5]CustomerID:2)
		RELATE ONE:C42([Invoices:5]TransactionTypeID:91)
		RELATE ONE:C42([Invoices:5]CustomerTypeID:92)
		
		handleInvoiceCustomerOws  // this changes the register selection
		relateManyRegistersForInvoice
		veWiresReceived:=0
		vCustomerBalanceDue:=0
		
		setVisibleIff(<>isTransactionCodeVisible; "TransType@")
		setVisibleIff(<>isCustomerCodeVisible; "CustType@")
		setVisibleIff(isUserAllowedToEditFees; "cbEditFees")
		setVisibleIff(isUserAllowedToTransfer; "bTransfer")
		setVisibleIff(isUserAllowedToTransfer; "bAdjustQty")
		setVisibleIff(isUserAllowedToMakeAdjustments; "bAdjustment")
		setVisibleIff(isUserAllowedToTransfer; "bOpenTill")
		setVisibleIff(isUserAllowedToTransfer; "bCloseTill")
		setVisibleIff([Invoices:5]isSuspicious:30; "STRisReport@")
		
		setEnterableIff(isUserAllowedToEditFees; "cbFeeStructure")
		setEnterableIff(isUserAllowedToEditFees; "vPercentFee")
		setEnterableIff(isUserAllowedToEditFees; "vFeeLocal")
		// lock the inverse rate or direct rate
		setEnterableIff((isUserAllowedToChangeRates & (Not:C34(<>doLockDirectRate))); "vRate")
		setEnterableIff((isUserAllowedToChangeRates & (Not:C34(<>doLockInverseRate))); "vInverseRate")
		If (getKeyValue("invoice.date.allowedit"; "false")="true")
		Else 
			setEnterableIff((isUserManager); "vInvoiceDate")
		End if 
		
		handleInvoiceThirdparty
		
		// hide the direct rate column if inverse rate is used; and adjust column sizes
		C_LONGINT:C283($rateColWidth; $accountColWidth)
		If (<>doHideDirectRate)
			$rateColWidth:=LISTBOX Get column width:C834(*; "RateColumn")
			LISTBOX SET COLUMN WIDTH:C833(*; "RateColumn"; 4; 4)
			$accountColWidth:=LISTBOX Get column width:C834(*; "AccountColumn")
			LISTBOX SET COLUMN WIDTH:C833(*; "AccountColumn"; $accountColWidth+$rateColWidth-4)
		End if 
		
		If (<>doHideInverseRate)
			$rateColWidth:=LISTBOX Get column width:C834(*; "InverseRateColumn")
			LISTBOX SET COLUMN WIDTH:C833(*; "InverseRateColumn"; 4; 4)
			$accountColWidth:=LISTBOX Get column width:C834(*; "AccountColumn")
			LISTBOX SET COLUMN WIDTH:C833(*; "AccountColumn"; $accountColWidth+$rateColWidth-4)
		End if 
		
		
		If (Is new record:C668([Invoices:5]))
			
			setvCustomerID(getNextCustomer)
			initNextCustomer
			GOTO OBJECT:C206(vCustomerID)  // make sure the customer ID gets the initial focus
			
			setReceivedOrPaid(<>defaultBuyOrSell)  // changes in version 4.090
			
			Case of   // changes in version 4.090
				: (<>defaultBuyOrSell=1)  // buy
					setVecCurrency(<>DEFAULTBUYCURRENCY)
				: (<>defaultBuyOrSell=2)  //sell
					setVecCurrency(<>DEFAULTSELLCURRENCY)
				Else 
					setVecCurrency(<>BASECURRENCY)
			End case 
			
			[Invoices:5]isNewVersion:40:=True:C214  // NEW VERSION of the invoice
			
			//GOTO AREA(*;"vCustomerID")
			UNLOAD RECORD:C212([Items:39])  // clear any items showing 
			
			
		Else   //*************************************** MODIFICATION / EDIT ------------------------
			
			If (([Invoices:5]isCancelled:84) & (Not:C34(isUserDesigner)))  // CANCELLED INVOICE CANNOT BE MODIFIED
				myAlert("This invoice has been previously cancelled. No more modifications are allowed")
				CANCEL:C270
			End if 
			
			// INVOICES BELONGING TO SOMEONE ELSE CANNOT BE MODIFIED BY SOMEONE ELSE
			If ((Not:C34(isUserComplianceOfficer)) & (Not:C34(isUserManager)) & ([Invoices:5]CreatedByUserID:19#getApplicationUser))
				myAlert("Only managers, accountants, and compliance officers are allowed to change invoices created by someone else.")
				CANCEL:C270
			End if 
			
			If (False:C215)  // IBB 12/14/21 this is a change in behaviour and causing issues - Lotus
				// need to review with Tiran
				If (isInvoiceReconciled([Invoices:5]InvoiceID:1))  // RECONCILED INVOICE CANNOTE BE MODIFIED
					myAlert("This invoice has been reconciled. No more modifications are allowed.")
					CANCEL:C270
				End if 
			End if 
			
			
			handleReceiveeWireForCustomer
			enableButtonIf((countCustomerPictureIDs>0); "bShowPID")
			setVisibleIff(True:C214; "applyChangesButton")  // show button only for edited records. 
			
			stampText("stamp_modification"; "Modification Mode"; "red")
			GOTO SELECTED RECORD:C245([Registers:10]; 0)
			POST OUTSIDE CALL:C329(Current process:C322)  // refresh the variables and calculations
		End if 
		
		
		
		
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Outside Call:K2:11))
		
		If (Form event code:C388#On Clicked:K2:4)
			relateManyRegistersForInvoice
		End if 
		handleInvoiceCalculations
		colourizeObjectBGIff("vPercentFee"; (vPercentFee#0))
		colourizeObjectBGIff("vFeeLocal"; (vFeeLocal#0))
		setVisibleIff([Invoices:5]isSuspicious:30; "STRisReport@")  //5/9/22
		
		
		$Condition:=(Records in selection:C76([Registers:10])>0)
		setEnterableIff(Not:C34($condition); "vCustomerID")
		//setVisibleIff ($condition;"CustomerEditWarning")
		
		$isBalanced:=(Abs:C99(vDueFromCustomer-vDueToCustomer)<<>epsilon)
		//setVisibleIff ($isBalanced & $condition;"b_save") // 5/10/22 ibb disabled b/c can't save empty invoice 
		setVisibleIff($isBalanced; "b_save")  // 5/1/22 ibb this is how it was in 2021
		
		stampText("stamp_checked"; "✔"; "green"; ($isBalanced & (vSumCreditsLocal>0)))
		C_OBJECT:C1216($style)
		$style:=New object:C1471
		
		If ($isBalanced)
			stampText("stamp_due"; "Balanced"; "green"; False:C215)  // remove the due
		Else 
			If (vDueToCustomer>0)
				setStampStyle($style; "blue"; 0; 24)
				stampText("stamp_due"; "Due Payable ⤴ "+String:C10(vDueToCustomer; "|Currency")+" "+<>BASECURRENCY; "blue"; (vDueToCustomer>0); $style)
			End if 
			
			If (vDueFromCustomer>0)
				setStampStyle($style; "red"; 0; 24)
				stampText("stamp_due"; "⬇ Due Receivable "+String:C10(vDueFromCustomer; "|Currency")+" "+<>BASECURRENCY; "red"; (vDueFromCustomer>0); $style)
			End if 
		End if 
		
		
		
	: (Form event code:C388=On Close Box:K2:21)
		handleInvoiceCancelClose
		
	: (Form event code:C388=On Unload:K2:2)
		endInvoice
		
		If (Read only state:C362([Customers:3])=False:C215)
			UNLOAD RECORD:C212([Customers:3])  //5/6/21 ibb
			READ ONLY:C145([Customers:3])
			LOAD RECORD:C52([Customers:3])
		End if 
		
		If (Read only state:C362([Registers:10])=False:C215)
			UNLOAD RECORD:C212([Registers:10])  //5/6/21 ibb
			READ ONLY:C145([Registers:10])
			LOAD RECORD:C52([Registers:10])
		End if 
		
End case 




//If (Form event#On Clicked)
If (Form event code:C388=On Outside Call:K2:11)
	ASSERT:C1129(vInvoiceNumber#""; "handleInvoiceEntryFormMethod: invoice number is null")
	relateManyRegistersForInvoice
End if 





//If (False)
//If ((Form event=On Data Change) | (Form event=On Clicked) | (Form event=On Outside Call))

//$Condition:=(Records in selection([Registers])>0)
//setEnterableIff (Not($condition);"vCustomerID")
//  //setVisibleIff ($condition;"CustomerEditWarning")

//$isBalanced:=(Abs(vDueFromCustomer-vDueToCustomer)<<>epsilon)
//setVisibleIff ($isBalanced & $condition;"b_save")

//stampText ("stamp_checked";"✔";"green";($isBalanced & (vSumCreditsLocal>0)))
//C_OBJECT($style)
//$style:=New object

//If ($isBalanced)
//stampText ("stamp_due";"Balanced";"green";False)
//Else 
//If (vDueToCustomer>0)
//setStampStyle ($style;"blue";0;24)
//stampText ("stamp_due";"Due Payable ⤴ "+String(vDueToCustomer;"|Currency")+" "+<>BASECURRENCY;"blue";(vDueToCustomer>0);$style)
//End if 

//If (vDueFromCustomer>0)
//setStampStyle ($style;"red";0;24)
//stampText ("stamp_due";"⬇ Due Receivable "+String(vDueFromCustomer;"|Currency")+" "+<>BASECURRENCY;"red";(vDueFromCustomer>0);$style)
//End if 
//End if 

//End if 
//End if 

//If (Form event=On Close Box)
//handleInvoiceCancelClose 
//End if 

//If (Form event=On Unload)
//endInvoice 

//If (Read only state([Customers])=False)
//UNLOAD RECORD([Customers])  //5/6/21 ibb
//READ ONLY([Customers])
//LOAD RECORD([Customers])
//End if 

//If (Read only state([Registers])=False)
//UNLOAD RECORD([Registers])  //5/6/21 ibb
//READ ONLY([Registers])
//LOAD RECORD([Registers])
//End if 

//End if 



