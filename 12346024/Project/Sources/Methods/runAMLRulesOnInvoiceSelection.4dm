//%attributes = {}
// runAMLRulesOnInvoiceSelection
C_POINTER:C301($tablePtr)
C_LONGINT:C283($progress; $i; $n)

QUERY SELECTION:C341([Invoices:5]; [Invoices:5]isCancelled:84=False:C215)  // filter cancelled ones
$tablePtr:=->[Invoices:5]  // change this table to any table that you are working on
$progress:=launchProgressBar("Progress Bar...")
$n:=Records in selection:C76($tablePtr->)
$i:=1

FIRST RECORD:C50($tablePtr->)

Repeat 
	GOTO SELECTED RECORD:C245([Invoices:5]; $i)
	LOAD RECORD:C52($tablePtr->)
	// do anything you wish in this section
	
	RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the related customer
	checkInit
	validateInvoice_AML_AggrRules(False:C215)
	
	NEXT RECORD:C51($tablePtr->)
	
	refreshProgressBar($progress; $i; $n)
	setProgressBarTitle($progress; "Running AML Rules on Invoice :"+[Invoices:5]InvoiceID:1)
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)