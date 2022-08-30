//%attributes = {}
C_OBJECT:C1216($form)
$form:=New object:C1471()

$form.toNumber:=""

C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("SendTestText"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("SendTestText"; $form)
CLOSE WINDOW:C154($winRef)