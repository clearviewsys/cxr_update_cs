//%attributes = {}

// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:28:04
// ----------------------------------------------------
// Method: UT_ReplaceEnableButton
// Description
// ReplaceEnableButton -  modified by Bob Miller from code originally written by Nigel Greenlee
//Original method was called PARSECODEBUTTONS
//
//Cycles through all code and changes deprecated commands
//Enable Button and Disable Button to Object Set Enabled; places comment after all changed lines
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($ErrorText; $CR)
C_LONGINT:C283($index; $index2; $index3; $lLastTableNumber)
C_POINTER:C301($Ptr_TablePointer)
$CR:=Char:C90(13)

CONFIRM:C162("HAVE YOU CLOSED ALL METHODS AND FORMS AND MADE A COPY OF THIS STRUCTURE?"; "YES"; "NO")

If (OK=1)
	
	$ErrorText:=""
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $atMethodPaths)
	For ($index; 1; Size of array:C274($atMethodPaths))
		UTIL_ParseButtonCommand($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path database method:K72:2; $atMethodPaths)
	For ($index; 1; Size of array:C274($atMethodPaths))
		UTIL_ParseButtonCommand($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path trigger:K72:4; $atMethodPaths)
	For ($index; 1; Size of array:C274($atMethodPaths))
		UTIL_ParseButtonCommand($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	ARRAY TEXT:C222($_at_FormNames; 0)
	FORM GET NAMES:C1167($_at_FormNames)  //Project Forms
	For ($index2; 1; Size of array:C274($_at_FormNames))
		ARRAY TEXT:C222($_at_ScriptPaths; 0)
		METHOD GET PATHS FORM:C1168($_at_ScriptPaths; $_at_FormNames{$Index2})
		For ($index3; 1; Size of array:C274($_at_ScriptPaths))
			UTIL_ParseButtonCommand($_at_ScriptPaths{$index3}; ->$ErrorText)
		End for 
	End for 
	
	$lLastTableNumber:=Get last table number:C254
	For ($index; 1; $lLastTableNumber)
		If (Is table number valid:C999($index))
			$Ptr_TablePointer:=Table:C252($Index)
			ARRAY TEXT:C222($_at_FormNames; 0)
			FORM GET NAMES:C1167($Ptr_TablePointer->; $_at_FormNames)
			
			
			For ($index2; 1; Size of array:C274($_at_FormNames))
				ARRAY TEXT:C222($_at_ScriptPaths; 0)
				METHOD GET PATHS FORM:C1168($Ptr_TablePointer->; $_at_ScriptPaths; $_at_FormNames{$Index2})
				For ($index3; 1; Size of array:C274($_at_ScriptPaths))
					UTIL_ParseButtonCommand($_at_ScriptPaths{$index3}; ->$ErrorText)
				End for 
			End for 
		End if 
	End for 
	
	
	If ($ErrorText#"")
		$ErrorText:="Unreplaceable items:"+$CR+$ErrorText
		SET TEXT TO PASTEBOARD:C523($ErrorText)
		ALERT:C41("Done; errors were found and are on the clipboard - paste them into a document and investigate them.")
	Else 
		ALERT:C41("DONE - no errors")
	End if 
	
	
Else 
	
	ALERT:C41("Make a copy and then try again.")
	
End if 
//