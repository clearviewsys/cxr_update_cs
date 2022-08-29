//%attributes = {}
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)

C_LONGINT:C283($i; $n)

// init the listbox itself
ARRAY BOOLEAN:C223(holdingsListBox; 0)

// Init the listbox arrays first
ARRAY REAL:C219(arrIns; 0)
ARRAY REAL:C219(arrOuts; 0)
ARRAY LONGINT:C221(arrCountIns; 0)
ARRAY LONGINT:C221(arrCountOuts; 0)
ARRAY REAL:C219(arrPurchaseLC; 0)
ARRAY REAL:C219(arrSoldLC; 0)
ARRAY BOOLEAN:C223(arrIsCorp; 0)
ARRAY REAL:C219(arrProfits; 0)

READ ONLY:C145([Registers:10])
READ ONLY:C145([Customers:3])


If (vBranchID#"")
	QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchID)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
Else 
	QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
End if 

QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY)  // filter local currency out
QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)

RELATE ONE SELECTION:C349([Registers:10]; [Customers:3])  // only select the relevant customers


ORDER BY:C49([Customers:3]; [Customers:3]GroupName:90; >; [Customers:3]FullName:40; >)
$n:=Records in selection:C76([Customers:3])
//DISTINCT VALUES([Customers]CustomerID;ARRCUSTID)
//$n:=Size of array(arrCustID)
LISTBOX INSERT ROWS:C913(holdingsListBox; 1; $n)
//
//For ($i;1;$n)
//arrCustNames{$i}:=""
//arrCustGroups{$i}:=""
//arrIsCorp{$i}:=false
//end for

SELECTION TO ARRAY:C260([Customers:3]CustomerID:1; arrCustID; [Customers:3]FullName:40; arrCustNames; [Customers:3]GroupName:90; arrCustGroups; [Customers:3]isCompany:41; arrIsCorp)


C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)
$tablePtr:=->[Customers:3]


$progress:=launchProgressBar("")
$n:=Records in selection:C76($tablePtr->)
$i:=1

C_TEXT:C284($customerID)
C_LONGINT:C283($count)
C_REAL:C285($balance)

If (($n>0) & (OK=1))
	
	Repeat 
		
		$customerID:=arrCustID{$i}
		selectRegistersByCustomerID($customerID; vFromDate; vToDate; True:C214; True:C214; True:C214; vBranchID)
		getRegisterSums(->arrCost{$i}; ->arrRevenues{$i}; ->$balance; ->arrFees{$i}; ->arrProfits{$i})
		
		$count:=Records in selection:C76([Registers:10])  // total number of transactions
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)
		arrCountIns{$i}:=Records in selection:C76([Registers:10])
		arrCountOuts{$i}:=$count-arrCountIns{$i}  // deduct the total number of transactions from the 'buy' ones
		
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
	
End if 

HIDE PROCESS:C324($progress)
