//author: Amir
//date: 12th Nov 2018
//expense and revenue transaction summary form
C_LONGINT:C283($formEvent)
C_DATE:C307(vFromDate; vToDate)
C_POINTER:C301(showExpenseRdButtonPtr)
C_POINTER:C301(showIncomeRdButtonPtr)
C_TEXT:C284(vBranchID)
C_LONGINT:C283($accountType)
C_POINTER:C301(listBoxPtr)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)  //by default showing expense
		listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "summaryListBox")
		OBJECT SET TITLE:C194(*; "ReportTitle"; "Expense Summary")
		showExpenseRdButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showExpenseRdButton")
		showIncomeRdButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showIncomeRdButton")
		showExpenseRdButtonPtr->:=1
		
		ARRAY TEXT:C222(arrAccountCode; 0)
		ARRAY TEXT:C222(arrAccountID; 0)
		ARRAY TEXT:C222(arrSubAccountID; 0)
		ARRAY REAL:C219(arrBalanceChange; 0)
		ARRAY TEXT:C222(arrAccountIdDetail; 0)
		ARRAY TEXT:C222(arrBranchID; 0)
		ARRAY TEXT:C222(arrRegisterID; 0)
		ARRAY DATE:C224(arrRegisterDate; 0)
		ARRAY TEXT:C222(arrInvoiceNumber; 0)
		ARRAY TEXT:C222(arrValidation; 0)
		ARRAY REAL:C219(arrAmount; 0)
		ARRAY TEXT:C222(arrAccountDescription; 0)
		C_REAL:C285(vSumAllExpenses)  //for sum in the footer of details form
	: ($formEvent=On Outside Call:K2:11)
		listbox_deleteAllRows(listBoxPtr)
		listbox_deleteAllRows(->detailListBox)
		READ ONLY:C145([Registers:10])
		READ ONLY:C145([Accounts:9])
		//show expense or revenue
		If (showExpenseRdButtonPtr->=1)  //expense
			$accountType:=5
			OBJECT SET TITLE:C194(*; "ReportTitle"; "Expense Summary")
		Else   //revenue
			$accountType:=4
			OBJECT SET TITLE:C194(*; "ReportTitle"; "Income Summary")
		End if 
		QUERY:C277([Accounts:9]; [Accounts:9]Type:36=$accountType)
		RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
		If (vBranchId#"")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=vBranchId; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
		Else 
			QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
		End if 
		QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23#0; *)
		QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]CreditLocal:24#0)
		ORDER BY:C49([Registers:10]; [Registers:10]AccountID:6; >; [Registers:10]SubAccountID:58; >)
		calculateAccountTransactSummary(listBoxPtr; ->detailListBox; ->arrAccountIdDetail; ->arrBranchID; ->arrRegisterID; ->arrRegisterDate; ->arrInvoiceNumber; ->arrValidation; ->arrSubAccountID; ->arrAmount; ->arrAccountID; ->arrBalanceChange; ->arrAccountCode; ->arrAccountDescription; ->vSumAllExpenses)
		
End case 