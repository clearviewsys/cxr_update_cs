C_TEXT:C284($lang; $langName)


$lang:=waGetSelectedItemValue("mywa"; "ddlLanguage")

$langName:=waGetSelectedItemText("mywa"; "ddlLanguage")

ALERT:C41($lang+" "+$langName)
