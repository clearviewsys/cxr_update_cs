//%attributes = {}
C_TEXT:C284($registerID)
C_TEXT:C284(vInvoiceNumber; vFromAccount; vToAccount; vCurrency; vFullComments)
C_REAL:C285(vAmount)
C_DATE:C307(vInvoiceDate)
C_TEXT:C284(vBranchID; vUserID)

C_TEXT:C284($transferID)
$transferID:=vInvoiceNumber
C_LONGINT:C283($i; $n)
C_REAL:C285($valueBefore; $valueAfter; $adjustingValue; $offBalance; $offBalanceLC; $rate; $spotRate; $boardBuyRate; $boardSellRate)
C_TEXT:C284($curr; $account; $registerID; $branchID; $userID; $customerID; $currencyAlias)
C_BOOLEAN:C305($isTransfer)
C_REAL:C285($amountLocal; $amount; $tax1; $tax2)

For ($i; 1; Size of array:C274(arrAccountNames))
	$valueBefore:=arrAccountBalances{$i}
	$valueAfter:=arrAdjustedBalances{$i}
	$offBalance:=arrOffBalances{$i}
	$offBalanceLC:=arrOffBalancesLC{$i}
	$rate:=arrRates{$i}
	$adjustingValue:=$valueAfter-$valueBefore
	
	$curr:=arrCurrencies{$i}
	$account:=arrAccountNames{$i}
	$spotRate:=$rate  // changes in version 4.130 
	$boardBuyRate:=0
	$boardSellRate:=0
	$customerID:=getSelfCustomerID
	$isTransfer:=False:C215
	$currencyAlias:=$curr
	
	$amount:=Abs:C99($adjustingValue)
	$amountLocal:=Abs:C99($offBalanceLC)
	
	Case of 
		: ($offBalance<0)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$account;Abs($adjustingValue);$curr;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;$rate;0;getSelfCustomerID ;Abs($offBalanceLC);0;0;True)
			
			// changed in version 3.550
			$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $account; ""; ""; $amount; $curr; False:C215; ->vFullComments; 0; 0; $rate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
			
		: ($offBalance>0)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$account;Abs($adjustingValue);$curr;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;$rate;0;getSelfCustomerID ;Abs($offBalanceLC);0;0;True)
			
			// changed in version 3.550 
			$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $account; ""; ""; $amount; $curr; True:C214; ->vFullComments; 0; 0; $rate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
			
		Else   // if offBalance is Zero don't do anything
	End case 
End for 
