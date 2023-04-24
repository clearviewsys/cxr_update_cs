C_LONGINT:C283($winref)
C_OBJECT:C1216($formObj)

$formObj:=New object:C1471
$formObj.destinationCountry:=Form:C1466.object.destinationCountry
$formObj.sendCurrency:=Form:C1466.object.sendCurrency
$formObj.sendAmount:=Num:C11(Form:C1466.object.sendAmount)

$winref:=Open form window:C675("mgQuote")
DIALOG:C40("mgQuote"; $formObj)

CLOSE WINDOW:C154

