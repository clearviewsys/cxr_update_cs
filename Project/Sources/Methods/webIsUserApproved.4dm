//%attributes = {"publishedWeb":true,"shared":true}
C_BOOLEAN:C305($0)


If (WAPI_getSession("isAuthorized")="true")
	$0:=True:C214
Else 
	$0:=False:C215
End if 