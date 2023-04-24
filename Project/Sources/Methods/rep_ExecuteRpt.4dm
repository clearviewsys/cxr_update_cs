//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/13/13, 22:08:28
// ----------------------------------------------------
// Method: rep_ExecuteRpt
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($sMenuRef)
C_TEXT:C284($sParam; $SelectedMenuItem)

$sMenuRef:=Menu selected:C152
$sParam:=Get selected menu item parameter:C1005

$SelectedMenuItem:=Get menu item:C422(Menu selected:C152\65536; Menu selected:C152%65536)

//TRACE