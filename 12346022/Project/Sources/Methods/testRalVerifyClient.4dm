//%attributes = {}
C_TEXT:C284($response)
$response:=RAL2_verifyClient("clearviewsysVM2Test"; "clearviewTEST1234!@#$")

$response:=RAL2_verifyClient(replaceUnsafeURLCharacters("clearviewsysVM2Test"); replaceUnsafeURLCharacters("clearviewTEST1234!@#$"))
