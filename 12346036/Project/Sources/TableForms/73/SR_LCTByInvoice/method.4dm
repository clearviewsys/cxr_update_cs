C_LONGINT:C283(VCOUNT)
C_TEXT:C284($title)

If (Form event code:C388=On Load:K2:1)
	$title:="LCT Report by Invoice"
	
End if 

If (Form event code:C388=On Outside Call:K2:11)
	handleSR_LCTByInvoice
	$title:="LCT Report Invoice from "+String:C10(vFromDate)+" to "+String:C10(vToDate)
	If (vBranchID#"")
		$title:=$title+" for Branch "+vBranchID
	End if 
	vCount:=Size of array:C274(arrDates)
End if 

OBJECT SET TITLE:C194(*; "ReportTitle"; $title)
