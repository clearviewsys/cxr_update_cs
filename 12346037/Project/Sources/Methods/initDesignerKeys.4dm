//%attributes = {}
setKeyValue("auth.designerTries"; "0")
setKeyValue("auth.designerEnabled"; "True")

ASSERT:C1129(getKeyValue("auth.designerTries")="0")
ASSERT:C1129(getKeyValue("auth.designerEnabled")="True")