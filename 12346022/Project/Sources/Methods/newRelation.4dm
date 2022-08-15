//%attributes = {}
//void := newRelation(customerID text; toCustomerID text; relationType text)
C_TEXT:C284($customerId; $1)
C_TEXT:C284($toCustomerId; $2)
C_TEXT:C284($relationType; $3)

ASSERT:C1129(Count parameters:C259=3)

$customerId:=$1
$toCustomerId:=$2
$relationType:=$3

C_OBJECT:C1216($newRelation)

$newRelation:=ds:C1482.Relations.new()
$newRelation.customerID:=$customerId
$newRelation.toCustomerID:=$toCustomerId
$newRelation.relationType:=$relationType
$newRelation.save()