var $allCriteria; $validCriteria : Collection
var $criteria : Text
var $settingsObj : Object
var $partialValidate : Boolean

$validCriteria:=New collection:C1472()
$settingsObj:=New object:C1471()

Form:C1466["catch-all"]:=Form:C1466.catchAll
Form:C1466.valid:=True:C214

$allCriteria:=New collection:C1472("valid"; "catch-all"; "spamtrap"; "abuse"; "do_not_mail")
For each ($criteria; $allCriteria)
	If (Form:C1466[$criteria]=True:C214)
		$validCriteria.push($criteria)
	End if 
End for each 

$settingsObj.validCriteria:=$validCriteria
$settingsObj.countEmails:=Form:C1466.countEmails
$settingsObj.fieldNames:=Form:C1466.fieldNames
$settingsObj.tableName:=Form:C1466.tableName

If (Form:C1466.skipValidEmails)
	$partialValidate:=Form:C1466.countEmails<Form:C1466.entitySelectionNonValid.length
	$settingsObj.entitySelection:=Form:C1466.entitySelectionNonValid.slice(0; Form:C1466.countEmails)
Else 
	$partialValidate:=Form:C1466.countEmails<Form:C1466.entitySelection.length
	$settingsObj.entitySelection:=Form:C1466.entitySelection.slice(0; Form:C1466.countEmails)
End if 

If ($partialValidate)
	myConfirm("You don't have enough credits to validate all emails, would you like to do a partial validate? You can validate "+String:C10(Form:C1466.countEmails)+" email(s)")
	If (OK=1)
		checkBulkEmails($settingsObj)
	End if 
Else 
	checkBulkEmails($settingsObj)
End if 


// $settingsObj:
//{
//  "criteria" : collection,
//  "countEmails" : int,
//  "entitySelection" : Entity Selection,
//  "fieldNames": {                    // *Field names NOT values
//                   "email": String
//                   "isValid": String
//                }
//}
