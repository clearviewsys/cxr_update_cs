//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 08/22/18, 11:19:26
// ----------------------------------------------------
// Method: SYNC_createSeedDatabase
// Description
//    this will delete all records from selected tables
//    and leaving records in tables that will be come the seed
//    for other sites

//    i.e. take customers from one site and share with all other "new" sites

//    MAKE SURE YOU HAVE CORRECT SYNCIDS SET PRIOR TO RUNNING THIS
//   USE REPAIR IDS IN THE SYNC MONITOR TO CLEAN UP 
//
// Parameters
// ----------------------------------------------------


ARRAY POINTER:C280($apTruncateTables; 0)
APPEND TO ARRAY:C911($apTruncateTables; ->[Invoices:5])
APPEND TO ARRAY:C911($apTruncateTables; ->[Registers:10])
APPEND TO ARRAY:C911($apTruncateTables; ->[CashTransactions:36])
APPEND TO ARRAY:C911($apTruncateTables; ->[Wires:8])
APPEND TO ARRAY:C911($apTruncateTables; ->[eWires:13])
//add other tables you want to remove records for



C_TEXT:C284($tConfirm)
C_LONGINT:C283($i; $iElem)
$tConfirm:="This will delete ALL data in the following tables: "+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)

For ($i; 1; Size of array:C274($apTruncateTables))
	$tConfirm:=$tConfirm+Table name:C256($apTruncateTables{$i})+", "
End for 

$tConfirm:=$tConfirm+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Do you have a backup and are you sure you want to continue?"

myConfirm($tConfirm)

If (OK=1)
	
	For ($i; 1; Get last table number:C254)
		If (Is table number valid:C999($i))
			
			$iElem:=Find in array:C230($apTruncateTables; Table:C252($i))
			If ($iElem>0)
				TRUNCATE TABLE:C1051(Table:C252($i)->)
				BEEP:C151
			End if 
			
		End if 
	End for 
	
End if 