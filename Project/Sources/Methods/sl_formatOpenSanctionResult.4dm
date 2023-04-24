//%attributes = {}
#DECLARE($entityParam : cs:C1710.SanctionCheckLogEntity)->$result : Object

// MARK: Paramter Check
var $entity : cs:C1710.SanctionCheckLogEntity
Case of 
	: (Count parameters:C259=1)
		$entity:=$entityParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARK: Basic Details
var $details : Object
$details:=New object:C1471(\
"total"; $entity.ResponseJSON.total; \
"offset"; $entity.ResponseJSON.offset; \
"limit"; $entity.ResponseJSON.limit; \
"results"; $entity.ResponseJSON.results.copy(); \
"facets"; $entity.ResponseJSON.facets\
)
var $match : Object
var $key : Text

// MARK:- For each match...
var $colour : Text
var $style : Integer
var $formula : 4D:C1709.Function

var $progress; $count : Integer
$progress:=Progress New
$count:=0
Progress SET TITLE($progress; "Format Result")
For each ($match; $details.results)
	var $percent : Real
	$percent:=$count/$details.results.length
	Progress SET MESSAGE($progress; "Formatted results: "+String:C10($percent*100)+"%")
	Progress SET PROGRESS($progress; $percent)
	$match.properties:=sl_formatOpenSanctionProp($match.properties; $match.datasets; \
		$match.referents)
	$count:=$count+1
End for each 
Progress QUIT($progress)

var $formatted : Collection

$formatted:=New collection:C1472
For each ($key; $details.facets)
	$formatted.push($key)
End for each 

var $list : cs:C1710.SanctionListsEntity
$list:=ds:C1482.SanctionLists.query("ShortName = :1"; $entity.SanctionList)[0]

$result:=New object:C1471("name"; $list.Description+" ("+$list.ShortName+")"; \
"details"; $details; \
"tabs"; New object:C1471("values"; New collection:C1472("Results"; "Facets"; "Details"); "index"; 0); \
"facets"; $formatted; \
"UUID"; $entity.UUID; "useServer"; sl_useOpenSanctions; \
"sanctionList"; $list.ShortName; "fullName"; $entity.FullName\
)
If (OB Is defined:C1231($entity.ResponseJSON; "entities"))
	$result.entities:=$entity.ResponseJSON.entities
End if 