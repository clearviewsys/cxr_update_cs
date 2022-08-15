//%attributes = {}
// handleFillCurrencySummaryTable

C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
C_LONGINT:C283($i; $n)

// init the listbox itself
ARRAY BOOLEAN:C223(holdingsListBox; 0)

// Init the listbox arrays first
ARRAY PICTURE:C279(arrFlags; 0)
ARRAY TEXT:C222(arrCodes; 0)
ARRAY TEXT:C222($isoCodes; 0)
ARRAY REAL:C219(arrIns; 0)
ARRAY REAL:C219(arrOuts; 0)
ARRAY LONGINT:C221(arrCountIns; 0)
ARRAY LONGINT:C221(arrCountOuts; 0)

ARRAY REAL:C219(arrCost; 0)
ARRAY REAL:C219(arrRevenues; 0)

READ ONLY:C145([Currencies:6])
READ ONLY:C145([Registers:10])

C_POINTER:C301($showAllPtr)
$showAllPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showAll")

If ($showAllPtr->=1)
	ALL RECORDS:C47([Currencies:6])
Else 
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
	If (vBranchID#"")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchID)
	End if 
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)  // remove cancellations
	QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)  // remove transfers
	
	RELATE ONE SELECTION:C349([Registers:10]; [Currencies:6])  // only select the relevant registers
End if 

orderByCurrencies
DISTINCT VALUES:C339([Currencies:6]ISO4217:31; $isoCodes)  // copy only the unique values
$n:=Size of array:C274($isoCodes)
LISTBOX INSERT ROWS:C913(holdingsListBox; 1; $n)
COPY ARRAY:C226($isoCodes; arrCodes)
ASSERT:C1129(Size of array:C274(arrCodes)=$n; "array arrCodes has not been resized")

For ($i; 1; $n)
	QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=arrCodes{$i})  // search for the code
	LOAD RECORD:C52([Currencies:6])
	arrFlags{$i}:=[Currencies:6]Flag:3
	arrCurrencies{$i}:=[Currencies:6]Name:2
End for 

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
$tablePtr:=->[Currencies:6]


$progress:=launchProgressBar("Calculating Currencies Summary")
$i:=1

C_TEXT:C284($curr)
C_LONGINT:C283($count)
C_REAL:C285($balance)

If ($n>0)
	
	Repeat 
		$curr:=arrCodes{$i}
		selectRegistersbyCurrency($curr; vFromDate; vToDate; True:C214; True:C214; vBranchID)
		
		getRegisterSums(->arrCost{$i}; ->arrRevenues{$i}; ->$balance; ->arrIns{$i}; ->arrOuts{$i}; ->$balance)
		If ($curr=<>BASECURRENCY)
			arrRevenues{$i}:=0
			arrCost{$i}:=0
		End if 
		
		$count:=Records in selection:C76([Registers:10])  // total number of transactions
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)
		arrCountIns{$i}:=Records in selection:C76([Registers:10])
		arrCountOuts{$i}:=$count-arrCountIns{$i}  // deduct the total number of transactions from the 'buy' ones
		
		$i:=$i+1
		refreshProgressBar($progress; $i; $n)
	Until (($i>$n) | (isProgressBarStopped($progress)))
	
End if 

HIDE PROCESS:C324($progress)
