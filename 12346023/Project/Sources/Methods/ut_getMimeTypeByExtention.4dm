//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getMimeTypeByExtention"; Current method name:C684; "UTIL.MimeType")
//getMimeTypeByExtention

START TRANSACTION:C239

C_TEXT:C284($pdfExt; $htmlExt; $jpegExt; $pngExt)
C_TEXT:C284($pdfMIME; $htmlMIME; $jpegMIME; $pngMIME)
C_TEXT:C284($notExistant; $notDefined)
C_TEXT:C284($given; $should; $expected; $result)

$pdfMIME:="application/pdf"
$htmlMIME:="text/html"
$jpegMIME:="image/jpeg"
$pngMIME:="image/png"

$pdfExt:=".pdf"
$htmlExt:=".html"
$jpegExt:=".jpeg"
$pngExt:=".png"

$notExistant:="randomText"



$result:=getMimeTypeByExtention($pdfExt)
$expected:=$pdfMIME
$given:="Calling the method with '.pdf' Ext type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getMimeTypeByExtention($htmlExt)
$expected:=$htmlMIME
$given:="Calling the method with '.html' Ext type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getMimeTypeByExtention($jpegExt)
$expected:=$jpegMIME
$given:="Calling the method with '.jpeg' Ext type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getMimeTypeByExtention($pngExt)
$expected:=$pngMIME
$given:="Calling the method with '.png' Ext type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getMimeTypeByExtention($notExistant)
$expected:=""
$given:="Calling the method with non existant Ext type"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getMimeTypeByExtention($notDefined)
$expected:=""
$given:="Calling the method with not defined variable"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)




CANCEL TRANSACTION:C241