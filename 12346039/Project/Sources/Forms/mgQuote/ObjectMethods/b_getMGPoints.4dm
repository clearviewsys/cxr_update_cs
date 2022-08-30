C_LONGINT:C283($winref)
C_OBJECT:C1216($formObj)

$formObj:=New object:C1471

$formObj.destinationCountry:=Form:C1466.destinationCountry
$formObj.destinationCountryID:=mgCountryCode2CountryID(Form:C1466.destinationCountry)
$formObj.city:=""
$formObj.state:=""

$winref:=Open form window:C675("mgGetPoints")

DIALOG:C40("mgGetPoints"; $formObj)

CLOSE WINDOW:C154($winref)
