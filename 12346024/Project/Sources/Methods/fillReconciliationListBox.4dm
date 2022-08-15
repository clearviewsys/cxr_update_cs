//%attributes = {}
// fillReconciliationListBox
// PRE: selection of [registers] must be done in advance
// POST: this will populate all the reconciliation arrays... all unsaved recocilation will be lost
C_LONGINT:C283($i; $n)

ARRAY TEXT:C222(arrValidator; 0)
ARRAY TEXT:C222(arrComments; 0)
ARRAY DATE:C224(arrDates; 0)
ARRAY BOOLEAN:C223(arrChecked; 0)
ARRAY BOOLEAN:C223(arrOldChecked; 0)  // to keep the original value (before any modification is done)

ARRAY TEXT:C222(arrValidation; 0)
ARRAY TEXT:C222(arrOldValidation; 0)  // to keep the original value (before any modification is done)

ARRAY REAL:C219(arrDebits; 0)
ARRAY REAL:C219(arrCredits; 0)
ARRAY REAL:C219(arrBalances; 0)
ARRAY TEXT:C222(arrRegisterIDs; 0)
ARRAY TEXT:C222(arrExternalRefs; 0)
ARRAY INTEGER:C220(arrExternalTableNums; 0)

SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; arrRegisterIDs; [Registers:10]CustomerID:5; arrCustomers; [Registers:10]InternalTableNumber:17; arrExternalTableNums; [Registers:10]validatedByUserID:37; arrValidator; [Registers:10]RegisterDate:2; arrDates; *)
SELECTION TO ARRAY:C260([Registers:10]Comments:9; arrComments; [Registers:10]InvoiceNumber:10; arrInvoiceNumbers; *)
SELECTION TO ARRAY:C260([Registers:10]InternalRecordID:18; arrExternalRefs; *)
SELECTION TO ARRAY:C260([Registers:10]isValidated:35; arrChecked; *)
SELECTION TO ARRAY:C260([Registers:10]isValidated:35; arrOldChecked; *)
SELECTION TO ARRAY:C260([Registers:10]validationCode:36; arrValidation; *)
SELECTION TO ARRAY:C260([Registers:10]validationCode:36; arrOldValidation; *)
SELECTION TO ARRAY:C260([Registers:10]Debit:8; arrDebits; [Registers:10]Credit:7; arrCredits)

$n:=Size of array:C274(arrDates)
ARRAY BOOLEAN:C223(reconcileList; $n)
ARRAY REAL:C219(arrBalances; $n)
ARRAY TEXT:C222(arrChequeNumbers; $n)
ARRAY BOOLEAN:C223(arrHiddenRows; $n)
C_LONGINT:C283($tableNum)

For ($i; 1; $n)
	$tableNum:=arrExternalTableNums{$i}
	Case of 
		: ($tableNum=Table:C252(->[Cheques:1]))  // if the external reference is a cheque
			QUERY:C277([Cheques:1]; [Cheques:1]ChequeID:1=arrExternalRefs{$i})
			arrChequeNumbers{$i}:=[Cheques:1]ChequeNumber:4
			
		: ($tableNum=Table:C252(->[AccountInOuts:37]))  // if the external reference is an accountInOuts
			QUERY:C277([AccountInOuts:37]; [AccountInOuts:37]ReferenceNo:22=arrExternalRefs{$i})
			arrChequeNumbers{$i}:=[AccountInOuts:37]ReferenceNo:22
			
		: ($tableNum=Table:C252(->[Wires:8]))  // if the external reference is a wire
			QUERY:C277([Wires:8]; [Wires:8]WireNo:48=arrExternalRefs{$i})
			arrChequeNumbers{$i}:=[Wires:8]WireNo:48
			
		Else 
			arrChequeNumbers{$i}:=""
	End case 
	selectCustomerByID(arrCustomers{$i})
	arrCustomers{$i}:=[Customers:3]FullName:40
End for 

