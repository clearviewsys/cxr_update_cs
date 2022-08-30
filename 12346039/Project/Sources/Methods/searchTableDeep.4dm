//%attributes = {}
//searchTableDeep(->[table];"string"; searchSelection:bool)

C_POINTER:C301($tablePtr; $fieldPtr; $1)
C_TEXT:C284($searchStr; $2)
C_BOOLEAN:C305($searchSelection; $3)

C_TEXT:C284($mySet; $mySetFinal; $sourceStr)
C_LONGINT:C283($tableNum; $i; $record)

If (Count parameters:C259=3)
	$searchSelection:=$3
Else 
	$searchSelection:=False:C215
End if 

$tablePtr:=$1
$searchStr:=$2
$tableNum:=Table:C252($tablePtr)

$mySet:="searchSet"+Table name:C256($tablePtr)
$mySetFinal:=$mySet+"_F"

ALL RECORDS:C47($tablePtr->)
FIRST RECORD:C50($tablePtr->)
CREATE EMPTY SET:C140($tablePtr->; $mySetFinal)

C_LONGINT:C283($progress)
C_LONGINT:C283($type)
C_LONGINT:C283($found; $n)
READ ONLY:C145($tablePtr->)

$progress:=launchProgressBar("Deep Search...")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$i:=1
$n:=Get last field number:C255($tablePtr)
Repeat 
	If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:31:49 -- I.Barclay Berry 
		$fieldPtr:=Field:C253($tableNum; $i)
		GET FIELD PROPERTIES:C258($fieldPtr; $type)
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Records matched so far: "+String:C10(Records in set:C195($mySetFinal)))
		
		If (($type=Is alpha field:K8:1) | ($type=Is text:K8:3))
			If ($searchSelection)
				QUERY SELECTION:C341($tablePtr->; $fieldPtr->=("@"+$searchStr+"@"))
			Else 
				QUERY:C277($tablePtr->; $fieldPtr->=("@"+$searchStr+"@"))
			End if 
			ADD TO SET:C119($tablePtr->; $mySetFinal)  // store the result into the final set
		End if 
		
		If ($type=Is date:K8:7)
			If ((Date:C102($searchStr)#nullDate) | ($searchStr="00/00/00"))
				If ($searchSelection)
					QUERY SELECTION:C341($tablePtr->; $fieldPtr->=Date:C102($searchStr))
				Else 
					QUERY:C277($tablePtr->; $fieldPtr->=Date:C102($searchStr))
				End if 
				ADD TO SET:C119($tablePtr->; $mySetFinal)  // store the result into the final set
			End if 
		End if 
		
		If (($type=Is integer:K8:5) | ($type=Is longint:K8:6) | ($type=Is real:K8:4))
			If (Num:C11($searchStr)#0)
				If ($searchSelection)
					QUERY SELECTION:C341($tablePtr->; $fieldPtr->=Num:C11($searchStr))
				Else 
					QUERY:C277($tablePtr->; $fieldPtr->=Num:C11($searchStr))
				End if 
				ADD TO SET:C119($tablePtr->; $mySetFinal)  // store the result into the final set
			End if 
		End if 
	End if 
	
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)

USE SET:C118($mySetFinal)
CLEAR SET:C117($mySetFinal)
//SET QUERY DESTINATION(Into current selection )
