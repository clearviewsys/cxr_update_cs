//%attributes = {}
#DECLARE($entityParam : cs:C1710.SanctionCheckLogEntity)->$result : Object

var $entity : cs:C1710.SanctionCheckLogEntity
Case of 
	: (Count parameters:C259=1)
		$entity:=$entityParam
End case 

$result:=New object:C1471("shortName"; $entity.SanctionList; \
"response"; $entity.ResponseJSON; \
"fullName"; ds:C1482.SanctionLists.query("ShortName=':1'"; $entity.SanctionList)\
.first().Description; \
"UUID"; $entity.UUID; "useServer"; sl_useKYC2020\
)