//%attributes = {"shared":true}
// __UNIT_TEST
// written by @viktor
// Jan 2021

C_OBJECT:C1216($test)
$test:=AJ_UnitTest.new("getExtentionByMimeType"; Current method name:C684; "UTIL.MimeType")
// getExtentionByMimeType

START TRANSACTION:C239

C_TEXT:C284($pdfExt; $htmlExt; $jpegExt; $pngExt)
C_TEXT:C284($pdfMIME; $htmlMIME; $jpegMIME; $pngMIME)
C_TEXT:C284($notExistant; $notDefined)
C_TEXT:C284($given; $should; $expected; $result)

$pdfMIME:="application/pdf"
$htmlMIME:="text/html"
$jpegMIME:="image/jpeg"
$pngMIME:="image/png"

$pdfExt:="pdf"
$htmlExt:="html"
$jpegExt:="jpeg"
$pngExt:="png"

$notExistant:="randomText"

$result:=getExtentionByMimeType($pdfMIME)
$expected:=$pdfExt
$given:="Calling the method with pdf MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getExtentionByMimeType($htmlMIME)
$expected:=$htmlExt
$given:="Calling the method with html MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getExtentionByMimeType($jpegMIME)
$expected:=$jpegExt
$given:="Calling the method with jpeg MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getExtentionByMimeType($pngMIME)
$expected:=$pngExt
$given:="Calling the method with png MIME type"
$should:="return the extention "+"'"+$expected+"'"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getExtentionByMimeType($notExistant)
$expected:=""
$given:="Calling the method with non existant MIME type"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)

$result:=getExtentionByMimeType($notDefined)
$expected:=""
$given:="Calling the method with not defined variable"
$should:="return an empty string"
AJ_assert($test; $result; $expected; $given; $should)

CANCEL TRANSACTION:C241