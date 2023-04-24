//%attributes = {}
// agg_runRulesOnInvoices
// formerly: runAMLRulesOnInvoiceSelection
// PRE: can preselect Invoices (using Selection query)


C_POINTER:C301($tablePtr)
C_LONGINT:C283($progress; $i; $n)
C_BOOLEAN:C305($doShowProg)
C_REAL:C285($r)
C_TIME:C306($start)


QUERY SELECTION:C341([Invoices:5]; [Invoices:5]isCancelled:84=False:C215)  // filter cancelled ones
$tablePtr:=->[Invoices:5]  // change this table to any table that you are working on


$doShowProg:=Choose:C955(getKeyValue("AML.rules.progress.show"; "true")="true"; True:C214; False:C215)

If (True:C214)
	If ($doShowProg)
		$start:=Current time:C178
		$progress:=Progress New
	End if 
Else 
	$progress:=launchProgressBar("Progress Bar...")
End if 

$n:=Records in selection:C76($tablePtr->)
$i:=1

FIRST RECORD:C50($tablePtr->)

Repeat 
	GOTO SELECTED RECORD:C245([Invoices:5]; $i)
	LOAD RECORD:C52($tablePtr->)
	// do anything you wish in this section
	
	CAB_log("  Processing rules on invoice: "+[Invoices:5]InvoiceID:1)
	
	RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the related customer
	checkInit
	agg_validateInvoiceOnSave(False:C215)
	
	//NEXT RECORD($tablePtr->)
	UNLOAD RECORD:C212($tablePtr->)  //11/26/22 changed to unload
	
	If (True:C214)
		If ($doShowProg)
			If (Mod:C98($i; 100)=0)
				Progress SET TITLE($progress; "Running AML Rules on Invoice:  "+[Invoices:5]InvoiceID:1)
				$r:=$i/$n
				Progress SET PROGRESS($progress; $r; String:C10($i)+" of "+String:C10($n)+" elapsed: "+String:C10(Current time:C178-$start))
			End if 
		End if 
	Else 
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Running AML Rules on Invoice :"+[Invoices:5]InvoiceID:1)
	End if 
	
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress) | (Progress Stopped($progress))))

If (True:C214)
	Progress QUIT($progress)
Else 
	HIDE PROCESS:C324($progress)
End if 