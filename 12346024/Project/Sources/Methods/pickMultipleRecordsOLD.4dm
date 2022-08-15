//%attributes = {}
C_TEXT:C284($1; $preQueryString)  // Make this selection first, then query within i.e. filter hidden Accounts
C_POINTER:C301($TablePtr; ${2})  // Field pointers to include in listbox
C_OBJECT:C1216($Form_obj)
C_COLLECTION:C1488($ListBoxColumnNames)
C_LONGINT:C283($i; $winref)

If (Count parameters:C259<2)
	
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	
Else 
	
	$preQueryString:=$1
	$Form_obj:=New object:C1471
	$ListBoxColumnNames:=New collection:C1472
	
	$TablePtr:=Table:C252(Table:C252(${2}))
	$Form_obj.whichDataStore:=Table name:C256($TablePtr)
	$Form_obj.preQueryStr:=$preQueryString
	
	For ($i; 2; Count parameters:C259)
		$ListBoxColumnNames.push(Field name:C257(${$i}))
	End for 
	
	$Form_obj.listbox_columns:=$ListBoxColumnNames
	
	$winref:=Open form window:C675("Picker_Multi")
	
	DIALOG:C40("Picker_Multi"; $Form_obj)
	
	CLOSE WINDOW:C154
	
	If (OK=1)
		
		If ($Form_obj.selectedItems#Null:C1517)
			USE ENTITY SELECTION:C1513($Form_obj.selectedItems)
		End if 
		
	End if 
	
End if 
