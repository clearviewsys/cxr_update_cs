//%attributes = {}
// FT_UpdateFintractInfo
// Update FINTRAC Info into config file



C_TEXT:C284($tmp; $fileName)
C_BLOB:C604($blob)
$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"fintrac.ini"

$tmp:="[FINTRAC]"+CRLF

$tmp:=$tmp+"reportingEntityPKI="+reportingEntityPKI+CRLF
setKeyValue("FT.reportingEntityPKI"; reportingEntityPKI)

$tmp:=$tmp+"reportingEntityCertificateID="+reportingEntityCertificateID+CRLF
setKeyValue("FT.reportingEntityCertificateID"; reportingEntityCertificateID)

$tmp:=$tmp+"reportingEntityName="+reportingEntityName+CRLF
setKeyValue("FT.reportingEntityName"; reportingEntityName)

$tmp:=$tmp+"reportingEntityLocationNumber="+reportingEntityLocationNumber+CRLF
$tmp:=$tmp+"reportingEntityLocationName="+reportingEntityLocationName+CRLF

$tmp:=$tmp+"contactSurname="+contactSurname+CRLF
$tmp:=$tmp+"contactGivenName="+contactGivenName+CRLF
$tmp:=$tmp+"contactOtherName="+contactOtherName+CRLF
$tmp:=$tmp+"contactPhoneNumber="+contactPhoneNumber+CRLF
$tmp:=$tmp+"contactPhoneNumberExt="+contactPhoneNumberExt+CRLF
$tmp:=$tmp+"initialDate="+String:C10(initialDate)+CRLF

TEXT TO BLOB:C554($tmp; $blob)
BLOB TO DOCUMENT:C526($fileName; $blob)
myAlert("FINTRAC Ibformation Updated in: \n"+$fileName)
