//%attributes = {}
// handleDateWidget ( ->widget; default date})
// EVENTS: On Before Keystroke ; On Data Change ; On Load

// Function: Interprets what has been entered as a date
//    And checks to see if a "function" key is hit and acts accordingly

// Place in the object method of a date field or variable
//   HandleDate(Self)

// Required: Set the date field's On Before Keystroke and
//   On Data Change events to on.

// Project Method: HandleDate

C_DATE:C307($Date; $2)
C_POINTER:C301($1; $DateFieldPtr)
C_TEXT:C284($Keystroke)

Case of 
	: (Count parameters:C259=1)
		$DateFieldPtr:=$1
	: (Count parameters:C259=2)
		$DateFieldPtr:=$1
		$DateFieldPtr->:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET FORMAT:C236($dateFieldPtr->; Char:C90(<>dateFormat+1))  // Blake found this bug (off by one)
		OBJECT SET FILTER:C235($dateFieldPtr->; <>dateEntryFilter)
		
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		$date:=convStringToDate(Get edited text:C655)
		//OBJECT SET FORMAT($dateFieldPtr->;Char(<>dateFormat))
		
		Case of   // Check to see if a "function" key is hit
			: (($Keystroke="'") | ($Keystroke="w"))  // Add a day
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; 0; 0; 1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke=";")  // Subtract a day
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; 0; 0; -1)
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="]") | ($Keystroke="n"))  // next Month
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; 0; 1; 0)
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="[") | ($Keystroke="p"))  // Previous Month
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; 0; -1; 0)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="=")  // Add a Year
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; 1; 0; 0)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="-")  // Subtract a Year
				//$Date:=convStringToDate (Get edited text)
				$DateFieldPtr->:=Add to date:C393($Date; -1; 0; 0)
				FILTER KEYSTROKE:C389("")
				
				
			: ($Keystroke="T")  // Today
				FILTER KEYSTROKE:C389("")
				//GOTO OBJECT($DateFieldPtr->)
				$DateFieldPtr->:=Current date:C33
				HIGHLIGHT TEXT:C210($DateFieldPtr->; 0; 50)
				
			: ($Keystroke="B")  // First of Month
				$DateFieldPtr->:=newDate(1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="E")  // End of month
				$DateFieldPtr->:=newDate(1; Month of:C24(Current date:C33)+1)-1  // first day of next month -1
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="Y")  // BOyear
				$DateFieldPtr->:=newDate(1; 1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="R")  // End of year
				$DateFieldPtr->:=newDate(1; 1; Year of:C25(Current date:C33)+1)-1
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="x")  // nullDate
				$DateFieldPtr->:=nullDate
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="c") | ($Keystroke="?"))  // Open calendar
				datePicked:=$DateFieldPtr->
				C_LONGINT:C283($winRef)
				$winRef:=Open form window:C675("DateCalendarDialog"; Modal dialog box:K34:2; Horizontally centered:K39:1; Vertically centered:K39:4)
				DIALOG:C40("DateCalendarDialog")
				CLOSE WINDOW:C154($winRef)
				If (OK=1)
					$DateFieldPtr->:=datePicked
				End if 
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)  // Interpret the entry
		//$DateFieldPtr->:=convStringToDate (Get edited text)
		$DateFieldPtr->:=Date:C102(Get edited text:C655)
		
		
End case 


Case of 
		//: (date($DateFieldPtr->)=Current date)
		//setFieldRGBColour ($DateFieldPtr;0;200;00;255;255;255)
		
End case 
