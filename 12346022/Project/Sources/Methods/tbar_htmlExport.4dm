//%attributes = {}
// tbar_htmlExport ({mainListBox})

C_TEXT:C284($listBoxName; $1)

Case of 
	: (Count parameters:C259=0)
		$listBoxName:="mainListBox"
	: (Count parameters:C259=1)
		$listBoxName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_POINTER:C301($listBoxPtr)
$listBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $listBoxName)

If (Not:C34(Is nil pointer:C315($listBoxPtr)))
	If (Shift down:C543)
		printListbox($listBoxPtr; qr printer:K14903:1)
	Else 
		printListbox($listBoxPtr; qr HTML file:K14903:5)
	End if 
Else 
	myAlert("<X> is not a valid listbox"; $listBoxName)
End if 