//%attributes = {}
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($1; $fromWebewire)
C_TEXT:C284($2; $reason)
C_TEXT:C284($comments)
C_LONGINT:C283($i; $n)

$0:=False:C215

If (Count parameters:C259>0)
	$fromWebewire:=$1
Else 
	$fromWebewire:=False:C215
End if 

If (Count parameters:C259>=2)
	$reason:=$2
Else 
	$reason:=""
End if 

checkInit

checkAddErrorIf((Records in selection:C76([Invoices:5])#1); "Only one invoice must be selected.")
If (Records in selection:C76([Invoices:5])=1)
	LOAD RECORD:C52([Invoices:5])
	checkAddErrorIf([Invoices:5]isCancelled:84=True:C214; "Invoice has already been cancelled once.")
	
	// even managers cannot cancel an invoice past the same day
	checkAddErrorIf([Invoices:5]CreationDate:13<Current date:C33; "This invoice was created in the past and cannot be cancelled now.")
	
	// verify to make sure that the invoice does not contain any validated lines
	// verify to make sure that the invoice is cash only
	// verify to make sure that the user is manager only
	
	checkAddErrorIf(Not:C34(isUserManager); "Only branch managers can VOID an invoice")
	
	If (Not:C34($fromWebewire))
		checkAddErrorIf(Not:C34(isInvoiceCashOnly([Invoices:5]InvoiceID:1)); "You can only VOID Cash-based Invoices")
	End if 
	
	checkAddErrorIf(doesInvoiceHaveValidatedRows([Invoices:5]InvoiceID:1); "This invoice contains at least 1 validated register!")
	
	// check here if inovice is connected to Web Ewire (MoneyGram) transaction -- to implement
	C_OBJECT:C1216($webewire)
	
	If (Not:C34($fromWebewire))
		
		$webewire:=ds:C1482.WebEWires.query("paymentInfo.invoiceID = :1"; [Invoices:5]InvoiceID:1).first()
		
		If ($webewire#Null:C1517)
			If (Not:C34($webewire.isCancelled))
				checkAddError("Invoice is connected to MoneyGram transaction "+$webewire.WebEwireID\
					+"\nVoid this Inovice by cancelling that transaction.")
			End if 
		End if 
		
	End if 
	
End if 


checkAddWarning("Are you sure you would like to VOID this invoice (THIS ACTION CANNOT BE UNDONE)?")

If (isValidationConfirmed)
	
	REDUCE SELECTION:C351([Invoices:5]; 1)
	
	UNLOAD RECORD:C212([Invoices:5])
	READ WRITE:C146([Invoices:5])
	LOAD RECORD:C52([Invoices:5])
	C_TEXT:C284($invoiceID; $comment)
	
	[Invoices:5]isCancelled:84:=True:C214
	[Invoices:5]comments:43:=$reason
	$invoiceID:=[Invoices:5]InvoiceID:1
	$comments:=[Invoices:5]AutoComments:24
	
	SAVE RECORD:C53([Invoices:5])
	
	
	relateManyRegisters
	UNLOAD RECORD:C212([Invoices:5])
	READ ONLY:C145([Invoices:5])
	LOAD RECORD:C52([Invoices:5])
	
	READ WRITE:C146([Registers:10])
	$n:=Records in selection:C76([Registers:10])
	COPY NAMED SELECTION:C331([Registers:10]; "$registersToClear")
	
	
	For ($i; 1; $n)  // there are two records
		USE NAMED SELECTION:C332("$registersToClear")
		GOTO SELECTED RECORD:C245([Registers:10]; $i)
		
		// first load the register and set it to 'cancelled'
		LOAD RECORD:C52([Registers:10])
		[Registers:10]isCancelled:59:=True:C214
		SAVE RECORD:C53([Registers:10])
		
		// duplicate the record and reverse the amount to nullify the effect
		DUPLICATE RECORD:C225([Registers:10])
		[Registers:10]ModifiedByUserID:22:=getApplicationUser
		[Registers:10]RegisterID:1:=[Registers:10]RegisterID:1+"."
		[Registers:10]Debit:8:=-[Registers:10]Debit:8
		[Registers:10]Credit:7:=-[Registers:10]Credit:7
		[Registers:10]DebitLocal:23:=-[Registers:10]DebitLocal:23
		[Registers:10]CreditLocal:24:=-[Registers:10]CreditLocal:24
		
		[Registers:10]_Sync_ID:54:=""  //2/21/16 IBB
		SET BLOB SIZE:C606([Registers:10]_Sync_Data:55; 0)  //2/21/16 IBB
		
		SAVE RECORD:C53([Registers:10])
		UNLOAD RECORD:C212([Registers:10])
		
		
	End for 
	
	READ ONLY:C145([Registers:10])
	CLEAR NAMED SELECTION:C333("$registersToClear")
	createRecordExceptionLog(->[Invoices:5]; "Invoice Cancelled:"+$invoiceID; $invoiceID; $comments)
	
	myAlert("Invoice successfully cancelled.")
	
	$0:=True:C214
	
End if 
