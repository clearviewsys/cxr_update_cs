//%attributes = {}
CONFIRM:C162("Are you sure you want to submit all flagged reports to FINTRAC")
If (ok=1)
	DELAY PROCESS:C323(Current process:C322; 5000)
	ALERT:C41("Report has been submitted to TEST SERVER (3RD TIER FINTRAC)")
End if 