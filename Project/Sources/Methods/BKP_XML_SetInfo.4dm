//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:27:50
// ----------------------------------------------------
// Method: BKP_XML_SetInfo
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $aInfoLabels; $2; $aInfoValues)
C_TEXT:C284($tXPath)
C_LONGINT:C283($i)
ARRAY TEXT:C222(aDBNames; 0)
ARRAY TEXT:C222(aDBValues; 0)

$aInfoLabels:=$1
$aInfoValues:=$2
$tXPath:="DataBase"

C_POINTER:C301($pVar)

If (BKP_XML_SetGroupArrays($aInfoLabels; $aInfoValues; ->aDBNames; ->aDBValues; $tXPath)#-1)
	
	// we have to prepare these so that they are not named XXXItems1
	For ($i; 1; Size of array:C274(aDBNames))
		aDBNames{$i}:=Replace string:C233(aDBNames{$i}; "/Item1"; "")
	End for 
	
	For ($i; 1; Size of array:C274(aDBNames))
		
		// get the pointer to a variable and its type
		$pVar:=Get pointer:C304(aDBNames{$i})
		
		// set the variable
		BKP_XML_SetVariable($pVar; aDBValues{$i})
		
	End for 
	
End if 