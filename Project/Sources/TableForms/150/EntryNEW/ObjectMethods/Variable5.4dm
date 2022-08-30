C_TEXT:C284($nationality)
$nationality:=Form:C1466.Rule.ifNationality  // default value
Form:C1466.Rule.ifNationality:=pickCountryCode(->$nationality)