//%attributes = {}
// Author: Wai-Kin

C_OBJECT:C1216($1; $form)
Case of 
	: (Count parameters:C259=0)
		
		$form:=New object:C1471
		$form.object:=New object:C1471
		$form.object.number:=23
		$form.object.text:="Hello World"
		$form.object.empty:=""
		$form.object.null:=Null:C1517
		$form.object.object:=New object:C1471("abc"; ?00:20:00?)
		$form.object.collection:=New collection:C1472(New object:C1471("a"; "b"); \
			New collection:C1472(New object:C1471("more"; 13)); \
			Null:C1517; ""; 1; 2)
	Else 
		$form:=$1
End case 

C_REAL:C285($winRef)
C_COLLECTION:C1488($test)
$test:=handleJSONlistbox($form.object)
$winRef:=Open form window:C675("test_JSONviewer")
DIALOG:C40("test_JSONviewer"; $form)
CLOSE WINDOW:C154($winRef)