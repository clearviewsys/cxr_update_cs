If (Not:C34(isUserComplianceOfficer))
	ALERT:C41("Only a compliance officer can verify transactions.")
	[Invoices:5]isCheckedByCompliance:74:=Old:C35([Invoices:5]isCheckedByCompliance:74)  // revert to old value
End if 