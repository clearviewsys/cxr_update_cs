//%attributes = {}
// getColumnClicked ($listboxPtr)
// Gets the pointer of the column where a click occurred

C_POINTER:C301($1; $listboxPtr; $4; $colPtr)
C_LONGINT:C283($mouseX; $mouseY)
C_POINTER:C301($0; $columnPtr)

Case of 
	: (Count parameters:C259=4)
		$listboxPtr:=$1
		$mouseX:=$2
		$mouseY:=$3
		$colPtr:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($arrColNames; 0)
ARRAY POINTER:C280($arrColVars; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)

ARRAY POINTER:C280($arrStyles; 0)
ARRAY TEXT:C222($arrFooterNames; 0)
ARRAY POINTER:C280($arrFooterVars; 0)
ARRAY BOOLEAN:C223($arrColsVisible; 0)

C_LONGINT:C283($i; $col; $left; $top; $right; $bottom; $mouseX; $mouseY; $colNumber)
LISTBOX GET ARRAYS:C832($listboxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)


For ($i; 1; Size of array:C274($arrColNames))
	//ListboxGetColCoords ($listboxPtr;$arrColNames{$i};->$left;->$top;->$right;->$bottom)
	OBJECT GET COORDINATES:C663(*; $arrColNames{$i}; $left; $top; $right; $bottom)
	If ($colPtr=$arrHeaderVars{$i})
		//TRACE
	End if 
	
	If (($mouseX>=$left) & ($mouseX<=$right))
		$colNumber:=$i
		//$i:=Size of array($arrColNames)+1
	End if 
End for 
$columnPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $arrColNames{$colNumber})  // Column pointer for size
$0:=$columnPtr

