//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:27:39

// ----------------------------------------------------

// Method: BKP_XML_SetGeneral

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_POINTER:C301($1; $aInfoLabels; $2; $aInfoValues)
C_TEXT:C284($tXPath)
C_LONGINT:C283($i)
ARRAY TEXT:C222(aGeneralNames; 0)
ARRAY TEXT:C222(aGeneralValues; 0)


$aInfoLabels:=$1
$aInfoValues:=$2
$tXPath:="Settings/General"

// get the necessary info values; disregard "ItemsCount" elements

If (BKP_XML_SetGroupArrays($aInfoLabels; $aInfoValues; ->aGeneralNames; ->aGeneralValues; $tXPath)#-1)
	
	// handle the include files first

	For ($i; 1; Size of array:C274(aGeneralNames))
		
		If ($i<=Size of array:C274(aGeneralNames))
			If (Position:C15("IncludesFiles"; aGeneralNames{$i})#0)
				
				// update our storage

				APPEND TO ARRAY:C911(IncludesFiles; aGeneralValues{$i})
				
				// clear out its old container so we don't set it again in the next step

				DELETE FROM ARRAY:C228(aGeneralNames; $i)
				DELETE FROM ARRAY:C228(aGeneralValues; $i)
				
				// reset the stack cursor

				$i:=$i-1
				
			End if 
		End if 
		
	End for 
	
	// now we prepare to dynamically create these variables

	For ($i; 1; Size of array:C274(aGeneralNames))
		
		C_POINTER:C301($pVar)
		
		// get the pointer to a variable and its type

		$pVar:=Get pointer:C304(aGeneralNames{$i})
		
		// set the variable

		BKP_XML_SetVariable($pVar; aGeneralValues{$i})
		
	End for 
	
End if 