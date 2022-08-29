//%attributes = {}
// listboxGetPreferences (->listbox)
// Gets all Properties of the given listbox
// Created by JA on 3/2/2017

C_POINTER:C301($1; $listboxPtr)
C_OBJECT:C1216($0; $lbProperties)


C_POINTER:C301($ptrNull)

C_LONGINT:C283($maxWidth; $minWidth)
C_LONGINT:C283($numCols; $tableNum; $displayFooter; $displayHeader; $displayHorScrollbar; $displayVerScrollbar)
C_LONGINT:C283($footerHeight; $headerHeight; $horScrollbarHeight; $horScrollbarPosition; $verScrollbarWidth; $verScrollbarPosition)

C_TEXT:C284($lisboxName; $obj)

ARRAY TEXT:C222($arrColNames; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY TEXT:C222($arrFooterNames; 0)

ARRAY TEXT:C222($arrFooterNames; 0)
ARRAY BOOLEAN:C223($arrColsVisible; 0)
ARRAY POINTER:C280($arrFooterVars; 0)
ARRAY POINTER:C280($arrStyles; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)
ARRAY POINTER:C280($arrColVars; 0)

Case of 
	: (Count parameters:C259=1)
		$listboxPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$lisboxName:=OBJECT Get name:C1087(Object current:K67:2)
OB SET:C1220($lbProperties; "lisboxName"; $lisboxName)

$numCols:=LISTBOX Get number of columns:C831($listboxPtr->)
OB SET:C1220($lbProperties; "numCols"; $numCols)

$displayFooter:=LISTBOX Get property:C917($listboxPtr->; lk display footer:K53:20)
OB SET:C1220($lbProperties; "displayFooter"; $displayFooter)

$displayHeader:=LISTBOX Get property:C917($listboxPtr->; lk display header:K53:4)
OB SET:C1220($lbProperties; "displayHeader"; $displayHeader)

// changes because the Update to v17.
//$displayHorScrollbar:=LISTBOX Get property($listboxPtr->;_o_lk display hor scrollbar)
// $displayVerScrollbar:=LISTBOX Get property($listboxPtr->;_o_lk display ver scrollbar)


OBJECT GET SCROLLBAR:C1076($listboxPtr->; $displayHorScrollbar; $displayVerScrollbar)


OB SET:C1220($lbProperties; "displayHorScrollbar"; $displayHorScrollbar)
OB SET:C1220($lbProperties; "displayVerScrollbar"; $displayVerScrollbar)


//$footerHeight:=LISTBOX Get property($listboxPtr->;_o_lk footer height)
//$headerHeight:=LISTBOX Get property($listboxPtr->;_o_lk header height)


$footerHeight:=LISTBOX Get footers height:C1146($listboxPtr->; lk pixels:K53:22)
OB SET:C1220($lbProperties; "footerHeight"; $footerHeight)

$headerHeight:=LISTBOX Get headers height:C1144($listboxPtr->; lk pixels:K53:22)
OB SET:C1220($lbProperties; "headerHeight"; $headerHeight)

$horScrollbarHeight:=LISTBOX Get property:C917($listboxPtr->; lk hor scrollbar height:K53:7)
OB SET:C1220($lbProperties; "horScrollbarHeight"; $horScrollbarHeight)

//$horScrollbarPosition:=LISTBOX Get property($listboxPtr->;_o_lk hor scrollbar position)
//$verScrollbarPosition:=LISTBOX Get property($listboxPtr->;_o_lk ver scrollbar position)

OBJECT GET SCROLL POSITION:C1114($listboxPtr->; $verScrollbarPosition; $horScrollbarPosition)

OB SET:C1220($lbProperties; "horScrollbarPosition"; $horScrollbarPosition)
OB SET:C1220($lbProperties; "verScrollbarPosition"; $verScrollbarPosition)

$verScrollbarWidth:=LISTBOX Get property:C917($listboxPtr->; lk ver scrollbar width:K53:9)
OB SET:C1220($lbProperties; "verScrollbarWidth"; $verScrollbarWidth)


LISTBOX GET ARRAYS:C832($listboxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)

C_OBJECT:C1216($list)
C_OBJECT:C1216($colProperties)
C_BOOLEAN:C305($colIsVisible)
C_TEXT:C284($colName; $colHeaderName; $colFooterName)

ARRAY TEXT:C222($emptyArray; 0)
ARRAY OBJECT:C1221($arrColProperties; 0)
C_LONGINT:C283($i; $colWidth)

For ($i; 1; Size of array:C274($arrColNames))
	
	CLEAR VARIABLE:C89($colProperties)
	
	C_OBJECT:C1216($colProperties)
	
	OB SET:C1220($colProperties; "ColPosition"; $i)
	
	$colName:=$arrColNames{$i}
	OB SET:C1220($colProperties; "colName"; $colName)
	
	$colHeaderName:=$arrHeaderNames{$i}
	OB SET:C1220($colProperties; "colHeaderName"; $colHeaderName)
	
	$colFooterName:=$arrFooterNames{$i}
	OB SET:C1220($colProperties; "colFooterName"; $colFooterName)
	
	$colIsVisible:=$arrColsVisible{$i}
	OB SET:C1220($colProperties; "colIsVisible"; $colIsVisible)
	
	$colWidth:=LISTBOX Get column width:C834(*; $colName; $minWidth; $maxWidth)
	OB SET:C1220($colProperties; "colWidth"; $colWidth)
	OB SET:C1220($colProperties; "minWidth"; $minWidth)
	OB SET:C1220($colProperties; "maxWidth"; $maxWidth)
	
	APPEND TO ARRAY:C911($arrColProperties; $colProperties)
	
	
End for 

OB SET ARRAY:C1227($lbProperties; "colProperties"; $arrColProperties)
//SET TEXT TO PASTEBOARD($lbProperties)


$0:=OB Copy:C1225($lbProperties)

