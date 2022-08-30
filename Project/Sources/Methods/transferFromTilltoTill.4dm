//%attributes = {}
// transferFromTillToTill (sourceTill; destinationTill)
C_TEXT:C284($fromTill; $toTill)
$fromTill:=$1
$toTill:=$2

selectAccountsRelatedToTill($fromTill)

C_REAL:C285($debitBalance; $amount)
C_TEXT:C284($registerID; $currency; $accountID; vFullComments; $mainCash)
C_TEXT:C284($branchID; $self; $userID; $accountID; $currency)
$self:=getSelfCustomerID

$branchID:=getBranchID
$userID:=getApplicationUser

C_LONGINT:C283($n; $i)

$n:=Records in selection:C76([Accounts:9])
ARRAY TEXT:C222($arrAccountIDs; $n)
//_O_ARRAY STRING(3;$arrCurrencies;$n)
ARRAY TEXT:C222($arrCurrencies; $n)
SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; $arrAccountIDs; [Accounts:9]Currency:6; $arrCurrencies)

For ($i; 1; Records in selection:C76([Accounts:9]))
	$accountID:=$arrAccountIDs{$i}
	$debitBalance:=getAccountBalance($accountID)
	$currency:=$arrCurrencies{$i}
	$mainCash:=makeCashAccountID($currency; $toTill)
	$amount:=Abs:C99($debitBalance)
	
	ASSERT:C1129($accountID#"")
	ASSERT:C1129($mainCash#"")
	
	Case of 
		: ($debitBalance>0)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$accountID;$amount;$currency;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$mainCash;$amount;$currency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; $userID; $accountID; ""; ""; $amount; $currency; False:C215; ->vFullComments; 0; 0; 0; 0; $self; 0; True:C214; 0; 0; $currency; 0; 0)
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; $userID; $mainCash; ""; ""; $amount; $currency; True:C214; ->vFullComments; 0; 0; 0; 0; $self; 0; True:C214; 0; 0; $currency; 0; 0)
			
		: ($debitBalance<0)
			
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$accountID;$amount;$currency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			//$registerID:=createRegisterFromTable (->[Invoices];vInvoiceNumber;vInvoiceNumber;"";$mainCash;$amount;$currency;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;getSelfCustomerID ;0;0;0;True)
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; $userID; $accountID; ""; ""; $amount; $currency; True:C214; ->vFullComments; 0; 0; 0; 0; $self; 0; True:C214; 0; 0; $currency; 0; 0)
			$registerID:=createRegisterFromTable($branchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vInvoiceDate; $userID; $mainCash; ""; ""; $amount; $currency; False:C215; ->vFullComments; 0; 0; 0; 0; $self; 0; True:C214; 0; 0; $currency; 0; 0)
			
	End case 
End for 

ARRAY TEXT:C222($arrAccountIDs; 0)
//_O_ARRAY STRING(3;$arrCurrencies;0)


handleTransferButton