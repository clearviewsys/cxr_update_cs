//%attributes = {}
// handleApplyDateRangeObject (self)
// EVENT : On Load
C_POINTER:C301($1)
If (Form event code:C388=On Load:K2:1)
	$1->:=booleanToNum(<>applyDateRange)
End if 