//%attributes = {}
// listboxSetContextMenu ($listboxPtr; $listboxId )

// Method for creating Listbox context menu on headers

C_POINTER:C301($1; $listboxPtr)
C_TEXT:C284($2; $listboxId)

C_TEXT:C284($contextMenu; $objectName; $menuOpt; $hidetext)
C_LONGINT:C283($memuSelected; $minWidth; $maxWidth; $i)
ARRAY BOOLEAN:C223($arrColumnsHidden; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY POINTER:C280($arrColumnsVars; 0)


Case of 
	: (Count parameters:C259=2)
		
		$listboxPtr:=$1
		$listboxId:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 




$contextMenu:=Create menu:C408

APPEND MENU ITEM:C411($contextMenu; getLocalizedKeyword("reset"))
SET MENU ITEM PARAMETER:C1004($contextMenu; -1; "Reset")

//APPEND MENU ITEM($contextMenu;getLocalizedKeyword ("hide"))

SET MENU ITEM MARK:C208($contextMenu; 1; "")
APPEND MENU ITEM:C411($contextMenu; "-")
C_TEXT:C284($hideMenu; $columnList)

ListBoxColumnsTitlesToArray($listboxPtr; ->$arrHeaderNames; ->$arrColumnsHidden; ->$arrColumnsVars)

$hideMenu:=Create menu:C408
$hidetext:=getLocalizedKeyword("hide")+" "

For ($i; 1; Size of array:C274($arrHeaderNames))
	APPEND MENU ITEM:C411($contextMenu; $arrHeaderNames{$i})
	
	If ($arrColumnsHidden{$i})
		SET MENU ITEM MARK:C208($contextMenu; -1; "")  // Char(18)
	Else 
		SET MENU ITEM MARK:C208($contextMenu; -1; Char:C90(18))
	End if 
	
End for 

C_TEXT:C284($itemMark)
C_LONGINT:C283($menuSelected; $colWidth; $minWidth)
C_POINTER:C301($objPtr)

$menuSelected:=Pop up menu:C542($contextMenu)
If ($menuSelected>0)
	
	Case of 
			
		: ($menuSelected=1)  //"Reset"
			listboxSetPreferences($listboxPtr; False:C215; $listboxId)
			
		Else 
			
			$itemMark:=Get menu item mark:C428($contextMenu; $menuSelected)
			$objPtr:=$arrColumnsVars{$menuSelected-2}
			$colWidth:=LISTBOX Get column width:C834($objPtr->; $minWidth; $maxWidth)
			
			If ($colWidth<=$minWidth)
				LISTBOX SET COLUMN WIDTH:C833($objPtr->; 100; 0; 200)
				SET MENU ITEM MARK:C208($contextMenu; $menuSelected; Char:C90(18))
				$colWidth:=LISTBOX Get column width:C834($objPtr->)
				
			Else 
				SET MENU ITEM MARK:C208($contextMenu; $menuSelected; "")  // Char(18)
				$colWidth:=LISTBOX Get column width:C834($objPtr->)
				LISTBOX SET COLUMN WIDTH:C833($objPtr->; 100; 0; 200)
				LISTBOX SET COLUMN WIDTH:C833($objPtr->; 0; 0; 200)
				
			End if 
			
			
			//listboxSavePreferences ($listboxPtr;True;$listBoxId)  // Save original preferences as Default Prefs
			
	End case 
	
End if   //  ($menuSelected>0)

