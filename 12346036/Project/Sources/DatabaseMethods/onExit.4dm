// Database Method: On Exit

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.


C_LONGINT:C283($processNumber; $startingProcess)
<>Shell_Quit:=True:C214  // Our message to other processes that it's time to quit.

Case of 
	: (Application type:C494=4D Local mode:K5:1)
		$startingProcess:=3
	: (Application type:C494=4D Remote mode:K5:5)
		$startingProcess:=2
	: (Application type:C494=4D Server:K5:6)
		$startingProcess:=4
End case 

LogUserLoggingOut(String:C10(getApplicationUser); getCurrentMachineName)  //Nov 23, 2019 -- Blake Pickard

//  @tiran made this change. This code is causing a crash on standalones.
// @blake : FYI An update process appears an doesn't stop ; 
//For ($processNumber;$startingProcess;Count user processes)
//RESUME PROCESS($processNumber)  // Get any delayed or paused processes moving again.
//POST OUTSIDE CALL($processNumber)  // If it's displaying a form, tell it to check its messages.
//End for 


If (Application type:C494=4D Local mode:K5:1)
	USER_Save_Groups
End if 

SYNC_Exit
iLB_ShutDown
IM_shutdown
SP_stop  //stop the stored procedure

//Ltg_Shutdown 