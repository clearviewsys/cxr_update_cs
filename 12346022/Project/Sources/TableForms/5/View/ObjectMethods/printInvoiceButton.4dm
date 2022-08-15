C_LONGINT:C283(vPageSetup)


If (([Invoices:5]isTransfer:42=False:C215) & (doComplyWithSkatteverket))
	//my Alert ("This feature is disabled due to Skatteverket compliance.")
	
	C_TEXT:C284($vCurrency)
	C_REAL:C285($vSumDebit; $vSumCredit)
	C_BOOLEAN:C305($success)
	C_TEXT:C284(vControlCodeResponse)
	C_LONGINT:C283(<>SVbaseSerial)
	C_LONGINT:C283($serialNumber)
	C_TEXT:C284($userID; $posID)
	
	vControlCodeResponse:=""
	$vCurrency:=<>baseCurrency
	$vSumDebit:=[Invoices:5]fromAmountLC:38
	$vSumCredit:=[Invoices:5]toAmountLC:39
	$serialNumber:=[Invoices:5]cashControlSerialNo:51
	$userID:=getApplicationUser
	$posID:=getCurrentMachineAlias
	
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$success:=writeToBBoxOnServer($userID; $posID; $serialNumber; $vSumDebit; $vSumCredit; [Invoices:5]InvoiceID:1; ->vControlCodeResponse; True:C214; [Invoices:5]CreationDate:13; [Invoices:5]CreationTime:14)  // changed the order vSumDebit and vSumCredit after testing 
		: (Application type:C494=4D Local mode:K5:1)
			$success:=writeToBBox($userID; $posID; $serialNumber; $vSumDebit; $vSumCredit; [Invoices:5]InvoiceID:1; ->vControlCodeResponse; True:C214; [Invoices:5]CreationDate:13; [Invoices:5]CreationTime:14)
		Else 
			$success:=False:C215
	End case 
	
	If ($success)
		If (getKeyValue([Invoices:5]InvoiceID:1; "false")="false")
			setPrintSettings(getClientReceiptPrinterName; True:C214; 100; getClientReceiptPageFormat)
			printSelectionUsingPrinter(->[Registers:10]; "printInvoice_Thermal_SEK_Kopy"; getClientReceiptPrinterName; 1)
			vControlCodeResponse:=""
			setKeyValue([Invoices:5]InvoiceID:1; "true")  // set key value to 'true' meaning printed
		End if 
	Else 
		// Replaced on: 2/8/2017 - BY: CVS Dev. Team
		// myAlert ("There was problem writing to the control box!")
		myAlert(GetLocalizedErrorMessage(4089))
	End if 
	
Else 
	
	setPrintSettingsForReceipt
	SET PRINT PREVIEW:C364(<>previewBeforePrint)
	
	If (vPageSetup=0)
		printThisInvoice
	Else 
		printSelection(->[Registers:10]; getClientInvoiceFormName)
	End if 
	
End if 