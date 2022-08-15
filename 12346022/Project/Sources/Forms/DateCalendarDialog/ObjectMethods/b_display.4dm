C_DATE:C307($Date)
C_TEXT:C284($Keystroke)

Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		$date:=convStringToDate(Get edited text:C655)
		//OBJECT SET FORMAT($dateFieldPtr->;Char(<>dateFormat))
		
		Case of   // Check to see if a "function" key is hit
			: ($Keystroke="'")  // Add a day
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; 0; 0; 1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke=";")  // Subtract a day
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; 0; 0; -1)
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="]") | ($Keystroke="n"))  // next Month
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; 0; 1; 0)
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="[") | ($Keystroke="p"))  // Previous Month
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; 0; -1; 0)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="=")  // Add a Year
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; 1; 0; 0)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="-")  // Subtract a Year
				//$Date:=convStringToDate (Get edited text)
				datePicked:=Add to date:C393($Date; -1; 0; 0)
				FILTER KEYSTROKE:C389("")
				
				
			: ($Keystroke="T")  // Today
				FILTER KEYSTROKE:C389("")
				//GOTO OBJECT($DateFieldPtr->)
				datePicked:=Current date:C33
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="B")  // First of Month
				datePicked:=newDate(1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="E")  // End of month
				datePicked:=newDate(1; Month of:C24(Current date:C33)+1)-1  // first day of next month -1
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="Y")  // BOyear
				datePicked:=newDate(1; 1)
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="R")  // End of yeaR
				datePicked:=newDate(1; 1; Year of:C25(Current date:C33)+1)-1
				FILTER KEYSTROKE:C389("")
				
			: ($Keystroke="x")  // nullDate
				datePicked:=nullDate
				FILTER KEYSTROKE:C389("")
				
		End case 
	: (Form event code:C388=On After Keystroke:K2:26)
		Case of 
			: (Match regex:C1019("[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9]?[0-9]?"; Get edited text:C655))
				datePicked:=convStringToDate(Get edited text:C655)
				
		End case 
End case 


Case of 
		//: (date($DateFieldPtr->)=Current date)
		//setFieldRGBColour ($DateFieldPtr;0;200;00;255;255;255)
		
End case 
