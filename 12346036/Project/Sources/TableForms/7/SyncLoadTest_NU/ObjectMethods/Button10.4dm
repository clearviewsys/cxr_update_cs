

C_TEXT:C284($tAlert)
$tAlert:="NOTE: The load test uses the current configuraton of your sync preferences. "
$tAlert:=$tAlert+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Make sure the table you are testing is configured to sync to a site. "
$tAlert:=$tAlert+"Only tables that are configured to send to will be available to select."+Char:C90(Carriage return:K15:38)
$tAlert:=$tAlert+Char:C90(Carriage return:K15:38)+"It is suggested you only enable 1 remote site to send to."

myAlert($tAlert)