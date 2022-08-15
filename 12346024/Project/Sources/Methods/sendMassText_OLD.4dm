//%attributes = {}
C_POINTER:C301($1; $2; $table; $field)
C_TEXT:C284($tableName; $setName)
C_OBJECT:C1216($form)
C_LONGINT:C283($winRef)

$form:=New object:C1471()

Case of 
	: (Count parameters:C259=2)
		$table:=$1
		$field:=$2
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tableName:=Table name:C256($table)
$setName:="$"+$tableName+"_LBSet"

If (Records in set:C195($setName)>0)
	//USE SET($setName)
	$form.setName:=$setName
	$form.message:=""
	$form.table:=$table
	$form.field:=$field
	
	
	//Open form
	$winRef:=Open form window:C675("SendMassText"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("SendMassText"; $form)
	CLOSE WINDOW:C154($winRef)
Else 
	myAlert("Please highlight some records first")
End if 
