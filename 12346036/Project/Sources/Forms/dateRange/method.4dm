C_DATE:C307(vFromDate; vToDate; <>fromDate; <>toDate)
C_LONGINT:C283(vNumberOfDays)

If (Form event code:C388=On Load:K2:1)
	//If (vFromDate=Date("00/00/00"))
	//vFromDate:=◊fromDate
	//End if 
	//If (vToDate=Date("00/00/00"))
	//vToDate:=Current date
	//End if 
	
End if 

If (vToDate<vFromDate)
	colourizeObject("vFromDate"; White:K11:1; Red:K11:4)
	colourizeObject("vToDate"; White:K11:1; Red:K11:4)
Else 
	colourizeObject("vFromDate"; Black:K11:16; White:K11:1)
	colourizeObject("vToDate"; Black:K11:16; White:K11:1)
End if 
vNumberOfDays:=vToDate-vFromDate+1
