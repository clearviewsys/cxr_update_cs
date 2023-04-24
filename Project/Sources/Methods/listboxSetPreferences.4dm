//%attributes = {}
// listboxSetPreferences (->listboxPtr; latestPreferences; $listboxId)
// Set all listbox Properties 
// Created by JA on 2/2/2017

C_POINTER:C301($1; $listboxPtr)
C_BOOLEAN:C305($2; $latestPrefs)
C_TEXT:C284($3; $listboxId; $colname)

C_LONGINT:C283($colWidth; $maxWidth; $minWidth; $numCols)


C_OBJECT:C1216($lbProperties; $colProperties)


Case of 
		
	: (Count parameters:C259=3)
		
		$listboxPtr:=$1
		$latestPrefs:=$2
		$listboxId:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//TRACE



$lbProperties:=ListboxLoadPreferences($listboxPtr; $latestPrefs; $listboxId)


If (Not:C34(OB Is empty:C1297($lbProperties)))
	
	ARRAY OBJECT:C1221($arrColProperties; 0)
	OB GET ARRAY:C1229($lbProperties; "colProperties"; $arrColProperties)
	
	$numCols:=Size of array:C274($arrColProperties)
	
	C_OBJECT:C1216($colProperties)
	C_LONGINT:C283($i)
	
	For ($i; 1; $numCols)
		
		CLEAR VARIABLE:C89($colProperties)
		
		C_OBJECT:C1216($colProperties)
		$colProperties:=OB Copy:C1225($arrColProperties{$i})
		
		$colName:=OB Get:C1224($colProperties; "colName")
		$colWidth:=OB Get:C1224($colProperties; "colWidth"; Is longint:K8:6)
		$minWidth:=OB Get:C1224($colProperties; "minWidth"; Is longint:K8:6)
		$maxWidth:=OB Get:C1224($colProperties; "maxWidth"; Is longint:K8:6)
		
		LISTBOX MOVE COLUMN:C1274(*; $colName; $i)
		LISTBOX SET COLUMN WIDTH:C833(*; $colName; 100; $minWidth; $maxWidth)
		LISTBOX SET COLUMN WIDTH:C833(*; $colName; $colWidth; $minWidth; $maxWidth)
		
	End for 
	
Else 
	
	// There is not stored preferences for listbox, Initilize preferences with default values
	
	listboxSavePreferences($listboxPtr; True:C214; $listBoxId)  // Save Latest preferences as Latest Prefs
	listboxSavePreferences($listboxPtr; False:C215; $listBoxId)  // Save original preferences as Default Prefs
	
	
End if 
