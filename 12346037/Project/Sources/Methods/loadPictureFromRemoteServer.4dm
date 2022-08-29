//%attributes = {}
// loadPictureFromRemoteServer (key;->picture)

C_TEXT:C284($1; $key)
C_POINTER:C301($2)
C_PICTURE:C286($apicture)

$key:=$1

C_TEXT:C284(<>clientCode; <>clientKey)
C_BLOB:C604($aBlob)

$aBlob:=ws_getKeyValueAsBLOB(<>clientCode; <>clientKey; $key)

BASE64 DECODE:C896($aBlob)
EXPAND BLOB:C535($aBlob)

BLOB TO PICTURE:C682($aBlob; $apicture)

$2->:=$apicture


