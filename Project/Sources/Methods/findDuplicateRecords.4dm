//%attributes = {"shared":true}
// findDuplicateRecords (->[table];->field)
// looks and selects duplicate record based on field by field comparison
// PRE: Selection must be valid - only works on selection
// POST: Will only select the duplicate records, not the original record

//Unit test not complete

C_TEXT:C284($CID1; $CID2; $dupSet)
C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n; $iType)
C_POINTER:C301($tablePtr; $fieldPtr; $1; $2)
C_BOOLEAN:C305($3; $bShowBoth)

$tablePtr:=$1  // change this table to any table that you are working on
$fieldPtr:=$2

If (Count parameters:C259>=3)
	$bShowBoth:=$3
Else 
	$bShowBoth:=False:C215
End if 

FIRST RECORD:C50($tablePtr->)

$dupSet:="$DUPLICATE"+Table name:C256($tablePtr)

READ ONLY:C145($tablePtr->)

CREATE EMPTY SET:C140($tablePtr->; $dupSet)
//ALL RECORDS($tablePtr->)
ORDER BY:C49($tablePtr->; $fieldPtr->; >)
FIRST RECORD:C50($tablePtr->)
LOAD RECORD:C52($tablePtr->)
$CID1:=$fieldPtr->

$progress:=launchProgressBar("Finding duplicate records...")
$n:=Records in selection:C76($tablePtr->)
$i:=2

Repeat 
	GOTO SELECTED RECORD:C245($tablePtr->; $i)
	LOAD RECORD:C52($tablePtr->)
	
	$CID2:=$fieldPtr->
	
	If ($CID1=$CID2)  // the record is duplicate
		// add to 
		ADD TO SET:C119($tablePtr->; $dupSet)
	Else 
		$CID1:=$CID2
	End if 
	
	refreshProgressBar($progress; $i; $n)
	setProgressBarTitle($progress; "Processing :"+String:C10($i))
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)

//HIGHLIGHT RECORDS($dupSet)

USE SET:C118($dupSet)

If ($bShowBoth)
	$iType:=Type:C295($fieldPtr->)
	
	Case of 
		: ($iType=Is text:K8:3) | ($iType=Is alpha field:K8:1)
			ARRAY TEXT:C222($atID; 0)
			SELECTION TO ARRAY:C260($fieldPtr->; $atID)
			QUERY WITH ARRAY:C644($fieldPtr->; $atID)
			
		: ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
			ARRAY LONGINT:C221($aiID; 0)
			SELECTION TO ARRAY:C260($fieldPtr->; $aiID)
			QUERY WITH ARRAY:C644($fieldPtr->; $aiID)
			
		: ($iType=Is real:K8:4)
			ARRAY REAL:C219($arID; 0)
			SELECTION TO ARRAY:C260($fieldPtr->; $arID)
			QUERY WITH ARRAY:C644($fieldPtr->; $arID)
			
	End case 
	
End if 

CLEAR SET:C117($dupSet)
