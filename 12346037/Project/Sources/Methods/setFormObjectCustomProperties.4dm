//%attributes = {}
// setFormObjectCustomProperties (formName)
// this method assigns properties based on the [FormObjects] records

READ ONLY:C145([FormObjects:120])
SET QUERY DESTINATION:C396(Into current selection:K19:1)

C_LONGINT:C283($tableNo; $i)
C_TEXT:C284($formName; $objectName; $1)

Case of 
	: (Count parameters:C259=0)
		$formName:="Entry"
	: (Count parameters:C259=1)
		$formName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tableNo:=Table:C252(Current form table:C627)  // table number of the current form
If ($tableNo#Table:C252(->[FormObjects:120]))
	QUERY:C277([FormObjects:120]; [FormObjects:120]TableNo:2=$tableNo; *)
	QUERY:C277([FormObjects:120];  & ; [FormObjects:120]FormName:3=$formName)
	// POST: returns a selection of form objects that have custom properties
	
	FIRST RECORD:C50([FormObjects:120])
	For ($i; 1; Records in selection:C76([FormObjects:120]))
		LOAD RECORD:C52([FormObjects:120])
		$objectName:=[FormObjects:120]Objectname:4
		
		If ([FormObjects:120]Visibility:7#0)  // i.e. 1 or 2
			OBJECT SET VISIBLE:C603(*; $objectName; ([FormObjects:120]Visibility:7=1))  // when 1: true; when 2: false
		End if 
		
		If ([FormObjects:120]Enterability:6#0)  // i.e. 1 or 2
			OBJECT SET ENTERABLE:C238(*; $objectName; ([FormObjects:120]Enterability:6=1))  // when 1: true; when 2: false
		End if 
		
		If ([FormObjects:120]Title:5#"")
			OBJECT SET TITLE:C194(*; $objectName; [FormObjects:120]Title:5)
		End if 
		
		If ([FormObjects:120]doApplyColour:16)
			OBJECT SET RGB COLORS:C628(*; $objectName; [FormObjects:120]colour_FG:9; [FormObjects:120]colour_BG:8)
		End if 
		
		If ([FormObjects:120]entryFilter:17#"")
			OBJECT SET FILTER:C235(*; $objectName; [FormObjects:120]entryFilter:17)
		End if 
		
		If ([FormObjects:120]displayFormat:18#"")
			OBJECT SET FORMAT:C236(*; $objectName; [FormObjects:120]displayFormat:18)
		End if 
		
		If ([FormObjects:120]shortcut_Key:10#"")
			C_LONGINT:C283($mask)
			If ([FormObjects:120]shortcut_isShiftPressed:11)
				$mask:=$mask+Shift key mask:K16:3
			End if 
			
			If ([FormObjects:120]shortcut_isCtrlPressed:12)
				$mask:=$mask+Control key mask:K16:9
			End if 
			
			If ([FormObjects:120]shortcut_isAltPressed:13)
				$mask:=$mask+Option key mask:K16:7
			End if 
			
			OBJECT SET SHORTCUT:C1185(*; $objectName; [FormObjects:120]shortcut_Key:10; $mask)
		End if 
		// more to come...
		NEXT RECORD:C51([FormObjects:120])  // iterate to next form object
	End for 
	
	UNLOAD RECORD:C212([FormObjects:120])
End if 
