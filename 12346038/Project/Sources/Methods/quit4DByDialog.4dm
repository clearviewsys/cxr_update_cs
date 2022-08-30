//%attributes = {}
// Method: quit4DByDialog
// Wait for a user confirmation in order to quit. 
// After 30 seconds the system will quit if we do not have confirmation


C_BOOLEAN:C305(quitByTimer)
C_LONGINT:C283(quitByUser)
C_LONGINT:C283(callerProcess)
C_BOOLEAN:C305($dialogOpened)

quitByTimer:=False:C215
quitByUser:=2  // Indeterminate


Repeat 
	
	If (Not:C34($dialogOpened))
		myConfirm("Are you sure you want to Quit?"; "Yes"; "No")
		$dialogOpened:=True:C214
	End if 
	
	If (Ok=1)
		quitByUser:=1
	Else 
		quitByUser:=0
	End if 
	SET PROCESS VARIABLE:C370(callerProcess; quitByUserLocal; quitByUser)
	DELAY PROCESS:C323(Current process:C322; (Random:C100%60)+1)  // Wait a ramdom time between 1 and 60 ticks. 1 Tick = 1/60 sec
	
Until (quitByUser=0) | (quitByUser=1) | (quitByTimer)





