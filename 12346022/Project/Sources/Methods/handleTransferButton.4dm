//%attributes = {}
C_TEXT:C284($registerID)
C_TEXT:C284(vInvoiceNumber; vFromAccount; vToAccount; vCurrency; vFullComments; vCustomerID; vReferenceID; vFromSubAccountID; vToSubAccountID)
C_REAL:C285(vAmount)
C_DATE:C307(vInvoiceDate; vFromDate; vToDate)

//CONFIRM(vFullComments;"Confirm";"Cancel")
//If (OK=1)

//starttransaction
C_TEXT:C284($transferID)
$transferID:=vInvoiceNumber

//CREATE RECORD([Registers])  ` Withdraw from Account
//[Registers]AccountID:=vFromAccount
//[Registers]RegisterType:="Transfer"
//[Registers]RegisterDate:=vTransferDate
//[Registers]CustomerID:="self"  ` means us
//[Registers]InvoiceNumber:=$transferID
//[Registers]Credit:=vFromAmount
//[Registers]isReceived:=False
//[Registers]Comments:=vFullComments
//[Registers]Currency:=vFromCurrency
//SAVE RECORD([Registers])
If (vCurrency=<>baseCurrency)
	$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vFromDate; vUserID; vFromAccount; vFromSubAccountID; vReferenceID; vAmount; vCurrency; False:C215; ->vFullComments; 0; 0; 0; 0; vCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
	$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vToDate; vUserID; vToAccount; vToSubAccountID; vReferenceID; vAmount; vCurrency; True:C214; ->vFullComments; 0; 0; 0; 0; vCustomerID; 0; True:C214; 0; 0; <>baseCurrency; 1; 1)
	//$registerID:=createRegisterFromTable (vBranchID;->[Invoices];vInvoiceNumber;vInvoiceNumber;"";vInvoiceDate;vUserID;ToAccount;vAmount;vCurrency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;1;1;vCustomerID;vAmount;0;0;True)
	
Else 
	$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vFromDate; vUserID; vFromAccount; vFromSubAccountID; vReferenceID; vAmount; vCurrency; False:C215; ->vFullComments; 0; 0; 0; 0; vCustomerID; 0; True:C214; 0; 0; vCurrency; 0; 0)
	$registerID:=createRegisterFromTable(vBranchID; ->[Invoices:5]; vInvoiceNumber; vInvoiceNumber; ""; vToDate; vUserID; vToAccount; vToSubAccountID; vReferenceID; vAmount; vCurrency; True:C214; ->vFullComments; 0; 0; 0; 0; vCustomerID; 0; True:C214; 0; 0; vCurrency; 0; 0)
	
	//$registerID:=createRegisterFromTable (vBranchID;->[Invoices];vInvoiceNumber;vInvoiceNumber;"";vFromAccount;vAmount;vCurrency;False;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;vCustomerID;0;0;0;True)
	//$registerID:=createRegisterFromTable (vBranchID;->[Invoices];vInvoiceNumber;vInvoiceNumber;"";vToAccount;vAmount;vCurrency;True;vInvoiceDate;vInvoiceDate;->vFullComments;0;0;0;0;vCustomerID;0;0;0;True)
End if 

//CREATE RECORD([Registers])  ` deposit into Account
//[Registers]AccountID:=vToAccount
//[Registers]RegisterType:="Transfer"
//[Registers]RegisterDate:=vTransferDate
//[Registers]CustomerID:="self"  ` means us
//[Registers]Debit:=vToAmount
//[Registers]isReceived:=True
//[Registers]Comments:=vFullComments
//[Registers]InvoiceNumber:=$transferID
//[Registers]Currency:=vToCurrency
//SAVE RECORD([Registers])
//UNLOAD RECORD([Registers])  ` unlock the record for modification

//validatetransaction
//Else 
//REJECT
//End if 
