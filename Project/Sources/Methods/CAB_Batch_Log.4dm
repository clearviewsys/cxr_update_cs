//%attributes = {}
// logs the results of one batch import

#DECLARE($inputData : Object)->$bathcID : Text

var $entity : Object
var $dateStamp : Text

$dateStamp:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
