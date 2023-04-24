//selectAccountsInDateRange (vFromDate;vToDate;numToBoolean (cbApplyDateRange))
If (Form event code:C388=On Clicked:K2:4)
	bShowFlaggedRecords
	POST OUTSIDE CALL:C329(Current process:C322)
End if 
