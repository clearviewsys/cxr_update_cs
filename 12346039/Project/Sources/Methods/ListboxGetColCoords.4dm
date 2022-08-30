//%attributes = {}
//  // Method: ListboxGetColCoords
//  // Parameters
//  // $1 - Pointer to Listbox Object
//  // $2 - Column name
//  // $3 - Pointer to left coordinate variable
//  // $4 - Pointer to top coordinate variable
//  // $5 - Pointer to right coordinate variable
//  // $6 - Pointer to bottom coordinate variable
//  // ----------------------------------------------------
//
//C_POINTER($1;$LB;$3;$4;$5;$6)
//C_TEXT($2;$colName)
//C_LONGINT($left;$top;$right;$bot;$colLeft;$colRight;$colWidth;$colElement;$i)
//C_LONGINT($headerHeight;$footerHeight;$hsHeight;$vsWidth)
//C_BOOLEAN($colFound)
//ARRAY TEXT($arrNames;0)
//$LB:=$1
//$colName:=$2
//
//LISTBOX GET OBJECTS($LB->;$arrNames)
//OBJECT GET COORDINATES($LB->;$left;$top;$right;$bot)
//$headerHeight:=LISTBOX Get information($LB->;Listbox header height)
//$footerHeight:=LISTBOX Get information($LB->;Listbox footer height)
//$hsHeight:=LISTBOX Get information($LB->;Listbox hor scrollbar height)
//$vsWidth:=LISTBOX Get information($LB->;Listbox ver scrollbar width)
//$colLeft:=$left
//$colWidth:=0
//$colFound:=False
//For ($i;1;Size of array($arrNames))
//$colElement:=Mod($i;3)
//If ($colElement=0) & ($colFound=False)
//$colLeft:=$colLeft+$colWidth
//$colWidth:=LISTBOX Get column width(*;$arrNames{$i-2})
//If ($arrNames{$i-2}=$colName)
//If (($colLeft+$colWidth)<($right-$vsWidth))
//$colRight:=$colLeft+$colWidth
//Else 
//$colRight:=$right-$vsWidth
//End if 
//$3->:=$colLeft
//$4->:=$top+$headerHeight
//$5->:=$colRight
//$6->:=$bot-$footerHeight-$hsHeight
//$colFound:=True
//Else 
//$3->:=0
//$4->:=0
//$5->:=0
//$6->:=0
//End if 
//End if 
//End for 