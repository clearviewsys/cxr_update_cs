//K20_displayRecordDetails(Form.ResponseJSON.details[Form.smartScan["Search Reference ID"]])

var $id : Text
$id:=Form:C1466.smartScan["Search Reference ID"]
var $found : Object
$found:=Form:C1466.ResponseJSON.details.find("slold_k20FindDetail"; Form:C1466.smartScan["Search Reference ID"])
K20_displayRecordDetails($found)