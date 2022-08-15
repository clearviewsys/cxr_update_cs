//%attributes = {}
C_TEXT:C284($error; $authKey; $email; $apiKey)
$error:=""
C_POINTER:C301($pError)
$pError:=->$error
C_OBJECT:C1216($beneficiary)
$beneficiary:=New object:C1471()
C_BOOLEAN:C305($priority)
$priority:=True:C214

$email:="blake@clearviewsys.com"
$apiKey:="1e43d2c9891e6f2b1e9689e6f58928e1c643c96a1961923432742199c3282346"

$authKey:=CC_login($email; $apiKey; $pError)

$beneficiary.currency:="CAD"
$beneficiary.bank_country:="CA"
$beneficiary.beneficiary_country:="CA"
$beneficiary.beneficiary_entity_type:="individual"

If (Length:C16($authKey)>3)
	myAlert(CC_validateBeneficiaryFields($pError; $beneficiary; $authKey; $priority))
End if 
