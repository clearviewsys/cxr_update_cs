//%attributes = {}
// under development still

C_DATE:C307($1; $2)
C_TEXT:C284($soapMethod)
C_OBJECT:C1216($parameters; $mgCredentials; $result)

$soapMethod:="TransactionDetailReport"
$mgCredentials:=mgGetCredentials

$parameters:=New object:C1471

// property names required by MoneyGram, that is why we don't follow camelCase

$parameters.ReportDateFrom:=$1
$parameters.ReportDateTo:=$2

$parameters.ReportWithChild:="true"
$parameters.ReportPortalFilesCheck:="false"

$parameters.ReportOnline:="true"
$parameters.ReportOnline:="false"

$result:=mgSOAP_RunMethod($mgCredentials; $soapMethod; $parameters)
