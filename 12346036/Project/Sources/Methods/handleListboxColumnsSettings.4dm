//%attributes = {}
// handleListboxColumnsSettings ($listboxPtr; $tablePtr; {$formName}; {$listboxName})
// PRE: The listbox name should start with the word "ListBox"
// Handle the Listbox columns events
// form events ; on load; on unload; on header clicked; on column moved; 

C_POINTER:C301($1; $listboxPtr; $2; $tablePtr; $colPtr)  // #TB Added the tablePtr as an extra parameter; 
C_TEXT:C284($3; $formName)
C_TEXT:C284($4; $listboxName; $listboxId; $colName)
C_LONGINT:C283($oldPosition; $newPosition; $mouseButton)
C_LONGINT:C283($mouseX; $mouseY)

Case of 
		
	: (Count parameters:C259=1)
		
		$listboxPtr:=$1
		$tablePtr:=Current form table:C627
		//$formName:="Listbox"
		//$listboxName:="mainListbox"
		$formName:=Current form name:C1298
		$listboxName:=OBJECT Get name:C1087(Object current:K67:2)
		
	: (Count parameters:C259=2)  // Added by #TB ; we need the tablePtr cause it's not always current form table
		
		$listboxPtr:=$1
		$tablePtr:=$2
		$formName:=Current form name:C1298
		$listboxName:=OBJECT Get name:C1087(Object current:K67:2)
		
	: (Count parameters:C259=3)
		
		$listboxPtr:=$1
		$tablePtr:=$2
		$formName:=$3
		//$listboxName:="mainListbox"
		$listboxName:=OBJECT Get name:C1087(Object current:K67:2)
		
	: (Count parameters:C259=4)
		
		$listboxPtr:=$1
		$tablePtr:=$2
		$formName:=$3
		$listboxName:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$listboxId:=Table name:C256($tablePtr)+"_"+$formName+"_"+$listboxName

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		// Loads the latest lixbox user saved preferences
		listboxSetPreferences($listboxPtr; True:C214; $listboxId)
		
		
	: (Form event code:C388=On Unload:K2:2)  // saves the position of columns and the widths of them
		listboxSavePreferences($listboxPtr; True:C214; $listboxId)
		
	: (Form event code:C388=On Column Moved:K2:30)  // saves the new position of the column
		
		$listboxName:=OBJECT Get name:C1087(Object current:K67:2)
		$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $listboxName)
		LISTBOX MOVED COLUMN NUMBER:C844($listboxPtr->; $oldPosition; $newPosition)
		listboxSavePreferences($listboxPtr; True:C214; $listBoxId)  // Save Latest
		
		
	: (Form event code:C388=On Header Click:K2:40)  // it displays the contextual menu 
		//$listboxName:=OBJECT Get name(Object with focus)
		
		$colPtr:=OBJECT Get pointer:C1124($listboxName)
		$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $listboxName)
		
		ARRAY TEXT:C222($arrColNames; 0)
		ARRAY TEXT:C222($arrHeaderNames; 0)
		ARRAY POINTER:C280($arrColVars; 0)
		ARRAY POINTER:C280($arrHeaderVars; 0)
		ARRAY BOOLEAN:C223($arrColsVisible; 0)
		ARRAY POINTER:C280($arrStyles; 0)
		ARRAY TEXT:C222($arrFooterNames; 0)
		ARRAY POINTER:C280($arrFooterVars; 0)
		
		If (Not:C34(Is nil pointer:C315($listboxPtr)))
			LISTBOX GET ARRAYS:C832($listboxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
		End if 
		
		GET MOUSE:C468($mouseX; $mouseY; $mouseButton)
		
		If (Macintosh control down:C544 | ($mouseButton=2))  // $mouseButton=2 (Right Click)
			
			If (isListbox($listboxPtr))
				listboxSetContextMenu($listboxPtr; $listboxId)
			End if 
		End if 
		
		
End case 


