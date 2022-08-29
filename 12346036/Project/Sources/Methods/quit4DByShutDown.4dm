//%attributes = {}
// Method: quit4DByShutDown
// Check if the file C:\Windows\Temp\ShutdownInProgress.txt exists, if yes shutdown 4D 

C_TEXT:C284($fileName; $fileToCheck; $cofirmationFile; $logFile; $logMsg)
C_BOOLEAN:C305($exitProcess)
C_TIME:C306($doc)

$exitProcess:=False:C215
$fileToCheck:="C:\\Windows\\Temp\\ShutdownInProgress.txt"
$cofirmationFile:="C:\\Windows\\Temp\\QuitComplete.txt"
$logFile:=Get 4D folder:C485(Logs folder:K5:19)+"ShutdownLog.txt"

If (Test path name:C476($logFile)#Is a document:K24:1)
	createFile($logFile)
End if 

$logMsg:=String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))+" - Shutdown  process monitor started"+Char:C90(CR ASCII code:K15:14)
appendToFile($logFile; ->$logMsg; False:C215)

If (Test path name:C476($fileToCheck)=Is a document:K24:1)
	DELETE DOCUMENT:C159($fileToCheck)
End if 


Repeat 
	
	If (Test path name:C476($fileToCheck)=Is a document:K24:1)
		FLUSH CACHE:C297
		
		$logMsg:=String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))+" - 4D Buffers Flushed successfully"+Char:C90(CR ASCII code:K15:14)
		appendToFile($logFile; ->$logMsg; False:C215)
		
		$exitProcess:=True:C214
	Else 
		DELAY PROCESS:C323(Current process:C322; (Random:C100%300)+1)
	End if 
	
Until ($exitProcess)

$doc:=Create document:C266($cofirmationFile)

If (ok=1)
	CLOSE DOCUMENT:C267($doc)
	
	$logMsg:=String:C10(Current date:C33(*))+" "+String:C10(Current time:C178(*))+" - 4D quitted successfully after manual or automatic windows shutdown"+Char:C90(CR ASCII code:K15:14)+Char:C90(CR ASCII code:K15:14)
	appendToFile($logFile; ->$logMsg; False:C215)
	
	QUIT 4D:C291
End if 




