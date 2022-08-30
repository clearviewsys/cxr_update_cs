//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:27:23
// ----------------------------------------------------
// Method: BKP_XML_SaveScheduler
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($1; $0; $tiDocRef)
C_LONGINT:C283($i; $k)
C_POINTER:C301($pHour; $pChoice)
$tiDocRef:=$1

// set frequency
Case of 
	: (RNever=1)
		Frequency:="Never"
	: (RHourly=1)
		Frequency:="Hourly"
	: (RDaily=1)
		Frequency:="Daily"
	: (RWeekly=1)
		Frequency:="Weekly"
	: (RMonthly=1)
		Frequency:="Monthly"
End case 

ARRAY TEXT:C222($aDays; 7)
$aDays{1}:="Monday"
$aDays{2}:="Tuesday"
$aDays{3}:="Wednesday"
$aDays{4}:="Thursday"
$aDays{5}:="Friday"
$aDays{6}:="Saturday"
$aDays{7}:="Sunday"

// initialize the hourly times
For ($i; 1; Size of array:C274(aSchedulerNames))
	// find variables with hourly values
	If (Position:C15("_Hour"; aSchedulerNames{$i})#0)
		$pHour:=Get pointer:C304(aSchedulerNames{$i})
		$pChoice:=Get pointer:C304(Substring:C12(aSchedulerNames{$i}; 0; Position:C15("_"; aSchedulerNames{$i})-1)+"HourChoice")
		$pHour->:=$pChoice->{Int:C8($pChoice->)}+"-"+<>TimeOffset
	End if 
End for 

// month day
Monthly_Day:=Num:C11(MonthlyDayChoice{MonthlyDayChoice})

// there are only a few elements, so let's just use brute force; we're using SAX anyway

// top element
SAX OPEN XML ELEMENT:C853($tiDocRef; "Scheduler")

$tiDocRef:=BKP_XML_WriteData($tiDocRef; "Frequency"; BKP_GetTextVal("Frequency"))

SAX OPEN XML ELEMENT:C853($tiDocRef; "Hourly")
$tiDocRef:=BKP_XML_WriteData($tiDocRef; "Every"; BKP_GetTextVal("Hourly_Every"))
SAX CLOSE XML ELEMENT:C854($tiDocRef)

// write daily
SAX OPEN XML ELEMENT:C853($tiDocRef; "Daily")
For ($i; 1; Size of array:C274(aSchedulerNames))
	If (Position:C15("Daily"; aSchedulerNames{$i})#0)
		// we open the element as the simple name but when we reference it, we use the fully qualified name
		$tiDocRef:=BKP_XML_WriteData($tiDocRef; Substring:C12(aSchedulerNames{$i}; Position:C15("_"; aSchedulerNames{$i})+1); BKP_GetTextVal(aSchedulerNames{$i}))
	End if 
End for 
SAX CLOSE XML ELEMENT:C854($tiDocRef)

// do the weekly
SAX OPEN XML ELEMENT:C853($tiDocRef; "Weekly")
BKP_XML_WriteData($tiDocRef; "Every"; BKP_GetTextVal("Weekly_Every"))
For ($i; 1; Size of array:C274($aDays))
	SAX OPEN XML ELEMENT:C853($tiDocRef; $aDays{$i})
	For ($k; 1; Size of array:C274(aSchedulerNames))
		If ((Position:C15($aDays{$i}; aSchedulerNames{$k})#0) & ($aDays{$i}#aSchedulerNames{$k}))
			$tiDocRef:=BKP_XML_WriteData($tiDocRef; Substring:C12(aSchedulerNames{$k}; Position:C15("_"; aSchedulerNames{$k})+1); BKP_GetTextVal(aSchedulerNames{$k}))
		End if 
	End for 
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 
SAX CLOSE XML ELEMENT:C854($tiDocRef)

// write monthly, exactly same as daily!
SAX OPEN XML ELEMENT:C853($tiDocRef; "Monthly")
For ($i; 1; Size of array:C274(aSchedulerNames))
	If (Position:C15("Monthly"; aSchedulerNames{$i})#0)
		$tiDocRef:=BKP_XML_WriteData($tiDocRef; Substring:C12(aSchedulerNames{$i}; Position:C15("_"; aSchedulerNames{$i})+1); BKP_GetTextVal(aSchedulerNames{$i}))
	End if 
End for 
SAX CLOSE XML ELEMENT:C854($tiDocRef)

SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef