//%attributes = {"shared":true}

C_TEXT:C284($1; $param)
C_OBJECT:C1216($0; $status)

C_LONGINT:C283($iProcess)
C_TEXT:C284($tRemotePassword; $tRemoteSite; $tRemoteURL; $tSourceSite)


If (Count parameters:C259>=1)
	$param:=$1
Else 
	$param:=""
End if 

$status:=New object:C1471


If (SOAP Request:C783)
	$iProcess:=Execute on server:C373("remoteValidateRegisters"; 0; "remoteValidateRegisters")
	$status.success:=True:C214
	$status.statusText:="Validation Started"
Else 
	//$tRemoteSite:=""
	//$tRemoteURL:=""
	//$tRemotePassword:=""
	//$tSourceSite:=Sync_Info ("SiteCode")
	//Sync_Validation_resyncTable ($tRemoteSite;$tRemoteURL;$tSourceSite;$tRemotePassword;Table(->[Invoices]);!1970-01-01!;Current date)
	$status:=Sync_validateTable(Table:C252(->[Invoices:5]); $param)
End if 


$0:=$status