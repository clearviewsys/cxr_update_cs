//%attributes = {}
// #unittest for isHighRiskIndustryCode
// Notes: If you make changes to the registry you need to rerun the initStorageObject

ASSERT:C1129(isHighRiskIndustryCode("00")=False:C215)  // assuming there's not such code
ASSERT:C1129(isHighRiskIndustryCode("")=False:C215)  // assuming there's not such code

// create a high risk industry
var $e; $status : Object
$e:=ds:C1482.Industries.new()

/*
[Industries]Code
[Industries]Industry
[Industries]AML_Risk
*/
$e.Code:="HRIN***"
$e.Industry:="High Risk Industry"
$e.AML_Risk:=4
$status:=$e.save()
initStorageObject  // reload the storage object

ASSERT:C1129($status.success)
ASSERT:C1129(isHighRiskIndustryCode("HRIN***"))  // assuming there's not such code

// delete the industry code that was just added
If ($status.success)  // if the save is successful then delete the same entry
	$e:=ds:C1482.Industries.query("Code = :1"; $e.Code).drop()  // just remove the same
End if 