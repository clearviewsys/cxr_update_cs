//%attributes = {}
// handleTypeAheardSelectVariable(->$selfPtr;$tableName;$fieldName;$picker)
// form events: onAfterKeystroke
// #ORDA
C_COLLECTION:C1488($matches; $0)
C_POINTER:C301($selfPtr; $1)
C_POINTER:C301($fieldPtr; $2)
C_BOOLEAN:C305($isStrict; $3)
C_BOOLEAN:C305($useAll; $4)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$fieldPtr:=$2
		$isStrict:=True:C214
		$useAll:=True:C214
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$fieldPtr:=$2
		$isStrict:=$3
		$useAll:=True:C214
	: (Count parameters:C259=4)
		$selfPtr:=$1
		$fieldPtr:=$2
		$isStrict:=$3
		$useAll:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_BOOLEAN:C305($continue)
$0:=New collection:C1472
$continue:=Form event code:C388=On After Keystroke:K2:26

C_TEXT:C284($original; $edited; $out)
C_LONGINT:C283($keystroke)

If ($continue)
	
	C_TEXT:C284($tableName; $fieldName)
	$tableName:=Table name:C256($fieldPtr)
	$fieldName:=Field name:C257($fieldPtr)
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
	C_LONGINT:C283($matchIdx; $highlightStart)
	C_COLLECTION:C1488($matches)
	$matches:=New collection:C1472
	$highlightStart:=Length:C16($edited)+1
	$original:=$selfPtr->
	
	//backspace, remove a character
	If ($keystroke=8)
		$highlightStart:=$highlightStart-1
		$edited:=Substring:C12($edited; 0; Length:C16($edited)-1)
		If ($edited="")
			$continue:=False:C215
			$selfPtr->:=$original
			HIGHLIGHT TEXT:C210($selfPtr->; 0; Length:C16($original)+1)
		End if 
	End if 
	
	C_OBJECT:C1216($entities)
	If ($useAll)
		$entities:=ds:C1482[$tableName].all()
	Else 
		C_POINTER:C301($table)
		$table:=Table:C252(Table:C252($fieldPtr))
		$entities:=Create entity selection:C1512($table->)
	End if 
End if 

If ($continue)
	C_TEXT:C284($use)
	C_LONGINT:C283($useLen)
	$useLen:=Length:C16($edited)
	
	C_BOOLEAN:C305($searching)
	$searching:=True:C214
	While ($searching)
		$use:=Substring:C12($edited; 0; $useLen)
		$matches:=$entities.query($fieldName+"=:1"; $use+"@")[$fieldName]
		$matchIdx:=$matches.indexOf($original)
		
		If ($matches.length>0)
			$searching:=False:C215
		Else 
			If ($isStrict)
				$highlightStart:=$highlightStart-1
				$useLen:=$useLen-1
				If ($useLen<=0)
					$searching:=False:C215
				End if 
			Else 
				$searching:=False:C215
			End if 
		End if 
	End while 
	$0:=$matches
End if 

// Get the right text
If ($continue)
	If ($matches.length>0)
		OBJECT SET RGB COLORS:C628($selfPtr->; Foreground color:K23:1; Background color:K23:2)
		$out:=""
		Case of 
			: ($keystroke=127)
				If ($matchIdx<($matches.length-1))
					$out:=$matches[$matchIdx+1]
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
	HIGHLIGHT TEXT:C210($selfPtr->; $highlightStart; Length:C16($out)+1)
End if 