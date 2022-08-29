//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:27:56
// ----------------------------------------------------
// Method: BKP_XML_SetScheduler
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $aInfoLabels; $2; $aInfoValues)
C_TEXT:C284($tXPath)
C_LONGINT:C283($i)
ARRAY TEXT:C222(aSchedulerNames; 0)
ARRAY TEXT:C222(aSchedulerValues; 0)

$aInfoLabels:=$1
$aInfoValues:=$2
$tXPath:="Settings/Scheduler"

C_POINTER:C301($pVar)

// get the necessary info values; disregard "ItemsCount" elements
If (BKP_XML_SetGroupArrays($aInfoLabels; $aInfoValues; ->aSchedulerNames; ->aSchedulerValues; $tXPath)#-1)
	
	For ($i; 1; Size of array:C274(aSchedulerNames))
		If (Position:C15("Frequency"; aSchedulerNames{$i})#0)
			// handle frequency
			aSchedulerNames{$i}:=BKP_XML_GetSimpleName(aSchedulerNames{$i})
		Else 
			
			// get rid of all the Weekly_ for the days so we can have shorter variable names
			// when we dynamically generate them
			If ((Position:C15("Weekly/"; aSchedulerNames{$i})#0) & (Position:C15("Weekly/Every"; aSchedulerNames{$i})=0))
				aSchedulerNames{$i}:=Replace string:C233(aSchedulerNames{$i}; "Weekly/"; "")
			End if 
			
			// handle the rest
			aSchedulerNames{$i}:=Replace string:C233(aSchedulerNames{$i}; "/"; "_")
			
		End if 
	End for 
	
	// now we prepare to dynamically create these variables
	For ($i; 1; Size of array:C274(aSchedulerNames))
		
		// get the pointer to a variable and its type
		$pVar:=Get pointer:C304(aSchedulerNames{$i})
		
		// set the variable
		BKP_XML_SetVariable($pVar; aSchedulerValues{$i})
		
	End for 
	
	// set the scheduler setting
	$pVar:=Get pointer:C304("R"+Frequency)
	$pVar->:=1
	
	C_TEXT:C284(<>TimeOffset)
	<>TimeOffset:=Substring:C12(Daily_Hour; Position:C15("-"; Daily_Hour)+1)
	
	// time settings
	BKP_XML_SetChoice(->DailyHourChoice; Substring:C12(Daily_Hour; 0; Position:C15("-"; Daily_Hour)-1))
	BKP_XML_SetChoice(->MonthlyHourChoice; Substring:C12(Monthly_Hour; 0; Position:C15("-"; Monthly_Hour)-1))
	BKP_XML_SetChoice(->MondayHourChoice; Substring:C12(Monday_Hour; 0; Position:C15("-"; Monday_Hour)-1))
	BKP_XML_SetChoice(->TuesdayHourChoice; Substring:C12(Tuesday_Hour; 0; Position:C15("-"; Tuesday_Hour)-1))
	BKP_XML_SetChoice(->WednesdayHourChoice; Substring:C12(Wednesday_Hour; 0; Position:C15("-"; Wednesday_Hour)-1))
	BKP_XML_SetChoice(->ThursdayHourChoice; Substring:C12(Thursday_Hour; 0; Position:C15("-"; Thursday_Hour)-1))
	BKP_XML_SetChoice(->FridayHourChoice; Substring:C12(Friday_hour; 0; Position:C15("-"; Friday_hour)-1))
	BKP_XML_SetChoice(->SaturdayHourChoice; Substring:C12(Saturday_Hour; 0; Position:C15("-"; Saturday_Hour)-1))
	BKP_XML_SetChoice(->SundayHourChoice; Substring:C12(Sunday_Hour; 0; Position:C15("-"; Sunday_Hour)-1))
	
	// set day
	BKP_XML_SetChoice(->MonthlyDayChoice; String:C10(Monthly_Day))
	
End if 