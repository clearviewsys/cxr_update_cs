//%attributes = {}
// K20_displayRecordDetails($searchID)
// Author: Wai-Kin Chau
C_OBJECT:C1216($object; $1)
Case of 
	: (Count parameters:C259=0)
		$object:=New object:C1471
	: (Count parameters:C259=1)
		$object:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($form)
$form:=New object:C1471
$form:=$object

C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("K20_SearchResult"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("K20_DetailResult"; $form)
CLOSE WINDOW:C154($winRef)