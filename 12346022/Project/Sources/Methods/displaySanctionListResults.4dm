//%attributes = {}
// displaySanctionListResults($recordId;$$tableId)
// displaySanctionListResults($name;$nameType;$sanctionList)
//
// Parameters:
// $name/$recordId    (C_TEXT)
// $nameType/$tableId (C_LONGINT)
// $sanctionList      (C_OBJECT) 
// Returns: (C_TEXT)
//     The reason to hold the Customer
// Author: Wai-Kin

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_OBJECT:C1216($3; $form)

Case of 
	: (Count parameters:C259=2)
		$form:=formatSanctionListResults($1; $2)
	: (Count parameters:C259=3)
		$form:=formatSanctionListResults($1; $2; $3)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("SanctionList1")
DIALOG:C40("SanctionList1"; $form)
CLOSE WINDOW:C154($winRef)