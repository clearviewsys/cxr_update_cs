

C_TEXT:C284($temp)

If (Form event code:C388=On Clicked:K2:4)
	$temp:=[CalendarEvents:80]Target_BID:19
	//[CalendarEvents]TargetBranchID:=""
	pickBranchID(->[CalendarEvents:80]Target_BID:19)
	
	If (OK=0)
		[CalendarEvents:80]Target_BID:19:=$temp
	End if 
	
End if 