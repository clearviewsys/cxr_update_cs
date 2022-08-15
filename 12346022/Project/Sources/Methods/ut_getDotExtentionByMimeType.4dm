//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// @ Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getDotExtentionByMimeType"; Current method name:C684; "UTIL.MimeType")
// getDotExtentionByMimeType

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

$result:=getDotExtentionByMimeType($pdfMIME)
$expected:=$pdfExt
$given:="Calling the method with pdf MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getDotExtentionByMimeType($htmlMIME)
$expected:=$htmlExt
$given:="Calling the method with html MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getDotExtentionByMimeType($jpegMIME)
$expected:=$jpegExt
$given:="Calling the method with jpeg MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getDotExtentionByMimeType($pngMIME)
$expected:=$pngExt
$given:="Calling the method with png MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getDotExtentionByMimeType($notExistant)
$expected:=""
$given:="Calling the method with non existant MIME type"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getDotExtentionByMimeType($notDefined)
$expected:=""
$given:="Calling the method with not defined variable"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)

CANCEL TRANSACTION:C241