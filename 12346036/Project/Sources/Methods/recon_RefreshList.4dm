//%attributes = {}
C_BOOLEAN:C305(recon_isTouched)


If (recon_isTouched)
	CONFIRM:C162("Do you want to refresh all arrays? Unsaved reconciliations will be lost!"; "Refresh only"; "Save and Refresh")
	If (OK=0)
		handleSaveReconcileButton
		recon_isTouched:=False:C215
	End if 
	recon_handleReconciliationListB
Else 
	recon_handleReconciliationListB
End if 

