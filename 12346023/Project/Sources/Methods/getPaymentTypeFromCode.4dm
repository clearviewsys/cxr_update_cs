//%attributes = {}


C_TEXT:C284($1; $code)

C_TEXT:C284($0; $descrip)

C_OBJECT:C1216($entity)


$code:=$1
$descrip:=""

If ($code="/@")
	$code:=Substring:C12($code; 2)
End if 

$entity:=ds:C1482.PaymentTypes.query("Code == :1"; $code)

If ($entity.length>0)
	$descrip:=$entity.first().PaymentType
End if 


$0:=$descrip


