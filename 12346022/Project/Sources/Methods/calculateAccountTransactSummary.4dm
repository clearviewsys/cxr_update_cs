//%attributes = {}
//author: Amir
//date: 12th Nov. 2018
//calculateAccountTransactSummary(
//    ->listboxSummary; (for first page of form)
//    ->listboxDetails; (for second page of form)
//    ->arrAccountIdDetail
//    ->arrBranchID
//    ->arrRegisterID
//    ->arrRegisterDate
//    ->arrInvoiceNumber
//    ->arrValidation
//    ->arrSubAccountID
//    ->arrAmount
//    ->arrAccountId;
//    ->arrBalanceChange
//    ->arrAccountCode
//     )
//used for calculating Account summary of different types of accounts (Expense, Revenue, ...)
//used with Screen Reports (SR_ExpenseTransactionSummary and SR_RevenueTransactionSummary)
//assuming [Registers] have proper selection and they are ordered by account ID and sub account ID
//fills the arrays of both listboxes in the form (1st and 2nd page)
C_POINTER:C301($1; $listboxSummaryPtr)
C_POINTER:C301($2; $listboxDetailPtr)
C_POINTER:C301($3; $arrAccountIdDetailPtr)
C_POINTER:C301($4; $arrBranchIDPtr)
C_POINTER:C301($5; $arrRegisterIDPtr)
C_POINTER:C301($6; $arrRegisterDatePtr)
C_POINTER:C301($7; $arrInvoiceNumberPtr)
C_POINTER:C301($8; $arrValidationPtr)
C_POINTER:C301($9; $arrSubAccountIDPtr)
C_POINTER:C301($10; $arrAmountPtr)
C_POINTER:C301($11; $arrAccountIdPtr)
C_POINTER:C301($12; $arrBalanceChangePtr)
C_POINTER:C301($13; $arrAccountCodePtr)
C_POINTER:C301($14; $arrAccountDescriptionPtr)
C_POINTER:C301($15; $vSumPtr)
ASSERT:C1129(Count parameters:C259=15; "Expected 15 parameters")
$listboxSummaryPtr:=$1
$listboxDetailPtr:=$2
$arrAccountIdDetailPtr:=$3  //AccountIDs for detail list box (2nd page)
$arrBranchIDPtr:=$4
$arrRegisterIDPtr:=$5
$arrRegisterDatePtr:=$6
$arrInvoiceNumberPtr:=$7
$arrValidationPtr:=$8
$arrSubAccountIDPtr:=$9
$arrAmountPtr:=$10
$arrAccountIdPtr:=$11  //AccountIDs for summary list box (1st page)
$arrBalanceChangePtr:=$12
$arrAccountCodePtr:=$13
$arrAccountDescriptionPtr:=$14
$vSumPtr:=$15  //sum of all registers for details form (footer)
READ ONLY:C145([Registers:10])
C_LONGINT:C283($registerIndex; $numRegisters; $listboxDetailIndex; $listboxSummaryIndex)
C_REAL:C285($accountBalance; $subAccountSubTotal)
C_TEXT:C284($previousAccountID; $previousAccountCode; $previousSubAccountID; $previousAccountDescription)
C_LONGINT:C283($progress)
C_BOOLEAN:C305($isLoopStopped)
$numRegisters:=Records in selection:C76([Registers:10])
$listboxSummaryIndex:=1
$listboxDetailIndex:=1
FIRST RECORD:C50([Registers:10])
$progress:=launchProgressBar("Calculating transactions summary")
$previousAccountID:=[Registers:10]AccountID:6
$previousSubAccountID:=[Registers:10]SubAccountID:58
RELATE ONE:C42([Registers:10]AccountID:6)
$previousAccountCode:=[Accounts:9]AccountCode:4
$previousAccountDescription:=[Accounts:9]AccountDescription:17
$accountBalance:=0
$subAccountSubTotal:=0
$vSumPtr->:=0
For ($registerIndex; 1; $numRegisters)
	Case of 
		: (($previousAccountID=[Registers:10]AccountID:6) & ($previousSubAccountID=[Registers:10]SubAccountID:58))
			$subAccountSubTotal:=$subAccountSubTotal+[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
		: (($previousAccountID=[Registers:10]AccountID:6) & ($previousSubAccountID#[Registers:10]SubAccountID:58))
			//insert subaccount subtotal row in details listbox
			$listboxDetailIndex:=listbox_appendRow($listboxDetailPtr)
			$arrAccountIdDetailPtr->{$listboxDetailIndex}:=$previousAccountID
			$arrSubAccountIDPtr->{$listboxDetailIndex}:=$previousSubAccountID
			$arrRegisterIDPtr->{$listboxDetailIndex}:="Subtotal"
			$arrAmountPtr->{$listboxDetailIndex}:=$subAccountSubTotal
			$subAccountSubTotal:=[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
		: ($previousAccountID#[Registers:10]AccountID:6)
			//insert account subtotal row in details listbox
			$listboxDetailIndex:=listbox_appendRow($listboxDetailPtr)
			$arrAccountIdDetailPtr->{$listboxDetailIndex}:=$previousAccountID
			$arrSubAccountIDPtr->{$listboxDetailIndex}:=$previousSubAccountID
			$arrRegisterIDPtr->{$listboxDetailIndex}:="Subtotal "+$previousAccountID
			$arrAmountPtr->{$listboxDetailIndex}:=$accountBalance
	End case 
	//---------------------------------------------
	//values for summary page list box (page 1)
	//------------------------------------------------------
	If ($previousAccountID=[Registers:10]AccountID:6)  //same account: add values
		$accountBalance:=$accountBalance+[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
	Else   //different account: save previous value
		$listboxSummaryIndex:=listbox_appendRow($listboxSummaryPtr)
		$arrAccountCodePtr->{$listboxSummaryIndex}:=$previousAccountCode
		$arrAccountIdPtr->{$listboxSummaryIndex}:=$previousAccountID
		$arrAccountDescriptionPtr->{$listboxSummaryIndex}:=$previousAccountDescription
		$arrBalanceChangePtr->{$listboxSummaryIndex}:=$accountBalance
		//reset value for next iteration
		$accountBalance:=[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
	End if 
	//------------------------------------------------------
	//inserting current Register values for detailed page list box (page 2)
	//------------------------------------------------------
	$listboxDetailIndex:=listbox_appendRow($listboxDetailPtr)
	$arrAccountIdDetailPtr->{$listboxDetailIndex}:=[Registers:10]AccountID:6
	$arrSubAccountIDPtr->{$listboxDetailIndex}:=[Registers:10]SubAccountID:58
	$arrBranchIDPtr->{$listboxDetailIndex}:=[Registers:10]BranchID:39
	$arrRegisterIDPtr->{$listboxDetailIndex}:=[Registers:10]RegisterID:1
	$arrRegisterDatePtr->{$listboxDetailIndex}:=[Registers:10]RegisterDate:2
	$arrInvoiceNumberPtr->{$listboxDetailIndex}:=[Registers:10]InvoiceNumber:10
	If ([Registers:10]isValidated:35)
		$arrValidationPtr->{$listboxDetailIndex}:="Yes"
	Else 
		$arrValidationPtr->{$listboxDetailIndex}:="No"
	End if 
	$arrAmountPtr->{$listboxDetailIndex}:=[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
	$vSumPtr->:=$vSumPtr->+[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
	//reset values
	$previousAccountID:=[Registers:10]AccountID:6
	$previousSubAccountID:=[Registers:10]SubAccountID:58
	RELATE ONE:C42([Registers:10]AccountID:6)
	$previousAccountCode:=[Accounts:9]AccountCode:4
	$previousAccountDescription:=[Accounts:9]AccountDescription:17
	NEXT RECORD:C51([Registers:10])
	If ($registerIndex%20=1)
		refreshProgressBar($progress; $registerIndex; $numRegisters)
	End if 
	If (isProgressBarStopped($progress))
		$registerIndex:=$numRegisters+1  //break the loop
		$isLoopStopped:=True:C214
	End if 
End for 
If ((Not:C34($isLoopStopped)) & ($numRegisters>0))
	//if loop was not stopped, save last result (last result is not saved and needs to be saved seperately)
	$listboxSummaryIndex:=listbox_appendRow($listboxSummaryPtr)
	RELATE ONE:C42([Registers:10]AccountID:6)
	$arrAccountCodePtr->{$listboxSummaryIndex}:=$previousAccountCode
	$arrAccountIdPtr->{$listboxSummaryIndex}:=$previousAccountID
	$arrBalanceChangePtr->{$listboxSummaryIndex}:=$accountBalance
	//add the subtotal row for last set of registers
	$listboxDetailIndex:=listbox_appendRow($listboxDetailPtr)
	$arrAccountIdDetailPtr->{$listboxDetailIndex}:=$previousAccountID
	$arrSubAccountIDPtr->{$listboxDetailIndex}:=$previousSubAccountID
	$arrRegisterIDPtr->{$listboxDetailIndex}:="Subtotal "+$previousAccountID
	$arrAmountPtr->{$listboxDetailIndex}:=$accountBalance
End if 
HIDE PROCESS:C324($progress)