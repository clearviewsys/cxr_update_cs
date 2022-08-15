checkInit
checkAddWarningOnTrue(([Invoices:5]isCheckedByCompliance:74=False:C215); "This invoice is not checked for compliance.")
checkAddErrorIf(Not:C34(isUserComplianceOfficer); "Sorry, this feature is restricted to compliance officers.")
checkAddErrorIf((([Invoices:5]isSuspicious:30) & Not:C34([Invoices:5]isAMLReportable:46)); "A suspicious transaction must be reportable.")
If (isValidationConfirmed)
	handleSaveButton(->[Invoices:5])
Else 
	BEEP:C151
End if 
