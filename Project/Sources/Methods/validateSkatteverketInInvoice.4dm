//%attributes = {}
//_O_ARRAY STRING(3;$arrayCurrency;0)
ARRAY TEXT:C222($arrayCurrency; 0)
C_TEXT:C284($vCurrency)
ARRAY REAL:C219($arrDebitLocal; 0)
ARRAY REAL:C219($arrCreditLocal; 0)
C_REAL:C285($vSumDebit; $vSumCredit)
C_BOOLEAN:C305($success)
C_TEXT:C284(controlCodeResponse)
C_LONGINT:C283(<>SVbaseSerial)
controlCodeResponse:=""

If (([Invoices:5]isTransfer:42=False:C215) & (doComplyWithSkatteverket))
	$vCurrency:=<>baseCurrency
	QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6="Cash@")
	SELECTION TO ARRAY:C260([Registers:10]Currency:19; $arrCurrency; [Registers:10]DebitLocal:23; $arrDebitLocal; [Registers:10]CreditLocal:24; $arrCreditLocal)
	$vSumDebit:=vecSumConditional(->$arrDebitLocal; ->$arrCurrency; ->$vCurrency; True:C214)
	$vSumCredit:=vecSumConditional(->$arrCreditLocal; ->$arrCurrency; ->$vCurrency; True:C214)
	If ($vSumDebit>$vSumCredit)
		$vSumDebit:=$vSumDebit-$vSumCredit
		$vSumCredit:=0
	Else 
		$vSumCredit:=$vSumCredit-$vSumDebit
		$vSumDebit:=0
	End if 
	
	C_LONGINT:C283($serialNumber)
	
	$serialNumber:=getTableLastSerialNumber(->[ControlBox:66])+<>SVbaseSerial+1
	C_TEXT:C284($userID; $posID)
	$userID:=getApplicationUser
	$posID:=getCurrentMachineAlias
	
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$success:=writeToBBoxOnServer($userID; $posID; $serialNumber; $vSumDebit; $vSumCredit; [Invoices:5]InvoiceID:1; ->controlCodeResponse; False:C215; [Invoices:5]CreationDate:13; [Invoices:5]CreationTime:14)  // changed the order vSumDebit and vSumCredit after testing 
		: (Application type:C494=4D Local mode:K5:1)
			$success:=writeToBBox($userID; $posID; $serialNumber; $vSumDebit; $vSumCredit; [Invoices:5]InvoiceID:1; ->controlCodeResponse; False:C215; [Invoices:5]CreationDate:13; [Invoices:5]CreationTime:14)
		Else 
			$success:=False:C215
	End case 
	
	If ($success)
		[Invoices:5]CashDisbursement:52:=$vSumCredit-$vSumDebit
		[Invoices:5]ControlCodeResponse:50:=controlCodeResponse
		[Invoices:5]cashControlSerialNo:51:=$serialNumber  // record the cash serial no (the invoice serialno increases for all transactions, even non cash
		
		[Invoices:5]fromAmountLC:38:=$vSumDebit
		[Invoices:5]toAmountLC:39:=$vSumCredit
		[Invoices:5]createdMachineAlias:82:=$posID
		
		$serialNumber:=getTableNextSerialNo(->[ControlBox:66])  // advance the pointer
	Else 
		checkAddError("Error writing to CleanCash Control Box.")
	End if 
	
End if 
