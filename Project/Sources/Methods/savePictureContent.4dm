//%attributes = {}
// savePictureContent ($base64textPicture
// Save the TUI Editor modified picture and let it available for 4D

C_TEXT:C284($1; DokaFinalPicturePath)
C_BLOB:C604($blob)
C_PICTURE:C286($pic)


BASE64 DECODE:C896($1; $blob)

DokaFinalPicturePath:=Temporary folder:C486+"pic_"+String:C10(Random:C100)+".jpg"
BLOB TO PICTURE:C682($blob; $pic)
CONVERT PICTURE:C1002($pic; ".jpg"; 0.6)
PICTURE TO BLOB:C692($pic; $blob; ".jpg")
BLOB TO DOCUMENT:C526(DokaFinalPicturePath; $blob)
iH_Notify("Image Editor"; "Changes Applied"; 2)
