If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([MACs:18]isEmergencyActivated:22) & ([MACs:18]isEmergencyActivated:22=False:C215))
		[MACs:18]EmergencyActivationDate:23:=!00-00-00!
	End if 
End if 