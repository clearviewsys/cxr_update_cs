//%attributes = {}
// quitByShutDownLauncher
// Launch a process in order to know if a shutdown was requested
C_LONGINT:C283($quitByDialogProcess)

If (Is Windows:C1573)
	$quitByDialogProcess:=New process:C317("quit4DByShutdown"; 0; "quit4DByShutdown")
End if 
