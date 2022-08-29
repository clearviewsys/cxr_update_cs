//%attributes = {}
// Project Method: StringToDate (string) --> Date

// Function: Returns the date equivalent of the string passed

// This works for MM/DD/YY & DD/MM/YY forms.
// Two digit years are resolved as per the SET DEFAULT CENTURY command.

// Dates can be entered with any character as a delimiter.
// If no year is entered, the current year is assumed.
// If only a one or two digit number is entered, the current month is assumed.

// If no delimiter is used, the following formats are supported:
//   070476 Returns a date of 07/04/76
//   07041976 Returns a date of 07/04/1976
//   0704 Returns 07/04/00 (If this is in fact the year 2000)
//   07 or 7 Returns the 7th day of the current month
//   74, 704 and 074 are not supported

// Method created by Tom Dillon, DataCraft
// Method modified April 2002 by Raymond Manley for 4D, Inc.

C_DATE:C307($0)
C_TEXT:C284($1)

C_DATE:C307($Date; $Date2; $Today)
C_TEXT:C284($DateStr; $DateStr2; $ThisYearStr; $ThisMonthStr; $DateSubStr1; $DateSubStr2; $DateSubStr3)
C_BOOLEAN:C305($USDates; $Done)
C_LONGINT:C283($DateStrLen; $Slash1; $Slash2; $i)

$0:=Date:C102("00/0/00")
$DateStr:=$1

$Today:=Current date:C33
$ThisYearStr:=String:C10(Year of:C25($Today); "0000")
$ThisMonthStr:=String:C10(Month of:C24($Today))
$Slash1:=0
$Slash2:=0

$USDates:=Day of:C23(Date:C102("1/2/2000"))=2  // US-M/D/Y, Not US-D/M/Y, Others not supported

For ($i; 1; Length:C16($DateStr))
	If (($DateStr[[$i]]<"0") | ($DateStr[[$i]]>"9"))  // if it's not 0-9, it must be a delimiter
		$DateStr[[$i]]:="/"
	End if 
End for 

Repeat 
	$DateStr2:=$DateStr
	$DateStr:=Replace string:C233($DateStr2; "//"; "/")  // Since we replaced everthing but numbers with "/", better check for dups
	$Done:=$DateStr=$DateStr2  // If no changes, then we're done
Until ($Done)

$DateStrLen:=Length:C16($DateStr)
If ($DateStrLen>0)
	If ($DateStr[[1]]="/")  // If the first character is a slash, drop it
		$DateStr:=Substring:C12($DateStr; 2)
	End if 
End if   // ($DateStrLen>0)

$DateStrLen:=Length:C16($DateStr)
If ($DateStrLen>0)
	If (Substring:C12($DateStr; $DateStrLen; 1)="/")  // If the last character is a slash, drop it
		$DateStr:=Substring:C12($DateStr; 1; $DateStrLen-1)
	End if 
Else 
	$DateStr:="00/00/00"
End if   // ($DateStrLen>0)

$DateStrLen:=Length:C16($DateStr)
$Slash1:=Position:C15("/"; $DateStr)
If (($Slash1>0) & ($Slash1<$DateStrLen))
	$Slash2:=Position:C15("/"; Substring:C12($DateStr; $Slash1+1))
	If ($Slash2>0)
		$Slash2:=$Slash2+$Slash1
	End if 
Else 
	$Slash2:=0
End if   // ($Slash1>0)

$DateSubStr1:="00"
$DateSubStr2:="00"
$DateSubStr3:="00"

Case of 
	: ($DateStr="")  // Skip the rest if the string is blank
		
	: ($Slash2>0)  // There are two slashes
		$DateSubStr1:=Substring:C12($DateStr; 1; $Slash1-1)
		$DateSubStr2:=Substring:C12($DateStr; $Slash1+1; $Slash2-$Slash1-1)
		$DateSubStr3:=Substring:C12($DateStr; $Slash2+1)
		
	: ($Slash1>0)  // Only one slash 
		$DateSubStr1:=Substring:C12($DateStr; 1; $Slash1-1)
		$DateSubStr2:=Substring:C12($DateStr; $Slash1+1)
		$DateSubStr3:=$ThisYearStr  // Assume current year
		
		// No slashes (there are still some possibilities)
	: ($DateStrLen<=2)  // Just the day was entered (1-2 characters)
		If ($USDates)
			$DateSubStr1:=$ThisMonthStr
			$DateSubStr2:=$DateStr
		Else 
			$DateSubStr1:=$DateStr
			$DateSubStr2:=$ThisMonthStr
		End if 
		$DateSubStr3:=$ThisYearStr  // Assume current year
		
	: ($DateStrLen=4)  // Month and day were entered (4 characters, 3 is too tough)
		$DateSubStr1:=Substring:C12($DateStr; 1; 2)
		$DateSubStr2:=Substring:C12($DateStr; 3; 2)
		$DateSubStr3:=$ThisYearStr  // Assume current year
		
	: ($DateStrLen>=6)  // Month and day were entered (6 or more characters)
		$DateSubStr1:=Substring:C12($DateStr; 1; 2)
		$DateSubStr2:=Substring:C12($DateStr; 3; 2)
		$DateSubStr3:=Substring:C12($DateStr; 5)
End case 

$Date:=Date:C102($DateSubStr1+"/"+$DateSubStr2+"/"+$DateSubStr3)

$Date2:=Date:C102(String:C10($Date))  // Convert the date to a string and then back to a date again

If ($Date2#$Date)  // If the dates do not match the date must be out of range
	BEEP:C151
Else 
	$0:=$Date
End if 















