//%attributes = {}
// handleTypeAheardArrayVariable(->$selfPtr;->$collection;$isStrict)
// form events: onAfterKeystroke

C_COLLECTION:C1488($matches; $0)
C_POINTER:C301($selfPtr; $1)
C_COLLECTION:C1488($collection; $2)
C_BOOLEAN:C305($isStrict; $3)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$collection:=$2
		$isStrict:=True:C214
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$collection:=$2
		$isStrict:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$0:=New collection:C1472
ASSERT:C1129($collection.length>0; "Must contain more than one item to match")

C_BOOLEAN:C305($continue)
$continue:=Form event code:C388=On After Keystroke:K2:26

C_TEXT:C284($original; $edited)
C_LONGINT:C283($keystroke)
If ($continue)
	// check if we should continue or not
	$edited:=Get edited text:C655
	$original:=$selfPtr->
	$keystroke:=Character code:C91(Keystroke:C390)
	
	If (Length:C16($edited)=0)
		$continue:=False:C215
		$selfPtr->:=""
	End if 
End if 

If ($continue)
	$continue:=Not:C34(($keystroke>=Left arrow key:K12:16) & ($keystroke<=Right arrow key:K12:17)) & ($keystroke#Home key:K12:22) & ($keystroke#End key:K12:23)
End if 

If ($continue)
	// more setup
	C_LONGINT:C283($collectionLen; $matchesIdx; $hightlightStart)
	C_TEXT:C284($out)
	C_COLLECTION:C1488($matches)
	$matches:=New collection:C1472
	$collectionLen:=$collection.length-1
	$matchesIdx:=0
	$hightlightStart:=Length:C16($edited)+1
	
	//backspace, remove a character
	If ($keystroke=8)
		$hightlightStart:=$hightlightStart-1
		$edited:=Substring:C12($edited; 0; Length:C16($edited)-1)
		If ($edited="")
			$continue:=False:C215
			$selfPtr->:=$original
			HIGHLIGHT TEXT:C210($selfPtr->; 0; Length:C16($original)+1)
		End if 
	End if 
End if 

If ($continue)
	C_TEXT:C284($use; $compares)
	C_LONGINT:C283($useLen)
	$useLen:=Length:C16($edited)
	
	C_BOOLEAN:C305($searching)
	$searching:=True:C214
	While ($searching)
		// extact the test string
		$use:=Substring:C12($edited; 0; $useLen)
		$matches:=$collection.filter("collect_filterStringHelper"; $use+"@")
		$matchesIdx:=$matches.indexOf($original)
		
		// Check the size of matches:
		If ($matches.length>0)
			$searching:=False:C215
		Else   // no matches
			If ($isStrict)
				// Try again with shorter string
				$hightlightStart:=$hightlightStart-1
				$useLen:=$useLen-1
				If ($useLen<=0)
					$searching:=False:C215
				End if 
			Else 
				// reflex = leave it alone
				$searching:=False:C215
			End if 
		End if 
	End while 
End if 

// Get the right text
If ($continue)
	If ($matches.length>0)
		OBJECT SET RGB COLORS:C628($selfPtr->; Foreground color:K23:1; Background color:K23:2)
		$out:=""
		Case of 
			: ($keystroke=127)
				If ($matchesIdx<($matches.length-1))
					$out:=$matches[$matchesIdx+1]
				Else 
					$out:=$matches[0]
				End if 
			Else 
				$out:=$matches[0]
		End case 
		$0:=$matches
	Else 
		If ($isStrict)
			$out:=$selfPtr->
			//BEEP
		Else 
			OBJECT SET RGB COLORS:C628($selfPtr->; 0x00FF0000; Background color:K23:2)
			$continue:=False:C215
		End if 
		$0:=New collection:C1472
	End if 
End if 

// Add the hightlight
If ($continue)
	$selfPtr->:=$out
	HIGHLIGHT TEXT:C210($selfPtr->; $hightlightStart; Length:C16($out)+1)
End if 