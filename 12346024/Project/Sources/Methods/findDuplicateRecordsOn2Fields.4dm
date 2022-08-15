//%attributes = {}
// findDuplicateRecords (->[table];->fieldPtr1;->$fieldPtr2)
// looks and selects duplicate record based on field by field comparison


C_TEXT:C284($field1; $field2; $temp1; $temp2; $dupSet)
C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr; $fieldPtr1; $fieldPtr2; $1; $2; $3)

$tablePtr:=$1  // change this table to any table that you are working on
$fieldPtr1:=$2
$fieldPtr2:=$3

FIRST RECORD:C50($tablePtr->)

$dupSet:="$DUPLICATE"+Table name:C256($tablePtr)

READ ONLY:C145($tablePtr->)

CREATE EMPTY SET:C140($tablePtr->; $dupSet)
//ALL RECORDS($tablePtr->)
ORDER BY:C49($tablePtr->; $fieldPtr1->; >; $fieldPtr2->; >)
FIRST RECORD:C50($tablePtr->)
LOAD RECORD:C52($tablePtr->)

$temp1:=String:C10($fieldPtr1->)
$temp2:=String:C10($fieldPtr2->)

$progress:=launchProgressBar("Finding duplicate records...")
$n:=Records in selection:C76($tablePtr->)
$i:=2

Repeat 
	GOTO SELECTED RECORD:C245($tablePtr->; $i)
	LOAD RECORD:C52($tablePtr->)
	
	$field1:=String:C10($fieldPtr1->)
	$field2:=String:C10($fieldPtr2->)
	
	If (($temp1=$field1) & ($temp2=$field2) & ($temp1#"") & ($temp2#""))  // the record is duplicate
		// add to 
		ADD TO SET:C119($tablePtr->; $dupSet)
	Else 
		$temp1:=String:C10($fieldPtr1->)
		$temp2:=String:C10($fieldPtr2->)
	End if 
	
	refreshProgressBar($progress; $i; $n)
	setProgressBarTitle($progress; "Processing :"+String:C10($i))
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)

//HIGHLIGHT RECORDS($dupSet)

USE SET:C118($dupSet)
CLEAR SET:C117($dupSet)
