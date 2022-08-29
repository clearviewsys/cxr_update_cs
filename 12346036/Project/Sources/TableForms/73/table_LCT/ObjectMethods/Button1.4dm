C_LONGINT:C283(cbIncludeDebit)
C_LONGINT:C283(cbIncludeCredit)

C_REAL:C285(vLowerRangeUSD)

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)

QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19="USD")  // exclude the base currency

Case of 
		
	: ((cbIncludeDebit=0) & (cbIncludeCredit=1))
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Credit:7>vLowerRangeUSD)
		
	: ((cbIncludeDebit=1) & (cbIncludeCredit=0))
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>vLowerRangeUSD)
		
	: ((cbIncludeDebit=1) & (cbIncludeCredit=1))
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Credit:7>vLowerRangeUSD; *)
		QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]Debit:8>vLowerRangeUSD)
		
	: ((cbIncludeDebit=0) & (cbIncludeCredit=0))
		
End case 

C_LONGINT:C283($n)

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)

$tablePtr:=->[Registers:10]  // change this table to any table that you are working on

$n:=Records in selection:C76($tablePtr->)

If ($n>0)
	ARRAY BOOLEAN:C223(reg_RegistersListBox; $n)  // resize all the arrays;
	ARRAY LONGINT:C221(reg_arrRow; $n)
	ARRAY DATE:C224(reg_arrRegisterDate; $n)
	ARRAY TEXT:C222(reg_arrRegisterID; $n)
	ARRAY TEXT:C222(reg_arrCustomerName; $n)
	ARRAY REAL:C219(reg_arrSalesAmount; $n)
	
	$progress:=launchProgressBar("Filling the table...")
	READ ONLY:C145($tablePtr->)
	READ ONLY:C145([Customers:3])
	FIRST RECORD:C50($tablePtr->)
	
	$i:=1
	
	orderByRegisters
	Repeat 
		LOAD RECORD:C52($tablePtr->)
		RELATE ONE:C42([Registers:10]CustomerID:5)
		
		// do anything you wish in this section
		reg_arrRow{$i}:=$i
		reg_arrRegisterDate{$i}:=[Registers:10]RegisterDate:2
		reg_arrRegisterID{$i}:=[Registers:10]RegisterID:1
		reg_arrCustomerName{$i}:=[Customers:3]FullName:40
		reg_arrSalesAmount{$i}:=[Registers:10]Credit:7-[Registers:10]Debit:8
		
		NEXT RECORD:C51($tablePtr->)
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Adding transaction :"+String:C10($i))
		$i:=$i+1
	Until (($i>$n) | (isProgressBarStopped($progress)))
	HIDE PROCESS:C324($progress)
	
End if 

