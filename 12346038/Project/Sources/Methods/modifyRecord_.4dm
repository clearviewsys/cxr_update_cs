//%attributes = {"publishedWeb":true}
// modifyRecord_(-> table;modifyForm)

// 11/30/17 - NOT CALLED BY ANYTHING


C_LONGINT:C283($recordNumber; $winRef)
C_POINTER:C301($1; $tablePtr)

$recordNumber:=<>RecordNo
//◊Contacts_RecordNo:=No current record   ` Clear this variable.


//Shell_UpdateMenuBar


C_TEXT:C284($2; $modifyForm)
C_LONGINT:C283($param)

$Param:=Count parameters:C259

// set the default form

$modifyForm:="Entry"

Case of 
		
	: ($Param=2)
		$modifyForm:=$2
		
End case 

FORM SET INPUT:C55($1->; $modifyForm)
$tablePtr:=$1

$winRef:=Open form window:C675($tablePtr->; $modifyForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)

If ($recordNumber=New record:K29:1)
	ADD RECORD:C56($tablePtr->; *)
Else 
	GOTO RECORD:C242($tablePtr->; $recordNumber)
	//DIALOG($tablePtr->;"View")
	
	
	MODIFY RECORD:C57($tablePtr->; *)
End if 
//allRecords ($tablePtr)

CLOSE WINDOW:C154