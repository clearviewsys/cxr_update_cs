C_TEXT:C284($path)
C_OBJECT:C1216($formInput)

If ([mchk_CheckLog:142]isCompany:9)
	$path:="/api/v1/corp-scans/single"
Else 
	$path:="/api/v1/member-scans/single"
End if 
$path:=$path+"/"+[mchk_CheckLog:142]MemberCheckID:1
$formInput:=mchk_httpRequestMemberCheck(HTTP GET method:K71:1; $path).returned
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("mchk_ScanPersonResult")
DIALOG:C40("mchk_ScanPersonResult"; $formInput)
CLOSE WINDOW:C154($winRef)