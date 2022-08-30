//%attributes = {}
// AUS_UpdateAusReportInfo
// Update FIJI Report Info into config file



C_TEXT:C284($tmp; $fileName)
C_BLOB:C604($blob)
$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"austrac.ini"

$tmp:="[AUSTRAC]"+CRLF

$tmp:=$tmp+"reportingEntityID="+reportingEntityID+CRLF
$tmp:=$tmp+"reportingBranchName="+reportingBranchName+CRLF
$tmp:=$tmp+"fiReportRef="+fiReportRef+CRLF

$tmp:=$tmp+"contactEntityName="+contactEntityName+CRLF
$tmp:=$tmp+"contactEntityAddress="+contactEntityAddress+CRLF
//$tmp:=$tmp+"contactOtherInfo="+contactOtherInfo+CRLF 
$tmp:=$tmp+"fiReportRef="+String:C10(initialDate)+CRLF
$tmp:=$tmp+"finalDate="+String:C10(finalDate)+CRLF
TEXT TO BLOB:C554($tmp; $blob)
BLOB TO DOCUMENT:C526($fileName; $blob)
//myAlert ("Report information Updated"+"\n"+$fileName)

