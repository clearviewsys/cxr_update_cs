var $limit : Integer
var $entity : cs:C1710.SanctionListsEntity

$entity:=ds:C1482.SanctionLists.query("ShortName = :1"; Form:C1466.sanctionList).first()

var $response : Object

$response:=sl_requestOpenSanctionScreening(Form:C1466.fullName; $entity; \
Form:C1466.details.results.length)

Form:C1466.saving.results.combine($response.response.results)
var $copy : Object
$copy:=OB Copy:C1225($response.response)
var $match
For each ($match; $copy.results)
	$match.properties:=sl_formatOpenSanctionProp($match.properties; $match.datasets; \
		$match.referents)
End for each 


Form:C1466.details.results.combine($copy.results)
