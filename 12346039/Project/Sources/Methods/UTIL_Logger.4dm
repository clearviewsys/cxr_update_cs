//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/15/15, 14:38:43
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: UTLI_Log2
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(LOG_tLogName; LOG_tLogMessage)

C_TEXT:C284($tLogFolderPath; $tLogPath; $tBackupPath)
C_LONGINT:C283($iSize; $i)
C_TIME:C306($hLogRef)

ON ERR CALL:C155("onErrCallIgnore")

Repeat 
	
	//C_TEXT($1;$tLogName)
	//($2;$tLogMessage)
	
	//$tLogName:=$1
	//$tLogMessage:=$2
	
	If (Not:C34(Semaphore:C143("$UTIL_Log"; 300)))  //>> Wait 5 seconds if the semaphore already exists
		
		If (LOG_tLogName="")  //do nothing
		Else 
			LOG_tLogMessage:=Replace string:C233(LOG_tLogMessage; Char:C90(Carriage return:K15:38); Char:C90(Space:K15:42))  //>> change carriage returns to spaces
			LOG_tLogMessage:=Replace string:C233(LOG_tLogMessage; Char:C90(Line feed:K15:40); Char:C90(Space:K15:42))  //>> change line feeds to spaces
			
			
			$tLogFolderPath:=Get 4D folder:C485(Logs folder:K5:19; *)  //>> get log folder of host database
			
			If (Test path name:C476($tLogFolderPath)=Is a folder:K24:2)
				//>> all okay to continue
			Else 
				CREATE FOLDER:C475($tLogFolderPath)
			End if 
			
			$tLogPath:=$tLogFolderPath+LOG_tLogName+".LOG"  //creates a log file for the calling method
			
			//If (Not(Semaphore("$UTIL_Log";300)))  //>> Wait 5 seconds if the semaphore already exists
			
			If (Test path name:C476($tLogPath)=Is a document:K24:1)
				$iSize:=Get document size:C479($tLogPath)
				If ($iSize>(1024*1024*3))  //>> greater than 3 megs start a new file
					$tBackupPath:=$tLogFolderPath+LOG_tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+".LOG"
					$i:=0
					
					While (Test path name:C476($tBackupPath)=Is a document:K24:1)
						$i:=$i+1
						$tBackupPath:=$tLogFolderPath+LOG_tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+"_"+String:C10($i; "000")+".LOG"
					End while 
					
					//COPY DOCUMENT($tPath;Replace string($tPath;".LOG";$tBackupPath))
					COPY DOCUMENT:C541($tLogPath; $tBackupPath; *)
					
					DELETE DOCUMENT:C159($tLogPath)  // May 4, 2012 07:54:54 -- I.Barclay Berry 
					$hLogRef:=Create document:C266($tLogPath)
				Else 
					$hLogRef:=Append document:C265($tLogPath)
				End if 
				
			Else 
				$hLogRef:=Create document:C266($tLogPath)
			End if 
			
			//SEND PACKET($hLogRef;String(Current date)+Char(Tab)+String(Current time)+Char(Tab)+Current user+Char(Tab)+$tLogName+Char(Tab)+$tLogMessage+Char(Carriage return))
			SEND PACKET:C103($hLogRef; String:C10(Current date:C33)+Char:C90(Tab:K15:37)+String:C10(Current time:C178)+Char:C90(Tab:K15:37)+Current user:C182+Char:C90(Tab:K15:37)+LOG_tLogMessage+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))  // ` Jan 27, 2014 09:23:50 -- I.Barclay Berry - removed Log Name
			
			CLOSE DOCUMENT:C267($hLogRef)
			
			//CLEAR SEMAPHORE("$UTIL_Log")
			//End if 
			
			LOG_tLogName:=""
			LOG_tLogMessage:=""
		End if 
		
		CLEAR SEMAPHORE:C144("$UTIL_Log")
	End if 
	
	
	PAUSE PROCESS:C319(Current process:C322)
Until (<>SHELL_QUIT)