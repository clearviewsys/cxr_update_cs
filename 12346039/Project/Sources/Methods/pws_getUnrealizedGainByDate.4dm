//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// pws_getUnrealizedGainByDate (date) -> real
// published web service

C_DATE:C307($1)
C_REAL:C285($0)



SOAP DECLARATION:C782($1; Is date:K8:7; SOAP input:K46:1; "date")
SOAP DECLARATION:C782($0; Is real:K8:4; SOAP output:K46:2; "profit")

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2=$1)
$0:=Sum:C1([Registers:10]UnrealizedGain:56)
