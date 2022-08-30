//%attributes = {}
// Object method of search box within "Picker_Multi" project form
// we need to call the same code from form method in order to make initial selection
// of entities based on content of alpha or text fields
// #ORDA
C_POINTER:C301($vSearchText_ptr; $Field_ptr)
C_TEXT:C284($queryStr; $queryFor; $columnname)
C_OBJECT:C1216($selection; $column)
C_LONGINT:C283($columntype)

$vSearchText_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "vSearchText")
$queryStr:=""

If (Form event code:C388=On After Keystroke:K2:26)
	$queryFor:=Get edited text:C655
Else 
	$queryFor:=$vSearchText_ptr->
End if 

$selection:=ds:C1482[Form:C1466.whichDataStore].all()
If (Form:C1466.preQueryStr#Null:C1517)
	If (Form:C1466.preQueryStr#"")
		$selection:=$selection.query(Form:C1466.preQueryStr)
	End if 
End if 

$queryFor:="@"+$queryFor+"@"

For each ($column; Form:C1466.listbox_columns)
	
	$columnname:=Field name:C257($column.field)
	
	// workaround for pointer in collection property
	$Field_ptr:=$column.field
	$columntype:=Type:C295($Field_ptr->)
	// end workaround
	
	If (($columntype=Is text:K8:3) | ($columntype=Is alpha field:K8:1))
		If ($queryStr#"")
			$queryStr:=$queryStr+" OR "+$columnname+" = :1"
		Else 
			$queryStr:=$columnname+" = :1"
		End if 
	End if 
End for each 

Form:C1466.mainlist:=$selection.query($queryStr; $queryFor)
If (Form:C1466.mainlist.length>0)  // select the first row
	LISTBOX SELECT ROW:C912(*; "mainlist"; 1)
	Form:C1466.selectedItems:=Form:C1466.mainlist[0]
	OBJECT SET ENABLED:C1123(*; "PickButton"; True:C214)
End if 

