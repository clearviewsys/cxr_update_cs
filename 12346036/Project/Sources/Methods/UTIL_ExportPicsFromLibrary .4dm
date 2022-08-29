//%attributes = {}
//
//PICTURE CODEC LIST($arrId;$arrName)
//
//
//ARRAY LONGINT($arrPicRefs;0)
//ARRAY TEXT($arrPicNames;0)  // changed by TB; type error
//
//PICTURE LIBRARY LIST($arrPicRefs;$arrPicNames)
//C_PICTURE($picture)
//C_BLOB($blob)
//
//$folder:=Select folder("Select a folder")
//
//
//For ($i;1;Size of array($arrPicNames))
//
//
//GET PICTURE FROM LIBRARY($arrPicRefs{$i};$picture)
//PICTURE TO BLOB($picture;$blob;".jpg")
//
//$fileName:=$folder+$arrPicNames{$i}+".jpg"
//$fileName:=Replace string($fileName;" ";"_")
//
//BLOB TO DOCUMENT($fileName;$blob)
//
//
//End for 
//
