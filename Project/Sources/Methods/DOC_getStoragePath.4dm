//%attributes = {"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 07/23/22, 08:04:46
// ----------------------------------------------------
// Method: DOC_getStoragePath
// Description
// 
//
// Parameters
// ----------------------------------------------------

//. EXECUTE ON SERVER PROPERTY IS SET SO CAN CREATE FOLDER STRUCTURE


C_TEXT:C284($1; $rootPath)  //OPTIONAL - root path 
C_LONGINT:C283($2; $iLevel)  //OPTIONAL - 0=parent path, 1=year, 2=month, 3=day
C_DATE:C307($3; $dDate)  // OPTIONAL

C_TEXT:C284($0; $tChronoPath)  // root path/year/month/day/

C_TEXT:C284($0)




If (Count parameters:C259>=1)
	$rootPath:=$1
Else 
	$rootPath:=Get 4D folder:C485(Data folder:K5:33; *)+"DocStorage"+Folder separator:K24:12
	
	If (Test path name:C476($rootPath)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($rootPath; *)
	End if 
	
End if 

If (Count parameters:C259>=2)
	$iLevel:=$2
Else 
	$iLevel:=3
End if 

If (Count parameters:C259>=3)
	$dDate:=$3
Else 
	$dDate:=Current date:C33
End if 


If (Substring:C12($rootPath; Length:C16($rootPath); 1)=Folder separator:K24:12)
Else 
	$rootPath:=$rootPath+Folder separator:K24:12
End if 

$tChronoPath:=$rootPath

If (Test path name:C476($rootPath)=Is a folder:K24:2)  // all is good
	
	If ($iLevel>=1)
		$tChronoPath:=$tChronoPath+String:C10(Year of:C25($dDate))+Folder separator:K24:12
		If (Test path name:C476($tChronoPath)=Is a folder:K24:2)  //alll still good
		Else 
			CREATE FOLDER:C475($tChronoPath)
		End if 
	End if 
	
	If ($iLevel>=2)
		$tChronoPath:=$tChronoPath+String:C10(Month of:C24($dDate); "00")+Folder separator:K24:12
		If (Test path name:C476($tChronoPath)=Is a folder:K24:2)  //still all good
		Else 
			CREATE FOLDER:C475($tChronoPath)
		End if 
	End if 
	
	If ($iLevel>=3)
		$tChronoPath:=$tChronoPath+String:C10(Day of:C23($dDate); "00")+Folder separator:K24:12
		If (Test path name:C476($tChronoPath)=Is a folder:K24:2)  //still all good
		Else 
			CREATE FOLDER:C475($tChronoPath)
		End if 
	End if 
	
End if 

If (Test path name:C476($tChronoPath)=Is a folder:K24:2)
	$0:=$tChronoPath
Else 
	$0:=$rootPath
End if 




