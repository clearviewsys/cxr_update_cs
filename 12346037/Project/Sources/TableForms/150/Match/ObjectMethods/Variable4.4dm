C_TEXT:C284($industryCode)
$industryCode:=Form:C1466.Rule.ifIndustryCode  // default value
Form:C1466.Rule.ifIndustryCode:=pickIndustryCode(->$industryCode)