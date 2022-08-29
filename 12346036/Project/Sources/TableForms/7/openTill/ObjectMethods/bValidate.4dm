C_TEXT:C284(vCounterAccount; vFullComments)
C_LONGINT:C283($n)
C_TEXT:C284($accountID; $currency; $mainCash)

C_TEXT:C284($fromTill)
$fromTill:=vMainCashRegisterID  // source of transfer to opening (usually 00)

checkInit
If (isValidationConfirmed)
	$n:=Size of array:C274(arrAccountNames)
	
	C_LONGINT:C283($i)
	For ($i; 1; $n)
		C_REAL:C285($debitBalance; $amount)
		$accountID:=arrAccountNames{$i}
		$currency:=arrCurrencies{$i}
		$mainCash:=makeCashAccountID($currency; $fromTill)
		$debitBalance:=arrOffBalances{$i}
		$amount:=Abs:C99($debitBalance)
		C_TEXT:C284($registerID)
		Case of 
			: ($debitBalance<0)
				//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$accountID;$amount;$currency;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
				//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$mainCash;$amount;$currency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
				
				$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $accountID; ""; ""; $amount; $currency; False:C215; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; $currency; 0; 0)
				$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $mainCash; ""; ""; $amount; $currency; True:C214; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; $currency; 0; 0)
				
			: ($debitBalance>0)
				//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$accountID;$amount;$currency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
				//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$mainCash;$amount;$currency;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
				$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $accountID; ""; ""; $amount; $currency; True:C214; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; $currency; 0; 0)
				$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $mainCash; ""; ""; $amount; $currency; False:C215; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; $currency; 0; 0)
				
		End case 
	End for 
	
Else 
	REJECT:C38
End if 

