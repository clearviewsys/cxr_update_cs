//%attributes = {}
// handleSR_LCTByCustomer
//fills the report for aggregate Customer summary for cash transactions
//author: Amir
//30th August 2018

C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)

C_LONGINT:C283($i; $n)
C_LONGINT:C283($i)
C_TEXT:C284($previousInvoiceID; $previousCustomerName; $previousCustomerID)
C_DATE:C307($previousDate)
C_REAL:C285($tempDebitSum; $tempCreditSum)

ARRAY DATE:C224(arrDates; 0)
ARRAY TEXT:C222(arrCustomerIDs; 0)
ARRAY TEXT:C222(arrCustomerNames; 0)
ARRAY REAL:C219(arrDebitLCs; 0)
ARRAY REAL:C219(arrCreditLCs; 0)

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])

C_POINTER:C301($showCustomerNamesPtr)  //checkbox for showing customer names(faster when not showing names)
C_BOOLEAN:C305($showCustomerNames)
$showCustomerNamesPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showCustomerNames")
If ($showCustomerNamesPtr->=1)
	$showCustomerNames:=True:C214
Else 
	$showCustomerNames:=False:C215
End if 

// Query on registers for LCT
If (vBranchID#"")
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchID)
Else 
	ALL RECORDS:C47([Registers:10])
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCash:40=True:C214)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)

CREATE SET:C116([Registers:10]; "$LCT")
RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // load the related customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]CustomerID:1#"000@")  // filter the walk-in customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isInsider:102=False:C215)  // filter out the insider customers
QUERY SELECTION:C341([Customers:3]; [Customers:3]isMSB:85=False:C215)  // filter out the MSB
QUERY SELECTION:C341([Customers:3]; [Customers:3]isWholesaler:87=False:C215)  // filter out the Wholesalers

RELATE MANY SELECTION:C340([Registers:10]CustomerID:5)  // load the Registers linked to the customers
CREATE SET:C116([Registers:10]; "$NoInsider")
INTERSECTION:C121("$LCT"; "$NoInsider"; "$LCT")  // intersection of LCT registers belonging to non-insiders
USE SET:C118("$LCT")
CLEAR SET:C117("$LCT")  // cleaning up
CLEAR SET:C117("$NoInsider")

$n:=Records in selection:C76([Registers:10])
C_LONGINT:C283($progress; $j)
$progress:=launchProgressBar("Calculating cash summary of customers...")

ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >; [Registers:10]CustomerID:5; >)  // sort registers by their invoice ID
FIRST RECORD:C50([Registers:10])

$previousDate:=[Registers:10]RegisterDate:2
$previousInvoiceID:=[Registers:10]InvoiceNumber:10
$previousCustomerID:=[Registers:10]CustomerID:5
If ($showCustomerNames)
	RELATE ONE:C42([Registers:10]CustomerID:5)  // load the customer record related to this register
	$previousCustomerName:=[Customers:3]FullName:40
End if 
$i:=1  // iterator for registers
$j:=1  // iterator for invoices matching the LCT condition
C_BOOLEAN:C305($isSameDateAndCustomer)

Repeat 
	
	$isSameDateAndCustomer:=(($previousDate=[Registers:10]RegisterDate:2) & ($previousCustomerID=[Registers:10]CustomerID:5))
	
	If ($isSameDateAndCustomer)
		$tempDebitSum:=$tempDebitSum+[Registers:10]DebitLocal:23
		$tempCreditSum:=$tempCreditSum+[Registers:10]CreditLocal:24
	Else 
		//([ServerPrefs];"Preferences")
		//If ((Not([Customers]isInsider)) & (($tempDebitSum>=<>TWOIDSLIMIT) | ($tempCreditSum>=<>TWOIDSLIMIT)))  // conditions met
		If ($tempDebitSum>=<>TWOIDSLIMIT)  // conditions met
			LISTBOX INSERT ROWS:C913(holdingsListBox; $j; 1)
			
			arrDates{$j}:=$previousDate
			arrDebitLCs{$j}:=$tempDebitSum
			arrCreditLCs{$j}:=$tempCreditSum
			If ($showCustomerNames)
				arrCustomerNames{$j}:=$previousCustomerName
			End if 
			arrCustomerIDs{$j}:=$previousCustomerID
			$j:=$j+1  // increment the counter for invoices
		End if 
		
		$previousDate:=[Registers:10]RegisterDate:2
		$previousCustomerID:=[Registers:10]CustomerID:5
		If ($showCustomerNames)
			RELATE ONE:C42([Registers:10]CustomerID:5)  // load the customer record related to this register
			$previousCustomerName:=[Customers:3]FullName:40
		End if 
		$previousInvoiceID:=[Registers:10]InvoiceNumber:10
		$tempDebitSum:=[Registers:10]DebitLocal:23
		$tempCreditSum:=[Registers:10]CreditLocal:24
	End if 
	
	If ($i%10=0)  // refresh progress bar
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Processing :"+String:C10($i)+" of "+String:C10($n))
	End if 
	
	$i:=$i+1
	NEXT RECORD:C51([Registers:10])
	
Until (($i>$n) | (isProgressBarStopped($progress)))

//saving the last record (since every time we saved the previous record, the last record is not saved)
//If ((Not([Customers]isInsider)) & (($tempDebitSum>=<>TWOIDSLIMIT) | ($tempCreditSum>=<>TWOIDSLIMIT)))  // conditions met
If ($tempDebitSum>=<>TWOIDSLIMIT)
	LISTBOX INSERT ROWS:C913(holdingsListBox; $j; 1)
	// handling the last register
	arrDates{$j}:=$previousDate
	arrDebitLCs{$j}:=$tempDebitSum
	arrCreditLCs{$j}:=$tempCreditSum
	If ($showCustomerNames)
		arrCustomerNames{$j}:=$previousCustomerName
	End if 
	arrCustomerIDs{$j}:=$previousCustomerID
End if 

HIDE PROCESS:C324($progress)