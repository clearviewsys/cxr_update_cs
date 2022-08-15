//%attributes = {}


// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 11/29/19, 09:07:51
// ----------------------------------------------------
// Method: createStarterDbase
// Description
//    run this to purge all transactions and create an empty dbase
//    will leave basice setup data in place

// Parameters
// ----------------------------------------------------
C_TEXT:C284($tConfirm)
C_LONGINT:C283($i; $iElem)

If (isUserAdministrator)
	//these table will NOT be deleted/purged
	ARRAY POINTER:C280($apTruncateTables; 0)
	APPEND TO ARRAY:C911($apTruncateTables; ->[Currencies:6])
	APPEND TO ARRAY:C911($apTruncateTables; ->[CurrencyGroups:20])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Flags:19])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Denominations:31])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Countries:62])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Sync_Tables:82])
	APPEND TO ARRAY:C911($apTruncateTables; ->[MainAccounts:28])
	APPEND TO ARRAY:C911($apTruncateTables; ->[List_PIN:130])
	APPEND TO ARRAY:C911($apTruncateTables; ->[List_POT:128])
	APPEND TO ARRAY:C911($apTruncateTables; ->[List_SOF:129])
	APPEND TO ARRAY:C911($apTruncateTables; ->[List_Relationships:136])
	APPEND TO ARRAY:C911($apTruncateTables; ->[List_RiskFactors:132])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Cities:60])
	APPEND TO ARRAY:C911($apTruncateTables; ->[States:61])
	APPEND TO ARRAY:C911($apTruncateTables; ->[CommonLists:84])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Occupations:2])
	APPEND TO ARRAY:C911($apTruncateTables; ->[Industries:114])
	
	//add other tables you want to LEAVE the records for
	
	
	
	
	$tConfirm:="This will delete ALL data EXCEPT the following tables: "+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	
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
					//LEAVE IT ALONE
				Else 
					TRUNCATE TABLE:C1051(Table:C252($i)->)
					BEEP:C151
				End if 
				
			End if 
		End for 
		
	End if 
	
End if 