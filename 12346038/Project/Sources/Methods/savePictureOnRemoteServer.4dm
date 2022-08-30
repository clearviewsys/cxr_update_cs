//%attributes = {}
// savePictureOnRemoteServer (key;picture)

C_TEXT:C284($1; $key)
C_PICTURE:C286($2; $aPicture)
$key:=$1
$aPicture:=$2

C_TEXT:C284(<>clientCode; <>clientKey)

C_BLOB:C604($aBlob)


PICTURE TO BLOB:C692($aPicture; $aBlob; "JPEG")

COMPRESS BLOB:C534($aBlob; 1)
BASE64 ENCODE:C895($aBlob)

ws_setKeyValueAsBlob(<>clientCode; <>clientKey; $key; $aBlob)

