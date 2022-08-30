//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:27:45
// ----------------------------------------------------
// Method: BKP_XML_SetGroupArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2; $3; $4)
C_POINTER:C301($aInfoLabels; $aInfoValues; $aNames; $aValues)
C_TEXT:C284($5; $tXPath)
C_LONGINT:C283($0; $i)

$aInfoLabels:=$1
$aInfoValues:=$2
$aNames:=$3
$aValues:=$4
$tXPath:=$5

// get the necessary info values; disregard "ItemsCount" elements
For ($i; 1; Size of array:C274($aInfoLabels->))
	
	// get all beginning with DataBase
	If ((Position:C15($tXPath; $aInfoLabels->{$i})=1) & (Position:C15("ItemsCount"; $aInfoLabels->{$i})=0))
		
		// put all the array type variables into one if it's an array type without the xpath
		APPEND TO ARRAY:C911($aNames->; Replace string:C233($aInfoLabels->{$i}; $tXPath+"/"; ""))
		APPEND TO ARRAY:C911($aValues->; $aInfoValues->{$i})
		
	End if 
	
End for 

// fail or success codes
If (Size of array:C274($aNames->)>0)
	$0:=0
Else 
	$0:=-1
End if 
