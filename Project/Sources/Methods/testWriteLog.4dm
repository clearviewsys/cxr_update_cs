//%attributes = {}
//
// >> ----------------------------------------------------
// >> User name(OS): Barclay Berry
// >> Date and time: 10/7/08, 14:47:54
// >> ----------------------------------------------------
// >> Method: UTIL_Log
// >> Description
// >> 
// >> 
// >> Parameters
// >> $1-Text-calling method name
// >> $2-Text-message to add to the log
// >> ----------------------------------------------------



C_TEXT:C284($1; $tCallingMethod; $tLogName; $tLogFolderPath; $tBackupPath)
C_TEXT:C284($2; $tLogMessage; $tLogPath)
C_REAL:C285($iSize)
C_LONGINT:C283($i)
C_TIME:C306($hDocRef)

C_BOOLEAN:C305($Debug)

$Debug:=True:C214

If ($Debug)
	
	$tCallingMethod:=$1
	$tLogMessage:=$2
	$tLogMessage:=Replace string:C233($tLogMessage; Char:C90(Carriage return:K15:38); Char:C90(Space:K15:42))  //>> change carriage returns to spaces
	$tLogMessage:=Replace string:C233($tLogMessage; Char:C90(Line feed:K15:40); Char:C90(Space:K15:42))  //>> change line feeds to spaces
	
	//$tLogName:=SYNC_Path_to_FileName (Structure file)  //>> Replace string($tLogName;".txt";"")  `>> strip just in case
	//$tLogName:=Replace string($tLogName;".4dbase";"")  //>> strip off component extension .4dbase
	//$tLogName:=Replace string($tLogName;".4dc";"")  //>> strip off component extension .4dc
	
	$tLogName:=Replace string:C233($tCallingMethod; " "; "")
	
	$tLogFolderPath:=Get 4D folder:C485(Logs folder:K5:19; *)  //>> get log folder of host database
	
	If (Test path name:C476($tLogFolderPath)=Is a folder:K24:2)
		//>> all okay to continue
	Else 
		CREATE FOLDER:C475($tLogFolderPath)
	End if 
	
	$tLogPath:=$tLogFolderPath+$tLogName+".LOG"  //creates a log file for the calling method
	
	If (Not:C34(Semaphore:C143("$UTIL_Log"; 300)))  //>> Wait 5 seconds if the semaphore already exists
		
		If (Test path name:C476($tLogPath)=Is a document:K24:1)
			$iSize:=Get document size:C479($tLogPath)
			If ($iSize>(1024*1024*3))  //>> greater than 3 megs start a new file
				$tBackupPath:=$tLogFolderPath+$tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+".LOG"
				$i:=0
				
				While (Test path name:C476($tBackupPath)=Is a document:K24:1)
					$i:=$i+1
					$tBackupPath:=$tLogFolderPath+$tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+"_"+String:C10($i; "000")+".LOG"
				End while 
				
				//COPY DOCUMENT($tPath;Replace string($tPath;".LOG";$tBackupPath))
				COPY DOCUMENT:C541($tLogPath; $tBackupPath; *)
				
				DELETE DOCUMENT:C159($tLogPath)  // May 4, 2012 07:54:54 -- I.Barclay Berry 
				$hDocRef:=Create document:C266($tLogPath)
			Else 
				$hDocRef:=Append document:C265($tLogPath)
			End if 
			
		Else 
			$hDocRef:=Create document:C266($tLogPath)
		End if 
		
		SEND PACKET:C103($hDocRef; String:C10(Current date:C33)+Char:C90(Tab:K15:37)+String:C10(Current time:C178)+Char:C90(Tab:K15:37)+Current user:C182+Char:C90(Tab:K15:37)+$tCallingMethod+Char:C90(Tab:K15:37)+$tLogMessage+Char:C90(Carriage return:K15:38))
		CLOSE DOCUMENT:C267($hDocRef)
		
		CLEAR SEMAPHORE:C144("$UTIL_Log")
	End if 
	
End if 