//%attributes = {"shared":true}
// __UNIT_TEST
var $test : Object
$test:=AJ_UnitTest.new("load picture resource"; Current method name:C684)
var $pic : Picture
var $foundShould; $notFound : Text
$foundShould:="Should find a picture"
$notFound:="Should not find a picture"
AJ_assert($test; True:C214; loadPictureResource("AlertOk"; ->$pic); "AlertOk in default folder"; \
$foundShould)

AJ_assert($test; True:C214; loadPictureResource("AlertOk.png"; ->$pic); "AlertOk.png in default folder"; \
$foundShould)

AJ_assert($test; False:C215; loadPictureResource("AlO"; ->$pic); "AlO in default folder"; $notFound)

AJ_assert($test; True:C214; loadPictureResource("info"; ->$pic; Folder:C1567("Images")); "info in Images folder"; \
$foundShould)