//%attributes = {}


If (newVersion)
	
	myConfirm("There is a new version. Do you want to install it?"; "Yes"; "No")
	
	If (Ok=1)
		automaticUpdates
		myAlert("Please check the 'AutomaticUpdates.log' log File located at:\n "+Get 4D folder:C485(Logs folder:K5:19))
	End if 
	
Else 
	
	myAlert("You are using the latest Version.")
	
End if 



