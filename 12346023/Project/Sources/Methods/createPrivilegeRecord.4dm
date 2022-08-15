//%attributes = {}
// createPrivilegeRecord( userId; tableNum; read ; write ; delete ; print ; import ; export)
C_TEXT:C284($1; $userID)
C_LONGINT:C283($2; $tableNum; $i)
C_BOOLEAN:C305($3; $4; $5; $6; $7; $8; $9; $canRead; $canCreate; $canModify; $canDelete; $canPrint; $canImport; $canExport)
C_POINTER:C301($ptrField)

C_BOOLEAN:C305($bSave)

$bSave:=False:C215


$userID:=$1
$tableNum:=$2
$canRead:=$3
$canCreate:=$4
$canModify:=$5
$canDelete:=$6
$canPrint:=$7
$canImport:=$8
$canExport:=$9

READ WRITE:C146([Privileges:24])
QUERY:C277([Privileges:24]; [Privileges:24]UserID:1=$userID; *)
QUERY:C277([Privileges:24];  & ; [Privileges:24]TableNo:2=$tableNum)

If (Records in selection:C76([Privileges:24])>=1)
	LOAD RECORD:C52([Privileges:24])
Else   // no record has been found 
	CREATE RECORD:C68([Privileges:24])
End if 

[Privileges:24]UserID:1:=$userID
[Privileges:24]TableNo:2:=$tableNum
[Privileges:24]canView:3:=$canRead
[Privileges:24]canCreate:4:=$canCreate
[Privileges:24]canModify:9:=$canModify
[Privileges:24]canDelete:5:=$canDelete
[Privileges:24]canPrint:6:=$canPrint
[Privileges:24]canImport:7:=$canImport
[Privileges:24]canExport:8:=$canExport


For ($i; 1; Get last field number:C255(->[Privileges:24]))
	If (Is field number valid:C1000(->[Privileges:24]; $i))
		$ptrField:=Field:C253(Table:C252(->[Privileges:24]); $i)
		If (Type:C295($ptrField->)=Is picture:K8:10) | (Type:C295($ptrField->)=Is BLOB:K8:12)
			//don't eval these
		Else 
			If (Old:C35($ptrField->)#$ptrField->)
				$bSave:=True:C214
				$i:=9999  //bail out
			End if 
		End if 
	End if 
End for 


If ($bSave)
	SAVE RECORD:C53([Privileges:24])
End if 

UNLOAD RECORD:C212([Privileges:24])
