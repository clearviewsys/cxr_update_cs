//%attributes = {"publishedWeb":true}
C_TEXT:C284($setName)

$setName:=makeSavedSetNameForTable

COPY SET:C600("UserSet"; $setName)
SAVE SET:C184($setName; $setName)