C_TEXT:C284(vProgressTitle)
C_LONGINT:C283(vProgressCompleted; vProgressTotal)
C_BOOLEAN:C305(vProgressBarStopped)

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(eThermometer)
		//vProgressCompleted:=0
		//vProgressTotal:=` this line should be commented
		eThermometer:=0
		vProgressBarStopped:=False:C215
		SET TIMER:C645(2)
		
		
	: (Form event code:C388=On Timer:K2:25)
		If ((vProgressBarStopped=True:C214) | (vProgressCompleted>=vProgressTotal))
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		eThermometer:=(vProgressCompleted/vProgressTotal)*100
		
End case 
