//%attributes = {}

// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:23:46
// ----------------------------------------------------
// Method: UT_ParseButtonCommand
// Description
//  Util_ParseButtonCommand - modified by Bob Miller from code originally written by Nigel Greenlee
//Originally named COREBUTTONENABLED
//
//This does the actual change from ENABLE BUTTON to OBJECT SET ENABLED.  It also adds a comment after each changed line.
//
//If something odd is found, then no conversion is done and error message is appended to text var passed as pointer $2
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($1; $MethodName; $_t_MethodText; $_t_oldMethodText; $_t_ReplacementText; $BeforeCloseBracket; $ChangeIdentifierText; $Comment; $StringToReplace)
C_TEXT:C284($CR)
C_LONGINT:C283($CRPostion; $SemiPosition; $StringPosition; $LengthOfStringToReplace)
C_BOOLEAN:C305($isCompilerMethod; $ReportErrors)
C_POINTER:C301($ErrorTextPtr)

$ChangeIdentifierText:="Replaced #v15 "+String:C10(Current date:C33)  //Every instance that is changed will be marked with this comment in-line with the change, so the changes can be found later.
//Modify this as you like to create a marker you can later retrieve.

$MethodName:=$1
$CR:=Char:C90(13)

$ReportErrors:=False:C215
If (Count parameters:C259>=2)
	C_POINTER:C301($2)
	$ErrorTextPtr:=$2
	$ReportErrors:=True:C214
End if 



If (($MethodName#"ReplaceEnableButton") & ($MethodName#"UT_StringCompilerToText") & ($MethodName#Current method name:C684))  //<--whatever this method is called make sure we dont use the code to change it!!
	$isCompilerMethod:=False:C215
	
	If ($MethodName="Compiler_Methods")
		$isCompilerMethod:=True:C214
		//TRACE
	End if 
	
	$_t_MethodText:=""
	METHOD GET CODE:C1190($MethodName; $_t_MethodText)
	$_t_MethodText:=UTIL_DB_CodeExtractComment($_t_MethodText)
	$_t_ReplacementText:=""
	$_t_oldMethodText:=$_t_MethodText
	
	C_LONGINT:C283($StartFindNextPosition)
	If ($_t_MethodText#"")
		
		$StartFindNextPosition:=1
		
		Repeat 
			$Comment:=""
			$StringToReplace:="_o_ENABLE BUTTON"
			$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //v15 adds the _o_ prefix to identify an obsolete command
			If ($StringPosition<=0)
				$StringToReplace:="ENABLE BUTTON"
				$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //if we are executing pre-v15, the command is as-is
			End if 
			$StartFindNextPosition:=2  //after the first time through the loop, we want to start searching at position 2, so we don't find the same thing over and over
			
			If ($StringPosition>0)
				$LengthOfStringToReplace:=Length:C16($StringToReplace)
				
				$_t_ReplacementText:=$_t_ReplacementText+Substring:C12($_t_MethodText; 1; $StringPosition-1)  //Get the text before Enable Button
				$_t_MethodText:=Substring:C12($_t_MethodText; $StringPosition)
				
				$CRPostion:=Position:C15(Char:C90(13); $_t_MethodText)
				$SemiPosition:=Position:C15(")"; $_t_MethodText)  //Find the postion of the * as in Enable button(*;Mybutton)
				
				If (($semiPosition>0) & ($semiPosition<$CRPostion))
					
					$BeforeCloseBracket:=Substring:C12($_t_MethodText; 1; $semiPosition-1)
					$Comment:=" // "+$ChangeIdentifierText+" was ENABLE BUTTN"  //`note: we can't use the command itself  or the comment itself will be converted
					$BeforeCloseBracket:=Replace string:C233($BeforeCloseBracket; $StringToReplace; "OBJECT SET ENABLED")+";TRUE)"+$Comment
					
					$_t_MethodText:=$BeforeCloseBracket+Substring:C12($_t_MethodText; $SemiPosition+1)
					
				Else 
					
					If ($ReportErrors)
						$ErrorTextPtr->:=$ErrorTextPtr->+$MethodName+" contains unconverted ENABLE BUTTON"+$CR
					End if   //$ReportErrors
					//$_t_methodText:="OBJECT SET ENABLED"+Substring($_t_MethodText;$LengthOfStringToReplace+1)  //it must be a comment
				End if   //(($semiPosition>0) & ($semiPosition<$CRPostion))
				
			Else 
				$_t_ReplacementText:=$_t_ReplacementText+$_t_MethodText
				$_t_MethodText:=""
			End if   //$StringPosition>0
			
		Until ($_t_MethodText="") | ($StringPosition=0)
		
		
		If ($_t_ReplacementText#$_t_oldMethodText)
			METHOD SET CODE:C1194($MethodName; $_t_ReplacementText)
		End if 
		// //
		$_t_MethodText:=""
		METHOD GET CODE:C1190($MethodName; $_t_MethodText)
		$_t_MethodText:=UTIL_DB_CodeExtractComment($_t_MethodText)
		$_t_ReplacementText:=""
		$_t_oldMethodText:=$_t_MethodText
		
		
		If ($_t_MethodText#"")
			$StartFindNextPosition:=1  //reset for a new loop
			Repeat 
				$Comment:=""
				$StringToReplace:="_o_DISABLE BUTTON"
				$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //v15 adds the _o_ prefix to identify an obsolete command
				If ($StringPosition<=0)
					$StringToReplace:="DISABLE BUTTON"
					$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //if we are executing pre-v15, the command is as-is
				End if 
				$StartFindNextPosition:=2  //after the first time through the loop, we want to start searching at position 2, so we don't find the same thing over and over
				
				If ($StringPosition>0)
					$LengthOfStringToReplace:=Length:C16($StringToReplace)
					
					$_t_ReplacementText:=$_t_ReplacementText+Substring:C12($_t_MethodText; 1; $StringPosition-1)  //Get the text before DISABLE BUTTON
					$_t_MethodText:=Substring:C12($_t_MethodText; $StringPosition)
					
					$CRPostion:=Position:C15(Char:C90(13); $_t_MethodText)
					$SemiPosition:=Position:C15(")"; $_t_MethodText)  //Find the postion of the * as in Enable button(*;Mybutton)
					
					If ($semiPosition>0) & ($semiPosition<$CRPostion)
						
						$BeforeCloseBracket:=Substring:C12($_t_MethodText; 1; $semiPosition-1)
						$Comment:=" // "+$ChangeIdentifierText+" was DISABLE BUTTN"  //`note: we can't use the command itself  or the comment itself will be converted
						$BeforeCloseBracket:=Replace string:C233($BeforeCloseBracket; $StringToReplace; "OBJECT SET ENABLED")+";FALSE)"+$Comment
						
						$_t_MethodText:=$BeforeCloseBracket+Substring:C12($_t_MethodText; $SemiPosition+1)
					Else 
						
						If ($ReportErrors)
							$ErrorTextPtr->:=$ErrorTextPtr->+$MethodName+" contains unconverted DISABLE BUTTON"+$CR
						End if   //$ReportErrors
						//$_t_methodText:="OBJECT SET ENABLED"+Substring($_t_MethodText;9)  //it must be a comment
					End if 
					
				Else 
					$_t_ReplacementText:=$_t_ReplacementText+$_t_MethodText+$Comment
					$_t_MethodText:=""
				End if 
				
			Until ($_t_MethodText="") | ($StringPosition=0)
			
			
			If ($_t_ReplacementText#$_t_oldMethodText)
				METHOD SET CODE:C1194($MethodName; $_t_ReplacementText)
			End if 
			
		End if 
		
	End if 
	
End if 

//********* Modified JJF $u190418 *********