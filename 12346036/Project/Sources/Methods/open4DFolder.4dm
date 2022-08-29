//%attributes = {"shared":true}
CONFIRM:C162("Open which folder?"; "License Folder"; "4D Folder")
If (OK=1)
	SHOW ON DISK:C922(Get 4D folder:C485(Licenses folder:K5:11))
Else 
	SHOW ON DISK:C922(Get 4D folder:C485)
End if 