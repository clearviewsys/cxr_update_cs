//%attributes = {}
// GAML_UpdateGoAMLInfo
// Update GOAML Info into config file



C_TEXT:C284($tmp; $fileName)
C_BLOB:C604($blob)
$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"goaml.ini"

$tmp:="[GOAML]"+CRLF

$tmp:=$tmp+"reportingEntityID="+reportingEntityID+CRLF
$tmp:=$tmp+"reportingEntityName="+reportingEntityName+CRLF
$tmp:=$tmp+"reportingBranchName="+reportingBranchName+CRLF

$tmp:=$tmp+"contactTitle="+contactTitle+CRLF

$tmp:=$tmp+"contactGivenName="+contactGivenName+CRLF
$tmp:=$tmp+"contactOtherName="+contactOtherName+CRLF
$tmp:=$tmp+"contactSurname="+contactSurname+CRLF

$tmp:=$tmp+"contactEmail="+contactEmail+CRLF
$tmp:=$tmp+"contactOccupation="+contactOccupation+CRLF
$tmp:=$tmp+"contactNationality="+contactNationality+CRLF

$tmp:=$tmp+"finalDate="+String:C10(finalDate)+CRLF


TEXT TO BLOB:C554($tmp; $blob)
BLOB TO DOCUMENT:C526($fileName; $blob)
//myAlert ("Report information Updated"+"\n"+$fileName)



