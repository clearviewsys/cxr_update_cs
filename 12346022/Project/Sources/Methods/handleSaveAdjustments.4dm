//%attributes = {}
C_TEXT:C284($registerID)
C_TEXT:C284(vInvoiceNumber; vFromAccount; vToAccount; vCurrency; vFullComments)
C_REAL:C285(vAmount)
C_DATE:C307(vInvoiceDate)

C_TEXT:C284($transferID)
$transferID:=vInvoiceNumber
C_LONGINT:C283($i; $n)
C_REAL:C285($valueBefore; $valueAfter; $adjustingValue; $offBalance; $offBalanceLC; $rate)
C_TEXT:C284($curr; $account; $registerID)
C_TEXT:C284($branchID)

$branchID:=getBranchID  // get the branch Id of this machine

For ($i; 1; Size of array:C274(arrAccountNames))
	
	$valueBefore:=arrAccountBalances{$i}
	$valueAfter:=arrAdjustedBalances{$i}
	$offBalance:=arrOffBalances{$i}
	$rate:=arrRates{$i}
	$adjustingValue:=$valueAfter-$valueBefore
	$curr:=arrCurrencies{$i}
	$account:=arrAccountNames{$i}
	
	Case of 
		: ($offBalance<0)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$account;Abs($adjustingValue);$curr;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";vCounterAccount;Abs($adjustingValue);$curr;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			
			// changed in version 3.550
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $account; ""; ""; Abs:C99($adjustingValue); $curr; False:C215; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; vCounterAccount; ""; ""; Abs:C99($adjustingValue); $curr; True:C214; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
			
		: ($offBalance>0)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$account;Abs($adjustingValue);$curr;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";vCounterAccount;Abs($adjustingValue);$curr;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			
			// changed in version 3.550
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; $account; ""; ""; Abs:C99($adjustingValue); $curr; True:C214; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; vUserID; vCounterAccount; ""; ""; Abs:C99($adjustingValue); $curr; False:C215; ->vFullComments; 0; 0; 0; 0; getSelfCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
			
		Else 
	End case 
	
End for 