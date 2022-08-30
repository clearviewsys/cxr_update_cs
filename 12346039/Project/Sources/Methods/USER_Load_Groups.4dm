//%attributes = {}
// 12/22/2005 -- I. Barclay Berry

C_LONGINT:C283($1; $iOption)  // Oct 3, 2011 15:48:12 -- I.Barclay Berry -- added options for loading other users and groups

C_BLOB:C604($xBlob)
C_TIME:C306($hRef)

If (Count parameters:C259>=1)
	$iOption:=$1
Else 
	$iOption:=0
End if 
//don't need to change user if run from server

//If (Current user#"administrator")
//$iError:=USER_Change_User ("administrator";"iC0mp")
//End if 

Case of 
	: ($iOption=0)  //default
		//UUrgGetParameter("CompanyInfo";"UsersAndGroups";"";"";!00/00/0000!;->$xBlob)
		ALL RECORDS:C47([CompanyInfo:7])
		$xBlob:=[CompanyInfo:7]xUsersGroups:19
		
	: ($iOption=1)  //disk file
		$hRef:=Open document:C264("")
		CLOSE DOCUMENT:C267($hRef)
		DOCUMENT TO BLOB:C525(document; $xBlob)
		
	Else 
		
End case 

If (BLOB size:C605($xBlob)>0)
	BLOB TO USERS:C850($xBlob)
	
	If (OK=0)
		ALERT:C41("Blob to users failed.")
	End if 
End if 