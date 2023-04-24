//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/20/20, 09:58:02
// ----------------------------------------------------
// Method: webSelectWebUserRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1; $bReadOnly; $bReadOnlyStatus)

C_TEXT:C284($tWebuser)
C_OBJECT:C1216($entity)

If (Count parameters:C259>=1)
	$bReadOnly:=$1
Else 
	$bReadOnly:=True:C214
End if 

$bReadOnlyStatus:=Read only state:C362([WebUsers:14])

If ($bReadOnlyStatus) & ($bReadOnly=False:C215)  //set to read write
	READ WRITE:C146([WebUsers:14])
End if 

$tWebuser:=WAPI_getSession("username")

If ($tWebuser="")
	REDUCE SELECTION:C351([WebUsers:14]; 0)
Else 
	
	$entity:=ds:C1482.WebUsers.query("webUsername IS :1"; $tWebuser)
	
	If ($entity.length=1)
		USE ENTITY SELECTION:C1513($entity)
		LOAD RECORD:C52([WebUsers:14])
	Else 
		REDUCE SELECTION:C351([WebUsers:14]; 0)
	End if 
End if 