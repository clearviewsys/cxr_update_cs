//%attributes = {}
// Method: Quit
// Asks for a user answer and wait 30 secs for a response, else quits automatically
// review #review #old 
// Modified By Jaime Alvarez at 7/25/2017

C_LONGINT:C283($i)
C_LONGINT:C283(quitByUserLocal)
C_LONGINT:C283($quitByDialogProcess)
C_BOOLEAN:C305($quitByTimer)
C_LONGINT:C283($maxSec)

$i:=0
$maxSec:=30  // Max time (in seconds) to quit 4D
quitByUserLocal:=2
$quitByDialogProcess:=New process:C317("quit4DByDialog"; 0; "quit4DByDialog")
DELAY PROCESS:C323(Current process:C322; (Random:C100%60)+1)  // Wait a ramdom time between 1 and 60 ticks. 1 Tick = 1/60 sec

SET PROCESS VARIABLE:C370($quitByDialogProcess; callerProcess; Current process:C322)

// Wait 30 seconds, if did not receive an answer quit the app
Repeat 
	DELAY PROCESS:C323(Current process:C322; 60)  // Sleep 1 second
	$i:=$i+1
Until (($i>=$maxSec) | (quitByUserLocal=0) | (quitByUserLocal=1))

Case of 
		
	: (quitByUserLocal=0)  // User clicked cancel
		// Ignore 
		
	: (quitByUserLocal=1)  // User clicked Quit (yes)
		
		FLUSH CACHE:C297
		QUIT 4D:C291
		
	: (quitByUserLocal=2)  // User did not pick either quit or cancel
		
		
		SET PROCESS VARIABLE:C370($quitByDialogProcess; quitByTimer; True:C214)
		POST OUTSIDE CALL:C329($quitByDialogProcess)
		DELAY PROCESS:C323(Current process:C322; (Random:C100%60)+1)  // Wait a ramdom time between 1 and 60 ticks. 1 Tick = 1/60 sec
		FLUSH CACHE:C297
		QUIT 4D:C291
		
End case 

