//%attributes = {}
C_TEXT:C284($alertMessage)
<>LOGOFFUSERPRESENT:=False:C215
$alertMessage:="Warning!"+Char:C90(Carriage return:K15:38)
$alertMessage:=$alertMessage+"You will be logged off in 1 minute!"+Char:C90(Carriage return:K15:38)
$alertMessage:=$alertMessage+"Please continue work or click on this window if you wish to continue"

notifyAlert("Auto logoff warning"; $alertMessage; 10)

ON EVENT CALL:C190("autoLogoutCheck")
DELAY PROCESS:C323(Current process:C322; 1*60*10)
ALERT:C41(String:C10(<>LOGOFFUSERPRESENT))
//$AlertPid:=New process("myAlert_AutoLogoff";0;"LogoffAlert";$alertMessage)