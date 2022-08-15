//%attributes = {}
// 12/22/2005 -- I. Barclay Berry

C_LONGINT:C283($1; $iOption)  // Oct 3, 2011 15:48:12 -- I.Barclay Berry -- added options for loading other users and groups
C_TEXT:C284($2; $tFilePath)  // Dec 10, 2014 10:49:34 -- I.Barclay Berry ADDED

C_BLOB:C604($xBlob)
C_TIME:C306($hRef)

//don't need to change user if runj from server

//If (Current user#"administrator")
//$iError:=USER_Change_User ("administrator";"iC0mp")
//End if 

If (Count parameters:C259>=1)
	$iOption:=$1
Else 
	$iOption:=0
End if 

If (Count parameters:C259>=2)
	$tFilePath:=$2
Else 
	$tFilePath:=""  //SP_Get_TempFolder +"UsersGroups_"+DTS_Get_Current +".4ug"
End if 

If (Current user:C182="designer") | (Current user:C182="administrator")
	USERS TO BLOB:C849($xBlob)
	
	If (OK=1)
		
		Case of 
			: ($iOption=0)  //default
				//UUrgSetParameter("CompanyInfo";"UsersAndGroups";"";False;Current date;!00/00/0000!;"";->$xBlob)
				READ WRITE:C146([CompanyInfo:7])
				UNLOAD RECORD:C212([CompanyInfo:7])
				ALL RECORDS:C47([CompanyInfo:7])
				[CompanyInfo:7]xUsersGroups:19:=$xBlob
				SAVE RECORD:C53([CompanyInfo:7])
				UNLOAD RECORD:C212([CompanyInfo:7])
				READ ONLY:C145([CompanyInfo:7])
				
			: ($iOption=1)  //disk file
				$hRef:=Create document:C266($tFilePath)
				CLOSE DOCUMENT:C267($hRef)
				BLOB TO DOCUMENT:C526(document; $xBlob)
			Else 
				
		End case 
		
	Else 
		ALERT:C41("Users to blob failed.")
	End if 
End if 

