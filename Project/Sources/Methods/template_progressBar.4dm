//%attributes = {}
// ProgressBarHandlingTemplate
// see also: progressBarHandlingTemplate

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr)

$tablePtr:=->[CompanyInfo:7]  // change this table to any table that you are working on

$progress:=launchProgressBar("Progress Bar...")
$n:=Records in selection:C76($tablePtr->)
$i:=1

FIRST RECORD:C50($tablePtr->)
Repeat 
	LOAD RECORD:C52($tablePtr->)
	// do anything you wish in this section
	//
	//
	NEXT RECORD:C51($tablePtr->)
	
	refreshProgressBar($progress; $i; $n)
	setProgressBarTitle($progress; "Processing :"+String:C10($i))
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)
