//%attributes = {}


C_POINTER:C301($1; $2; $table; $field)
//New sendNotificationbySMS method - ADD
C_POINTER:C301($countryCode; $3)
C_TEXT:C284($tableName; $setName)
C_OBJECT:C1216($form)
C_LONGINT:C283($winRef)

$form:=New object:C1471()

Case of 
	: (Count parameters:C259=2)
		$table:=$1
		$field:=$2
		
		//New sendNotificationbySMS method - ADD
	: (Count parameters:C259=3)
		$table:=$1
		$field:=$2
		$countryCode:=$3
		
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
	
	//New sendNotificationbySMS method - ADD
	$form.countryCode:=$countryCode
	
	//Open form
	$winRef:=Open form window:C675("SendMassText"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("SendMassText"; $form)
	CLOSE WINDOW:C154($winRef)
Else 
	myAlert("Please highlight some records first")
End if 
