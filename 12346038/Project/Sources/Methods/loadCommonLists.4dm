//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 07/23/18, 18:32:38
// ----------------------------------------------------
// Method: loadCommonLists
// Description
//   updates the list = "commonLists" with data stored in [CommonLists] table
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($iList; $i; $iFound)


ARRAY TEXT:C222($atListNames; 0)

$iList:=Load list:C383("CommonLists")

ALL RECORDS:C47([CommonLists:84])
DISTINCT VALUES:C339([CommonLists:84]ListName:1; $atListNames)

For ($i; 1; Size of array:C274($atListNames))
	$iFound:=Find in list:C952($iList; $atListNames{$i}; 0)
	
	If ($iFound=0)  //need to add the list
		APPEND TO LIST:C376($iList; $atListNames{$i}; Count list items:C380($iList; *)+1)
	End if 
End for 

SAVE LIST:C384($iList; "CommonLists")

UNLOAD RECORD:C212([CommonLists:84])
REDUCE SELECTION:C351([CommonLists:84]; 0)