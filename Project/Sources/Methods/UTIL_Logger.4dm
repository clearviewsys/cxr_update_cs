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



C_TEXT:C284($tLogFolderPath; $tLogPath; $tBackupPath; $tLogName; $tLogMessage; $message; $user)
C_LONGINT:C283($iSize; $i)
C_TIME:C306($hDocRef)

ON ERR CALL:C155("onErrCallIgnore")

If (True:C214)
	$tLogName:=$1
	$tLogMessage:=$2
	
	If (Count parameters:C259>=3)
		$user:=$3
	Else 
		$user:=""
	End if 
	
	$tLogMessage:=Replace string:C233($tLogMessage; Char:C90(Carriage return:K15:38); Char:C90(Space:K15:42))  //>> change carriage returns to spaces
	$tLogMessage:=Replace string:C233($tLogMessage; Char:C90(Line feed:K15:40); Char:C90(Space:K15:42))  //>> change line feeds to spaces
	
	$tLogFolderPath:=Get 4D folder:C485(Logs folder:K5:19; *)  //>> get log folder of host database
	
	If (Test path name:C476($tLogFolderPath)=Is a folder:K24:2)
		//>> all okay to continue
	Else 
		CREATE FOLDER:C475($tLogFolderPath)
	End if 
	
	$tLogPath:=$tLogFolderPath+$tLogName+".LOG"  //creates a log file for the calling method
	
	If (Test path name:C476($tLogPath)=Is a document:K24:1)
		$iSize:=Get document size:C479($tLogPath)
		If ($iSize>(1024*1024*3))  //>> greater than 3 megs start a new file
			$tBackupPath:=$tLogFolderPath+$tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+".LOG"
			$i:=0
			
			While (Test path name:C476($tBackupPath)=Is a document:K24:1)
				$i:=$i+1
				$tBackupPath:=$tLogFolderPath+$tLogName+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33))+"_"+String:C10($i; "000")+".LOG"
			End while 
			
			COPY DOCUMENT:C541($tLogPath; $tBackupPath; *)
			
			DELETE DOCUMENT:C159($tLogPath)  // May 4, 2012 07:54:54 -- I.Barclay Berry 
			$hDocRef:=Create document:C266($tLogPath)
		Else 
			$hDocRef:=Append document:C265($tLogPath)
		End if 
		
	Else 
		$hDocRef:=Create document:C266($tLogPath)
	End if 
	
	If (OK=1)  //doc opened
		$message:=String:C10(Current date:C33)+"\t"+String:C10(Current time:C178)+"\t"+$user+"\t"+$tLogMessage+"\r"
		
		SEND PACKET:C103($hDocRef; $message)
		CLOSE DOCUMENT:C267($hDocRef)
	Else 
		//ALERT($tLogPath+" could not be opened.")  //<>TODO need to remove alert
	End if 
	
	
	
	
Else 
	
End if 