var $allCriteria; $validCriteria : Collection
var $criteria : Text
var $settingsObj : Object

$validCriteria:=New collection:C1472()

Form:C1466["catch-all"]:=Form:C1466.catchAll
Form:C1466.valid:=True:C214

$allCriteria:=New collection:C1472("valid"; "catch-all"; "spamtrap"; "abuse"; "do_not_mail")
For each ($criteria; $allCriteria)
	If (Form:C1466[$criteria]=True:C214)
		$validCriteria.push($criteria)
	End if 
End for each 

Form:C1466.validCriteria:=$validCriteria

