launch3MPassportConsole([Customers:3]CustomerID:1; False:C215)

DELAY PROCESS:C323(Current process:C322; 100)

C_TEXT:C284($filePath)
$filePath:=getFilePathByID("3M Scanner:ScanFolder")+[Customers:3]CustomerID:1+"-visible.bmp"
openPictureID(->[Customers:3]PictureID_Image:53; $filePath)
C_PICTURE:C286(vLoadedPicture)
vLoadedPicture:=[Customers:3]PictureID_Image:53
scaleImage(->[Customers:3]PictureID_Image:53; 0.36)
cropImageFromAllSides(->[Customers:3]PictureID_Image:53; 0.01)