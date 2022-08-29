//%attributes = {"executedOnServer":true}
// $ref:=Execute on server("Make_update";512*1024;"P_Update")

C_TEXT:C284($1; $newStructureFile)
C_BOOLEAN:C305($2; $upgradeStruc; $3; $upgradeComp; $4; $upgradeRes; $5; $upgradePlu)
C_BOOLEAN:C305($0; $abort)


C_TEXT:C284($sourcePath; $targetPath)
C_TEXT:C284($cmd; $schTasksCmd; $fileName; $st; $taskName; $schedCopyCmd)
C_TEXT:C284($open4D; $open4DCmd; $oldVersionFolder)
C_TIME:C306($schedCopyDoc; $open4DDoc; $docScheduledTaskBat)
C_DATE:C307($dateRef)
C_LONGINT:C283($minBetweenRestars)

$sourcePath:=System folder:C487(Desktop:K41:16)+"CXR_NewRelease"+Folder separator:K24:12
$targetPath:=Get 4D folder:C485(Database folder:K5:14)

$upgradeStruc:=True:C214
$upgradeComp:=False:C215
$upgradeRes:=False:C215
$upgradePlu:=False:C215
$abort:=False:C215


Case of 
		
	: (Count parameters:C259=0)
		// Just for testing
		$newStructureFile:=getKeyValue("au.url.update.latestversion"; "CXR4955.4DB")
		
		
	: (Count parameters:C259=1)
		$newStructureFile:=$1
		
	: (Count parameters:C259=2)
		$newStructureFile:=$1
		$upgradeStruc:=$2
		
	: (Count parameters:C259=3)
		$newStructureFile:=$1
		$upgradeStruc:=$2
		$upgradeComp:=$3
		
	: (Count parameters:C259=4)
		$newStructureFile:=$1
		
		$upgradeStruc:=$2
		$upgradeComp:=$3
		$upgradeRes:=$4
		
	: (Count parameters:C259=5)
		
		$newStructureFile:=$1
		
		$upgradeStruc:=$2
		$upgradeComp:=$3
		$upgradeRes:=$4
		$upgradePlu:=$5
		
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($st2; $schedCopy; $schedCopyCmd; $sourceFile; $dt; $schedCopy; $schedCopyCmd; $schedTask)
C_TEXT:C284($logMsg; $schedTaskCmd)

// Remove last folder path char if needed
If (Substring:C12($sourcePath; Length:C16($sourcePath); 1)=Folder separator:K24:12)
	$sourcePath:=Substring:C12($sourcePath; 1; Length:C16($sourcePath)-1)
End if 

If (Substring:C12($targetPath; Length:C16($targetPath); 1)=Folder separator:K24:12)
	$targetPath:=Substring:C12($targetPath; 1; Length:C16($targetPath)-1)
End if 

$minBetweenRestars:=Num:C11(getKeyValue("au.min.between.restarts"; "4"))

C_TIME:C306($tmp)
$tmp:=Time:C179(Time string:C180(Current time:C178(*)+($minBetweenRestars*60)))

$st:=String:C10($tmp)
If (Substring:C12($st; 1; 2)="24")
	$st:=Replace string:C233($st; "24:"; "00:")
End if 



$st:=Substring:C12($st; 1; 6)+"01"


$tmp:=Time:C179(Time string:C180($tmp+(($minBetweenRestars+1)*60)))

$st2:=String:C10($tmp)
If (Substring:C12($st2; 1; 2)="24")
	$st2:=Replace string:C233($st2; "24:"; "00:")
End if 

$st2:=Substring:C12($st2; 1; 6)+"01"


$schedCopy:=Temporary folder:C486+"UpdateTask.bat"
$schedCopyCmd:="REM "+$schedCopy+CRLF
$schedCopyCmd:=$schedCopyCmd+"echo off"+CRLF

$newStructureFile:=$targetPath+Folder separator:K24:12+$newStructureFile

// -----------------------------------------------------------------------------------
// Save essentials
// -----------------------------------------------------------------------------------

$oldVersionFolder:="ReplacedFiles_"+String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))
$oldVersionFolder:=Replace string:C233($oldVersionFolder; "-"; "_")
$oldVersionFolder:=Replace string:C233($oldVersionFolder; "/"; "_")
$oldVersionFolder:=Replace string:C233($oldVersionFolder; ":"; "")
$oldVersionFolder:=getKeyValue("au.oldFilesPath"; Get 4D folder:C485(Database folder:K5:14)+$oldVersionFolder)

If (Test path name:C476($oldVersionFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($oldVersionFolder)
End if 


// -----------------------------------------------------------------------------------
// Saving essential files
// -----------------------------------------------------------------------------------

$schedCopyCmd:=$schedCopyCmd+"REM SAVING ESSENTIALS"+CRLF+CRLF

$schedCopyCmd:=$schedCopyCmd+"CD "+$oldVersionFolder+CRLF



If ($upgradeStruc)
	$sourceFile:=$targetPath+Folder separator:K24:12+"*.4DB"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder)
	
	$sourceFile:=$targetPath+Folder separator:K24:12+"*.4DIndy"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder)
	
	$sourceFile:=$targetPath+Folder separator:K24:12+"*.Match"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder)
End if 

If ($upgradeComp)
	$sourceFile:=$targetPath+Folder separator:K24:12+"Components"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder; True:C214)
End if 


If ($upgradeRes)
	$sourceFile:=$targetPath+Folder separator:K24:12+"Resources"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder; True:C214)
End if 


If ($upgradePlu)
	$sourceFile:=$targetPath+Folder separator:K24:12+"Plugins"
	$schedCopyCmd:=$schedCopyCmd+createIfExistAndMove($sourceFile; $oldVersionFolder; True:C214)
End if 

$dt:=String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))
$dt:=Replace string:C233($dt; "-"; "_")
$dt:=Replace string:C233($dt; "/"; "_")
$dt:=Replace string:C233($dt; ":"; "")
$dt:=$sourcePath+"_"+$dt

// -----------------------------------------------------------------------------------
$schedCopyCmd:=$schedCopyCmd+CRLF
$schedCopyCmd:=$schedCopyCmd+"REM COPYING NEW VERSION TO "+$targetPath+CRLF
$schedCopyCmd:=$schedCopyCmd+"ROBOCOPY "+Char:C90(Double quote:K15:41)+$sourcePath+Char:C90(Double quote:K15:41)+" "+Char:C90(Double quote:K15:41)+$targetPath+Char:C90(Double quote:K15:41)+" /e"+CRLF+CRLF
//$schedCopyCmd:=$schedCopyCmd+"REM "+Char(Double quote)+Application file+Char(Double quote)+" -s "+Char(Double quote)+$newStructureFile+Char(Double quote)+CRLF 
$schedCopyCmd:=$schedCopyCmd+"MOVE "+Substring:C12($sourcePath; 1; Length:C16($sourcePath))+" "+$dt+CRLF
//UTIL_Log ("AutomaticUpdates";" Bat file content: "+$schedCopy)

$schedCopyDoc:=Create document:C266($schedCopy)

If (OK=1)
	
	SEND PACKET:C103($schedCopyDoc; $schedCopyCmd)
	CLOSE DOCUMENT:C267($schedCopyDoc)
	
	$logMsg:=" - Bat File created: "+$schedCopy+CRLF
	$logMsg:=$logMsg+" - Bat File contents: "+$schedCopyCmd+CRLF
	UTIL_Log("AutomaticUpdates"; $logMsg)
	
End if 

// ------------------------------------------------------------
// Create schedule task to open 4th Dimension
// ------------------------------------------------------------

$open4D:=Temporary folder:C486+"Open4D.bat"
$open4DCmd:="REM "+$open4D+CRLF
$open4DCmd:=$open4DCmd+"echo off"+CRLF
$open4DCmd:=$open4DCmd+"REM KILL 4D If is running"+CRLF
$open4DCmd:=$open4DCmd+"QPROCESS "+Char:C90(Double quote:K15:41)+getFileName(Application file:C491)+Char:C90(Double quote:K15:41)+">NUL"+CRLF
$open4DCmd:=$open4DCmd+"If %ERRORLEVEL% EQU 0 ( "+CRLF
$open4DCmd:=$open4DCmd+"   Taskkill /IM "+Char:C90(Double quote:K15:41)+getFileName(Application file:C491)+Char:C90(Double quote:K15:41)+" /F "+CRLF
$open4DCmd:=$open4DCmd+")"+CRLF
$open4DCmd:=$open4DCmd+"REM OPEN 4D/4D server"+CRLF
$open4DCmd:=$open4DCmd+Char:C90(Double quote:K15:41)+Application file:C491+Char:C90(Double quote:K15:41)+" -s "+Char:C90(Double quote:K15:41)+$newStructureFile+Char:C90(Double quote:K15:41)+CRLF


$open4DDoc:=Create document:C266($open4D)
If (OK=1)
	SEND PACKET:C103($open4DDoc; $open4DCmd)
	CLOSE DOCUMENT:C267($open4DDoc)
	
	$logMsg:="Bat File created: "+$open4D+CRLF
	$logMsg:=$logMsg+"Bat File contents: "+$open4DCmd+CRLF
	
	UTIL_Log("AutomaticUpdates"; $logMsg)
	
	
End if 

// ---------------------------------------------------------------------------------
// Create the UpdateTask.bat on: C:\Users\<User>\AppData\Local\Temp\UpdateTask.bat
// ---------------------------------------------------------------------------------

$schedTask:=Temporary folder:C486+"ScheduledTask.bat"

$schedTaskCmd:="REM "+$schedTask+CRLF
$schedTaskCmd:=$schedTaskCmd+"REM SCHTASKS /Query | FIND/I \"CXR_Update\""+CRLF
$schedTaskCmd:=$schedTaskCmd+"REM SCHTASKS /Query | FIND/I \"CXR_Open4D1\""+CRLF
// $schedTaskCmd:=$schedTaskCmd+"REM SCHTASKS /Query | FIND/I \"CXR_Open4D2\""+CRLF 


$schedTaskCmd:=$schedTaskCmd+"echo off"+CRLF

$schedTaskCmd:=$schedTaskCmd+"Schtasks /f /delete /tn CXR_Update"+CRLF
$schedTaskCmd:=$schedTaskCmd+"Schtasks /f /delete /tn CXR_Open4D1"+CRLF
// $schedTaskCmd:=$schedTaskCmd+"Schtasks /f /delete /tn CXR_Open4D2"+CRLF 

$schedTaskCmd:=$schedTaskCmd+"Schtasks /create /tn CXR_Update /sc ONCE /st "+$st+" /tr \""+$schedCopy+"\""+CRLF
$schedTaskCmd:=$schedTaskCmd+"Schtasks /create /tn CXR_Open4D1 /sc ONCE /st "+$st2+" /tr \""+$open4D+"\""+CRLF
//$schedTaskCmd:=$schedTaskCmd+"Schtasks /create /tn CXR_Open4D2 /sc ONCE /st "+$st3+" /tr \""+$open4D+"\""+CRLF +CRLF 


// NOTE: to list tasks on cmd:
// SCHTASKS /Query | FIND/I "CXR_Open4D1"
// SCHTASKS /Query | FIND/I "CXR_Open4D2"
// SCHTASKS /Query | FIND/I "CXR_Update"

UTIL_Log("AutomaticUpdates"; "Schedule task command created: "+$schTasksCmd)

// ------------------------------------------------------------
// Example of the ScheduledTask.bat contents:
// REM C:\Users\jalvarez\AppData\Local\Temp\ScheduledTask.bat
// echo off
// Schtasks/f/delete /tn CXR_Update
// Schtasks/f/delete /tn CXR_Open4D1
// Schtasks/f/delete /tn CXR_Open4D2
// Schtasks/create/tn CXR_Update/sc ONCE/st 23:02:00 /tr "C:\\Users\\jalvarez\\AppData\\Local\temp\\UpdateTask.bat"
// Schtasks/create/tn CXR_Open4D1/sc ONCE/st 23:03:00 /tr "C:\\Users\\jalvarez\\AppData\\Local\temp\\Open4D.bat"
// Schtasks/create/tn CXR_Open4D2/sc ONCE/st 23:04:00 /tr "C:\\Users\\jalvarez\\AppData\\Local\temp\\Open4D.bat"


C_TIME:C306($schedTaskDoc)
$schedTaskDoc:=Create document:C266($schedTask)

If (OK=1)
	
	SEND PACKET:C103($schedTaskDoc; $schedTaskCmd)
	CLOSE DOCUMENT:C267($schedTaskDoc)
	
	UTIL_Log("AutomaticUpdates"; "Schedule task command created: "+$schedTask)
	
	C_TEXT:C284($input; $output)
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "true")  // Sync Mode
	
	LAUNCH EXTERNAL PROCESS:C811($schedTask; $input; $output)
	
	C_TEXT:C284($datafile)
	$dataFile:=Data file:C490
	
	UTIL_Log("AutomaticUpdates"; " Automatic Update process finished!")
	
	// Save the current data file path for be opened on next start up
	CXR_setSetting("automatic_updates_dataFile"; getDataFilePath)
	
	If (Application type:C494=4D Server:K5:6)
		FLUSH CACHE:C297
		QUIT 4D:C291(10)
	Else 
		FLUSH CACHE:C297
		QUIT 4D:C291
	End if 
	
	
End if 

$0:=Not:C34($abort)

