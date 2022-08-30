//%attributes = {}
// ListBoxColumnsTitlesToArray ($listboxPtr;$arrTitlesPtr;$arrTitlesVisible;$arrColumnsVarsPtr)

C_POINTER:C301($1; $listboxPtr; $2; $arrTitlesPtr; $3; $arrTitlesHiddenPtr; $4; $arrColumnsVarsPtr)
C_TEXT:C284($title)
C_LONGINT:C283($colWidth)
Case of 
		
	: (Count parameters:C259=4)
		
		$listboxPtr:=$1
		$arrTitlesPtr:=$2
		$arrTitlesHiddenPtr:=$3
		$arrColumnsVarsPtr:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


ARRAY TEXT:C222($arrColNames; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)

ARRAY POINTER:C280($arrColVars; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)

ARRAY BOOLEAN:C223($arrColsVisible; 0)
ARRAY POINTER:C280($arrStyles; 0)

ARRAY TEXT:C222($arrFooterNames; 0)
ARRAY POINTER:C280($arrFooterVars; 0)

LISTBOX GET ARRAYS:C832($listboxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
C_LONGINT:C283($i)

For ($i; 1; Size of array:C274($arrColNames))
	
	$title:=OBJECT Get title:C1068($arrHeaderVars{$i}->)
	$colWidth:=LISTBOX Get column width:C834($arrHeaderVars{$i}->)
	If ($colWidth=0)
		APPEND TO ARRAY:C911($arrTitlesHiddenPtr->; True:C214)
	Else 
		APPEND TO ARRAY:C911($arrTitlesHiddenPtr->; False:C215)
	End if 
	
	APPEND TO ARRAY:C911($arrTitlesPtr->; $title)
	APPEND TO ARRAY:C911($arrColumnsVarsPtr->; $arrHeaderVars{$i})
	
End for 

