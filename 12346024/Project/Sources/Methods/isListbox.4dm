//%attributes = {}

// isListBox (->object)
// this assumes that ListBox objects have "listbox" in their name e.g. mainListBox, viewListBox

C_POINTER:C301($1)
C_BOOLEAN:C305($0)

C_TEXT:C284($objectName)
$0:=False:C215

If (Not:C34(Is nil pointer:C315($1)))  // TB must check if pointer is not nil
	$objectName:=OBJECT Get name:C1087($1->)
	If (Position:C15("ListBox"; $objectName)>0)
		$0:=True:C214
	End if 
End if 



