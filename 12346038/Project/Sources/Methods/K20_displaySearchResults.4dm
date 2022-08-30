//%attributes = {}
// K20_displaySearchResults($entity)
// Author: Wai-Kin Chau

C_OBJECT:C1216($log; $1)
Case of 
	: (Count parameters:C259=0)
		// #ORDA
		$log:=Create entity selection:C1512([KYC2020Log:159]).first()
	: (Count parameters:C259=1)
		$log:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($form)
If ($log#Null:C1517)
	$form:=New object:C1471
	C_TEXT:C284($property)
	For each ($property; $log)
		$form[$property]:=$log[$property]
	End for each 
	
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675("K20_SearchResult"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("K20_SearchResult"; $form)
	CLOSE WINDOW:C154($winRef)
End if 