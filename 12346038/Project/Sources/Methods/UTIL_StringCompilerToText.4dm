//%attributes = {}

// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:29:46
// ----------------------------------------------------
// Method: UT_StringCompilerToText
// Description
//Util_StringCompilerToText - modified by Bob Miller from code originally written by Nigel Greenlee
//Original method was name CORE_STRINGTOTEXT
//
//This does the actual change from C_STRING to C_TEXT.  It also adds a comment after each changed line
//
//If something odd is found, then no conversion is done and error message is appended to text var passed as pointer $2
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($1; $MethodName; $CR; $_t_MethodText; $_t_ReplacementText; $_t_oldMethodText; $Comment; $NameOfDeclaredMethod; $ChangeIdentifierText)
C_TEXT:C284($OldLengthStr; $StringToReplace)
C_LONGINT:C283($CRPosition; $StringPosition; $CRPosition; $SemiPosition; $BracketPosition; $WhereCR; $StartFindNextPosition; $LengthOfStringToReplace)
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


If (($MethodName#"UT_ReplaceStringDeclarations") & ($MethodName#Current method name:C684))  //<--if you rename these methods, change this line of code so they are excluded!!
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
	
	If ($_t_MethodText#"")
		
		$StartFindNextPosition:=1  //start scanning for our string at position 1
		
		Repeat 
			$Comment:=""
			$StringToReplace:="_o_C_STRING"
			$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //v15 adds the _o_ prefix to identify an obsolete command
			If ($StringPosition<=0)
				$StringToReplace:="C_STRING"
				$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //if we are executing pre-v15, the command is as-is
			End if 
			$StartFindNextPosition:=2  //after the first time through the loop, we want to start searching at position 2, so we don't find the same thing over and over
			
			If ($StringPosition>0)
				$LengthOfStringToReplace:=Length:C16($StringToReplace)
				
				$_t_ReplacementText:=$_t_ReplacementText+Substring:C12($_t_MethodText; 1; $StringPosition-1)  //Get the text before C_STRING
				$_t_MethodText:=Substring:C12($_t_MethodText; $StringPosition)
				
				If ($isCompilerMethod)  //semi colon will be much further on.
					$CRPosition:=Position:C15(Char:C90(13); $_t_MethodText)
					$SemiPosition:=Position:C15(";"; $_t_MethodText)  //Find the postion of the ; as in C_String(55;(we dont know if the number of chars is 11,12,or 13(C_STRING(1; orC_STRING(11, or C_STRING,111
					If ($semiPosition>0) & ($semiPosition<$CRPosition)
						
						$NameOfDeclaredMethod:=Substring:C12($_t_MethodText; 1; $SemiPosition-1)
						$BracketPosition:=Position:C15("("; $NameOfDeclaredMethod)
						$NameOfDeclaredMethod:=Substring:C12($NameOfDeclaredMethod; $BracketPosition+1)
						$_t_MethodText:=Substring:C12($_t_MethodText; $SemiPosition+1)
						$SemiPosition:=Position:C15(";"; $_t_MethodText)
						$_t_MethodText:="C_TEXT("+$NameOfDeclaredMethod+";"+Substring:C12($_t_MethodText; $SemiPosition+1)
					Else 
						//$_t_methodText:="C_TEXT"+Substring($_t_MethodText;$LengthOfStringToReplace+1)  //it must be a comment with the word c_string in or a badly formed c_string command-just replace the string
						If ($ReportErrors)
							$ErrorTextPtr->:=$ErrorTextPtr->+$MethodName+" contains unconverted C_STRING"+$CR
						End if   //$ReportErrors
					End if 
					
				Else   //not compiler method
					
					$CRPosition:=Position:C15(Char:C90(13); $_t_MethodText)
					$SemiPosition:=Position:C15(";"; $_t_MethodText)  //Find the postion of the ; as in C_String(55;(we dont know if the number of chars is 11,12,or 13(C_STRING(1; orC_STRING(11, or C_STRING,111
					
					If (($semiPosition>0) & ($semiPosition<$CRPosition))
						
						$OldLengthStr:=UTIL_GetStringBetween($_t_MethodText; "("; ";")  //get number between ( and ; in C_STRING(255; ---)
						$Comment:=" // "+$ChangeIdentifierText+" was STRING("+$OldLengthStr+")"  //`note: we can't use C_String or the comment itself will be converted
						
						$_t_MethodText:="C_TEXT("+Substring:C12($_t_MethodText; $SemiPosition+1)
						
						$WhereCR:=Position:C15($CR; $_t_MethodText)
						If ($WhereCR>0)
							$_t_MethodText:=Insert string:C231($_t_MethodText; $Comment; $WhereCR)
						End if 
						
					Else 
						//RLM do nothing
						//$_t_methodText:="C_TEXT"+Substring($_t_MethodText;9)  //it must be a comment with the word c_string in or a badly formed c_string command-just replace the string
						If ($ReportErrors)
							$ErrorTextPtr->:=$ErrorTextPtr->+$MethodName+" contains unconverted C_STRING"+$CR
						End if   //$ReportErrors
					End if   //( ($semiPosition>0) & ($semiPosition<17))
				End if 
				
			Else 
				$_t_ReplacementText:=$_t_ReplacementText+$_t_MethodText
				$_t_MethodText:=""
			End if 
			
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
				$StringToReplace:="_o_ARRAY STRING"
				$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //v15 adds the _o_ prefix to identify an obsolete command
				If ($StringPosition<=0)
					$StringToReplace:="ARRAY STRING"
					$StringPosition:=Position:C15($StringToReplace; $_t_MethodText; $StartFindNextPosition)  //if we are executing pre-v15, the command is as-is
				End if 
				$StartFindNextPosition:=2  //after the first time through the loop, we want to start searching at position 2, so we don't find the same thing over and over
				
				If ($StringPosition>0)
					$LengthOfStringToReplace:=Length:C16($StringToReplace)
					
					$_t_ReplacementText:=$_t_ReplacementText+Substring:C12($_t_MethodText; 1; $StringPosition-1)  //Get the text before ARRAY STRING
					$_t_MethodText:=Substring:C12($_t_MethodText; $StringPosition)
					$CRPosition:=Position:C15(Char:C90(13); $_t_MethodText)
					$SemiPosition:=Position:C15(";"; $_t_MethodText)  //Find the postion of the ; as in ARRAY STRING(55;(we dont know if the number of chars is 11,12,or 13(C_STRING(1; orC_STRING(11, or C_STRING,111
					
					If (($semiPosition>0) & ($semiPosition<$CRPosition))
						
						$OldLengthStr:=UTIL_GetStringBetween($_t_MethodText; "("; ";")  //get number between ( and ; in ARRAY STRING(255; ---)
						$Comment:=" // "+$ChangeIdentifierText+" was ARRAY STR("+$OldLengthStr+")"  //`note: we can't use Array_String or the comment itself will be converted
						
						$_t_MethodText:="ARRAY TEXT("+Substring:C12($_t_MethodText; $SemiPosition+1)
						
						$WhereCR:=Position:C15($CR; $_t_MethodText)
						If ($WhereCR>0)
							$_t_MethodText:=Insert string:C231($_t_MethodText; $Comment; $WhereCR)
						End if 
						
						
					Else 
						
						If ($ReportErrors)
							$ErrorTextPtr->:=$ErrorTextPtr->+$MethodName+" contains unconverted ARRAY STRING"+$CR
						End if   //$ReportErrors
						//$_t_methodText:="ARRAY TEXT("+Substring($_t_MethodText;$LengthOfStringToReplace+1)  //it must be a comment with the word ARRAY STRING in or a badly formed c_string command-just replace the string
					End if   // ($semiPosition>0) & ($semiPosition<21)
					
				Else   //no more instances found
					$_t_ReplacementText:=$_t_ReplacementText+$_t_MethodText
					$_t_MethodText:=""
				End if   //$StringPosition>0
				
			Until ($_t_MethodText="") | ($StringPosition=0)
			If ($_t_ReplacementText#$_t_oldMethodText)
				METHOD SET CODE:C1194($MethodName; $_t_ReplacementText)
			End if 
		End if 
		
	End if 
	
End if 
