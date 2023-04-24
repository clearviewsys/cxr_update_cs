//%attributes = {}
// emergencyActivate
// activate this computer (locally) as emergency activated (limited time)
// if the computer is already activated once it won't work 

C_BOOLEAN:C305($0; $success)


QUERY:C277([MACs:18]; [MACs:18]MACAddress:1=UTIL_getMacAddress)

If ([MACs:18]isEmergencyActivated:22=False:C215)
	READ WRITE:C146([MACs:18])
	LOAD RECORD:C52([MACs:18])
	[MACs:18]isEmergencyActivated:22:=True:C214
	[MACs:18]EmergencyActivationDate:23:=Current date:C33
	SAVE RECORD:C53([MACs:18])
	UNLOAD RECORD:C212([MACs:18])
	READ ONLY:C145([MACs:18])
	$success:=True:C214
Else 
	C_LONGINT:C283($activeFor; $maximumDays; $daysLeft)
	$maximumDays:=7
	$activeFor:=Current date:C33-[MACs:18]EmergencyActivationDate:23
	$daysLeft:=$maximumDays-$activeFor
	
	If ($activeFor>=$maximumDays)  // 5 days grace period
		myAlert("This computer has been activated once before.")
		$success:=False:C215
	Else 
		C_TEXT:C284($message)
		$message:="This computer was emergency activated on "+String:C10([MACs:18]EmergencyActivationDate:23)+"."+CRLF
		$message:=$message+"You have only "+String:C10($daysLeft)+" days to contact Clear View Systems to authorize this computer."
		myAlert($message)
		$success:=True:C214
	End if 
End if 

$0:=$success