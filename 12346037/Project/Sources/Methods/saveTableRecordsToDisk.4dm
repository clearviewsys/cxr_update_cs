//%attributes = {}
// saveTableRecordsToDisk (->table; ->primaryID;->descriptionPtr )



C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)
C_POINTER:C301($tablePtr; $CXR_IDPtr; $descPtr)
C_TEXT:C284($listboxSetName; $folderPath; $filePath; $filename)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Customers:3]  // change this table to any table that you are working on
		$CXR_IDPtr:=->[Customers:3]CustomerID:1
		$descPtr:=->[Customers:3]FullName:40
	: (Count parameters:C259=3)
		$tablePtr:=$1  // change this table to any table that you are working on
		$CXR_IDPtr:=$2
		$descPtr:=$3
	Else 
		assertInvalidNumberOfParams
End case 

$folderPath:=Select folder:C670("Pick a folder to save the records into")

If (OK=1)
	READ ONLY:C145($tablePtr->)
	$listboxSetName:=makeSetNameForTable($tablePtr)
	USE SET:C118($listboxSetName)
	
	$n:=Records in selection:C76($tablePtr->)
	
	If ($n>0)
		$i:=1
		$progress:=launchProgressBar("Saving records to file...")
		
		FIRST RECORD:C50($tablePtr->)
		
		Repeat 
			LOAD RECORD:C52($tablePtr->)
			$filename:=($CXR_IDPtr->)+"_"+($descPtr->)
			$filePath:=$folderPath+$filename  // e.g. 
			
			saveRecordToDisk($filePath; $tablePtr)
			NEXT RECORD:C51($tablePtr->)
			
			refreshProgressBar($progress; $i; $n)
			setProgressBarTitle($progress; "Processing :"+($CXR_IDPtr->))
			$i:=$i+1
		Until (($i>$n) | (isProgressBarStopped($progress)))
		
		HIDE PROCESS:C324($progress)
	End if 
	
End if 
