//%attributes = {}

// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:36:09
// ----------------------------------------------------
// Method: UT_ReplaceStringDeclarations
// Description
//ReplaceStringDeclarations - modified by Bob Miller from code originally written by Nigel Greenlee
//Original code was called CORE_TEXTPARSE
//
//Run this on a BACKUP COPY of your code - all risk is yours in running this code.
//
//This method scans all project methods, database methods, triggers, form methods,
//and object scripts (on project and table forms) in the structure file and replaces all instances of
//C_STRING with C_TEXT and ARRAY STRING to ARRAY TEXT
//
//It takes care of the number value after C_TEXT($foo) and in // Replaced #v15 4/9/19 was STRING(example: C_STRING(20)
//ARRAY TEXT($aFooArray;0) - includes it in a comment after the changed line of code. // Replaced #v15 4/9/19 was ARRAY STR(30)
//
//The comment placed after each changed line of code can be customized by changing $ChangeIdentifierText in Util_StringCompilerToText;
//this comment allows you to find all changed instances later on.
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($ErrorText; $CR)
C_LONGINT:C283($NumPaths; $index; $index2; $index3)

$CR:=Char:C90(13)

CONFIRM:C162("HAVE YOU CLOSED ALL METHODS AND FORMS AND MADE A COPY OF THIS STRUCTURE?"; "YES"; "NO")

If (OK=1)
	
	$ErrorText:=""
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $atMethodPaths)
	$NumPaths:=Size of array:C274($atMethodPaths)
	For ($index; 1; $NumPaths)
		MESSAGE:C88("Path project method "+String:C10($index; "###,##0")+" of "+String:C10($NumPaths; "###,##0"))
		UTIL_StringCompilerToText($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path database method:K72:2; $atMethodPaths)
	$NumPaths:=Size of array:C274($atMethodPaths)
	For ($index; 1; $NumPaths)
		MESSAGE:C88("Path database method "+String:C10($index; "###,##0")+" of "+String:C10($NumPaths; "###,##0"))
		UTIL_StringCompilerToText($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	
	ARRAY TEXT:C222($atMethodPaths; 0)
	METHOD GET PATHS:C1163(Path trigger:K72:4; $atMethodPaths)
	$NumPaths:=Size of array:C274($atMethodPaths)
	For ($index; 1; $NumPaths)
		MESSAGE:C88("Path trigger "+String:C10($index; "###,##0")+" of "+String:C10($NumPaths; "###,##0"))
		UTIL_StringCompilerToText($atMethodPaths{$index}; ->$ErrorText)
	End for 
	
	C_LONGINT:C283($NumPaths2; $NumPaths3; $lLastTableNumber)
	ARRAY TEXT:C222($_at_FormNames; 0)
	FORM GET NAMES:C1167($_at_FormNames)  //Project Forms
	$NumPaths2:=Size of array:C274($_at_FormNames)
	For ($index2; 1; $NumPaths2)
		ARRAY TEXT:C222($_at_ScriptPaths; 0)
		METHOD GET PATHS FORM:C1168($_at_ScriptPaths; $_at_FormNames{$Index2})
		$NumPaths3:=Size of array:C274($_at_ScriptPaths)
		For ($index3; 1; $NumPaths3)
			MESSAGE:C88("Form "+String:C10($index2; "###,##0")+" of "+String:C10($NumPaths2; "###,##0")+$CR+"Project Form path "+String:C10($index3; "###,##0")+" of "+String:C10($NumPaths3; "###,##0"))
			UTIL_StringCompilerToText($_at_ScriptPaths{$index3}; ->$ErrorText)
		End for 
	End for 
	
	C_POINTER:C301($Ptr_TablePointer)
	$lLastTableNumber:=Get last table number:C254
	For ($index; 1; $lLastTableNumber)
		If (Is table number valid:C999($index))
			$Ptr_TablePointer:=Table:C252($Index)
			ARRAY TEXT:C222($_at_FormNames; 0)
			FORM GET NAMES:C1167($Ptr_TablePointer->; $_at_FormNames)
			
			$NumPaths2:=Size of array:C274($_at_FormNames)
			For ($index2; 1; $NumPaths2)
				ARRAY TEXT:C222($_at_ScriptPaths; 0)
				METHOD GET PATHS FORM:C1168($Ptr_TablePointer->; $_at_ScriptPaths; $_at_FormNames{$Index2})
				$NumPaths3:=Size of array:C274($_at_ScriptPaths)
				For ($index3; 1; $NumPaths3)
					MESSAGE:C88("Form "+String:C10($index2; "###,##0")+" of "+String:C10($NumPaths2; "###,##0")+$CR+"Table Form path "+String:C10($index3; "###,##0")+" of "+String:C10($NumPaths3; "###,##0"))
					UTIL_StringCompilerToText($_at_ScriptPaths{$index3}; ->$ErrorText)
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
	
End if   //OK on confirm
