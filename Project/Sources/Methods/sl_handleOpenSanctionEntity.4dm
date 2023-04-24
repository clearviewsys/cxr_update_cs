//%attributes = {}
#DECLARE($inputParam : Variant)->$formatted : Collection

var $data : Object
var $id : Text
var $isSaving : Boolean
Case of 
	: (Count parameters:C259=1)
		If (Value type:C1509($inputParam)=Is text:K8:3)
			$id:=$inputParam
			$data:=sl_pullOpenSanctionEntity($inputParam)
			$isSaving:=True:C214
		Else 
			$data:=$inputParam
			$id:=$data.id
			$isSaving:=False:C215
		End if 
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $index : Integer
var $add : Boolean
var $entity : Object
$add:=True:C214
$index:=0
For each ($entity; Form:C1466.entities)
	If (($entity.id=$id) || (OB Is defined:C1231($entity; "referId") && ($entity.referId=$id)))
		$data:=$entity
		$add:=False:C215
		break
	End if 
	$index:=$index+1
End for each 

If ($add)
	If ($isSaving)
		Form:C1466.saving.entities.push($data)
	End if 
	
	$formatted:=sl_formatOpenSanctionProp($data.properties; $data.datasets; $data.referents)
	$data.properties:=$formatted
	$index:=Form:C1466.entities.length
	Form:C1466.entities.push($data)
End if 

FORM GOTO PAGE:C247(3; *)
Form:C1466.tabs.index:=3
LISTBOX SELECT ROW:C912(OBJECT Get pointer:C1124(Object named:K67:5; "lb_enitites")->; $index+1; lk replace selection:K53:1)
Form:C1466.entityData.setValues($data.properties)