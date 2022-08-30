//%attributes = {}
// 

C_POINTER:C301($1)  // Jan 16, 2012 19:01:44 -- I.Barclay Berry 

C_LONGINT:C283($winRef)
C_TEXT:C284($form)
$form:=getClientBrowserFormName

$winRef:=Open form window:C675([CompanyInfo:7]; $form; Toolbar form window:K39:16)
DIALOG:C40([CompanyInfo:7]; $form)
SET MENU BAR:C67(1)
