//%attributes = {}
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)

C_LONGINT:C283($i; $n)

// init the listbox itself
ARRAY BOOLEAN:C223(holdingsListBox; 0)

// Init the listbox arrays first
ARRAY TEXT:C222(arrCustGroups; 0)
ARRAY REAL:C219(arrIns; 0)
ARRAY REAL:C219(arrOuts; 0)
ARRAY REAL:C219(arrCost; 0)
ARRAY REAL:C219(arrRevenues; 0)
ARRAY LONGINT:C221(arrCountIns; 0)
ARRAY LONGINT:C221(arrCountOuts; 0)
ARRAY REAL:C219(arrProfits; 0)
ARRAY REAL:C219(arrFees; 0)



QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY)  // filter local currency out

RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // only select the relevant customers
ORDER BY:C49([Customers:3]; [Customers:3]GroupName:90; >)

DISTINCT VALUES:C339([Customers:3]GroupName:90; arrCustGroups)

$n:=Size of array:C274(arrCustGroups)


// resizing the arrays
ARRAY REAL:C219(arrIns; $n)
ARRAY REAL:C219(arrOuts; $n)
ARRAY REAL:C219(arrCost; $n)
ARRAY REAL:C219(arrRevenues; $n)
ARRAY LONGINT:C221(arrCountIns; $n)
ARRAY LONGINT:C221(arrCountOuts; $n)
ARRAY REAL:C219(arrProfits; $n)
ARRAY REAL:C219(arrFees; $n)


C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
$tablePtr:=->[Customers:3]

$progress:=launchProgressBar("")
//$n:=Records in selection($tablePtr->)
$i:=1

C_LONGINT:C283($count)
C_REAL:C285($balance)
C_TEXT:C284($groupName)

If ($n>0)
	
	Repeat 
		
		$groupName:=arrCustGroups{$i}
		queryRegistersByCustomerGroup($groupName; vFromDate; vToDate; True:C214; True:C214; True:C214; vBranchID)
		
		getRegisterSums(->arrCost{$i}; ->arrRevenues{$i}; ->$balance; ->arrFees{$i}; ->arrProfits{$i})
		
		$count:=Records in selection:C76([Registers:10])  // total number of transactions
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)
		arrCountIns{$i}:=Records in selection:C76([Registers:10])
		arrCountOuts{$i}:=$count-arrCountIns{$i}  // deduct the total number of transactions from the 'buy' ones
		
		If ($groupName="")
			arrCustGroups{$i}:="Unassigned"
		End if 
		
		$i:=$i+1
		
	Until (($i>$n) | (isProgressBarStopped($progress)))
	
End if 

HIDE PROCESS:C324($progress)
