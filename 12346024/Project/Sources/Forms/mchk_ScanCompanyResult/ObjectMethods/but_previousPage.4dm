If (Form event code:C388=On Clicked:K2:4)
	C_REAL:C285($page)
	$page:=Form:C1466.page-1
	
	C_TEXT:C284($path)
	$path:="/api/v1/member-scans/single"
	
	$path:=$path+"/"+String:C10(Form:C1466.scanResult.scanId)
	$path:=$path+"?pageIndex="+String:C10($page)
	C_OBJECT:C1216($data)
	$data:=mchk_httpRequestMemberCheck(HTTP GET method:K71:1; $path)
	Form:C1466.scanParam:=$data.returned.scanParam
	Form:C1466.scanResult:=$data.returned.scanResult
	Form:C1466.page:=$page
End if 