//%attributes = {}
C_TEXT:C284($error; $longMessage)
C_POINTER:C301($pError)
$pError:=->$error
//One segment
//twilioSendSMS ($pError;"177886707";"test one")
twilioSendSMS($pError; "17788670784"; "test one")
$longMessage:="This is 22 characters "
$longMessage:=$longMessage+$longMessage  //44
$longMessage:=$longMessage+$longMessage  //88
$longMessage:=$longMessage+$longMessage  //176
//Two segments
//twilioSendSMS ($pError;"+17788670784";$longMessage)
$longMessage:=$longMessage+$longMessage  //352
//Three segments
//twilioSendSMS ($pError;"+17788670784";$longMessage)
//twilioSendSMS ($pError;"+17788670784";"test three";"17786880994")
//twilioSendSMS ($pError;"+17788670784";"test four";"+17786880994")