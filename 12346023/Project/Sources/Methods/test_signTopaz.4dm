//%attributes = {}
C_POINTER:C301($ptr)
C_BOOLEAN:C305($success)

$success:=signTopaz($ptr)
ASSERT:C1129(Is nil pointer:C315($ptr); "Expected a nil pointer")
ASSERT:C1129($success=False:C215; "exepected a non-successful attempt")

C_PICTURE:C286($pic)
openPictureFile(->$pic)
$success:=signTopaz(->$pic)
ASSERT:C1129($success=True:C214; "exepected a non-successful attempt")
