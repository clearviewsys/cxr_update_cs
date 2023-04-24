//%attributes = {}
// launchBrowser_M

C_POINTER:C301($1)

C_LONGINT:C283($winRef)
C_TEXT:C284($form)
$form:=getClientBrowserFormName

If ($form#"")
	$winRef:=Open form window:C675($form; Toolbar form window:K39:16)
	DIALOG:C40($form)
	SET MENU BAR:C67(1)
End if 
