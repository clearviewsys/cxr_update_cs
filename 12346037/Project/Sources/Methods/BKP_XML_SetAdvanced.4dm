//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:27:29

// ----------------------------------------------------

// Method: BKP_XML_SetAdvanced

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_POINTER:C301($1; $aInfoLabels; $2; $aInfoValues)
C_TEXT:C284($tXPath)
C_LONGINT:C283($i)
ARRAY TEXT:C222(aAdvancedNames; 0)
ARRAY TEXT:C222(aAdvancedValues; 0)


$aInfoLabels:=$1
$aInfoValues:=$2
$tXPath:="Settings/Advanced"

// get the necessary info values; disregard "ItemsCount" elements

If (BKP_XML_SetGroupArrays($aInfoLabels; $aInfoValues; ->aAdvancedNames; ->aAdvancedValues; $tXPath)#-1)
	
	For ($i; 1; Size of array:C274(aAdvancedNames))
		Case of 
			: (Position:C15("FileSegmentation"; aAdvancedNames{$i})#0)
				// handle file segmentation

				aAdvancedNames{$i}:=Replace string:C233(aAdvancedNames{$i}; "/"; "_")
			: (Position:C15("SetNumber"; aAdvancedNames{$i})#0)
				// handle set number

				aAdvancedNames{$i}:=Replace string:C233(aAdvancedNames{$i}; "/"; "_")
			Else 
				// handle the rest

				aAdvancedNames{$i}:=BKP_XML_GetSimpleName(aAdvancedNames{$i})
		End case 
	End for 
	
	// now we prepare to dynamically create these variables

	For ($i; 1; Size of array:C274(aAdvancedNames))
		
		C_POINTER:C301($pVar)
		
		// get the pointer to a variable and its type

		$pVar:=Get pointer:C304(aAdvancedNames{$i})
		
		// set the variable

		BKP_XML_SetVariable($pVar; aAdvancedValues{$i})
		
	End for 
	
	// settings for transaction and backup fail

	If (WaitForEndOfTransaction=0)
		WaitAbort:=1
	End if 
	
	If (TryBackupAtTheNextScheduledDate=0)
		TryBackupAfter:=1
	Else 
		TryBackupOnDate:=1
	End if 
	
	// set the timeout

	C_LONGINT:C283($hour; $min)
	C_TEXT:C284($timeString)
	C_TIME:C306($time)
	
	$timeString:=Substring:C12(Timeout; 0; Position:C15("-"; Timeout)-1)
	$time:=Time:C179($timeString)
	$hour:=Num:C11(Substring:C12(String:C10($time; HH MM:K7:2); 0; Position:C15(":"; String:C10($time; HH MM:K7:2))))
	$min:=Num:C11(Substring:C12(String:C10($time; HH MM:K7:2); Position:C15(":"; String:C10($time; HH MM:K7:2))+1))
	TimeoutVal:=$min
	
	$timeString:=Substring:C12(TryToBackupAfter; 0; Position:C15("-"; TryToBackupAfter)-1)
	$time:=Time:C179($timeString)
	$hour:=Num:C11(Substring:C12(String:C10($time; HH MM:K7:2); 0; Position:C15(":"; String:C10($time; HH MM:K7:2))))
	$min:=Num:C11(Substring:C12(String:C10($time; HH MM:K7:2); Position:C15(":"; String:C10($time; HH MM:K7:2))+1))
	
	If ($min#0)
		TryToBackupAfterVal:=$min
		TryToBackupChoice:=2
	Else 
		TryToBackupAfterVal:=$hour
		TryToBackupChoice:=1
	End if 
	
	TryToBackupChoice{0}:=TryToBackupChoice{TryToBackupChoice}
	
	// settings for erase old backup

	If (EraseOldBackupBefore=1)
		EraseOldChoice:=2
	Else 
		EraseOldChoice:=1
	End if 
	
	EraseOldChoice{0}:=EraseOldChoice{EraseOldChoice}
	
	// compression settings

	BKP_XML_SetChoice(->CompressionChoice; CompressionRate)
	
	// interlacing settings

	BKP_XML_SetChoice(->InterlacingChoice; Interlacing)
	
	If (FileSegmentation_DefaultSize#0)
		// file segment settings

		BKP_XML_SetChoice(->SegmentChoice; String:C10(FileSegmentation_DefaultSize))
	Else 
		SegmentChoice:=1  // 1 is the None entry

		SegmentChoice{0}:=SegmentChoice{SegmentChoice}
	End if 
	
	// redundancy choice

	BKP_XML_SetChoice(->RedundancyChoice; Redondancy)
	
End if 