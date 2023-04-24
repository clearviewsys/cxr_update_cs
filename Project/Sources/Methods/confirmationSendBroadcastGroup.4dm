//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/26/20, 13:02:06
// ----------------------------------------------------
// Method: confirmationSendBroadcast
// Description
// 
//
// Parameters
// ----------------------------------------------------


//CREATE BROADCAST METHOD - USER TABLE - IS USER MANAGER - AND BROADCAST/EMAIL - USE ORDA - QUERY -LOOP ENTITY SELECTION



C_TEXT:C284($1; $tID)
C_TEXT:C284($2; $tGroup)

C_LONGINT:C283($0; $iError)


C_LONGINT:C283($iCount)
C_OBJECT:C1216($user; $users)
C_BOOLEAN:C305($useNotifications)
C_TEXT:C284($tUser; $tEmail)

$tID:=$1

If (Count parameters:C259>=2)
	$tGroup:=$2
Else 
	$tGroup:="*"
End if 

$iError:=0
$iCount:=0
$useNotifications:=False:C215

If ($tGroup="*")
	$users:=ds:C1482.Users.all
Else 
	$users:=ds:C1482.Users.query("isInactive= False AND Group = :1 AND UserID # :2"; $tGroup; getApplicationUser)
End if 

If ($users.length>0)
	
	ARRAY TEXT:C222($atEmail; 0)
	
	ARRAY TEXT:C222($atClients; 0)
	ARRAY LONGINT:C221($aiMethods; 0)
	GET REGISTERED CLIENTS:C650($atClients; $aiMethods)
	
	For each ($user; $users)
		
		$tUser:=$user.UserName
		
		If (Find in array:C230($atClients; $tUser)>0)  //make sure the user is currently registered
			$iError:=confirmationSendHola($tID; $tUser)
			
			If ($iError=0)
				$iCount:=$iCount+1
			End if 
			
		End if 
		
		$tEmail:=$user.email
		If (UTIL_isValidEmail($tEmail))
			If ($useNotifications)
				$iError:=confirmationSendEmail($tID; $tEmail)
				If ($iError=0)
					$iCount:=$iCount+1
				End if 
			Else 
				APPEND TO ARRAY:C911($atEmail; $tEmail)
			End if 
			
		End if 
		
	End for each 
	
	If ($useNotifications=False:C215)  //disable if using [notifications]
		If (Size of array:C274($atEmail)>0)
			C_OBJECT:C1216($oEmails)
			OB SET ARRAY:C1227($oEmails; "emails"; $atEmail)
			
			$iError:=confirmationSendEmails($tID; $oEmails)
			
			If ($iError=0)
				$iCount:=$iCount+Size of array:C274($atEmail)
			End if 
			
		End if 
	End if 
	
	
	If ($iCount=0)  //nothing was sent
		$iError:=-1
	Else 
		$iError:=0  //as long as at least one was sent assume good
	End if 
	
Else 
	$iError:=-1
End if 

$0:=$iError  //send back an error if nothing has been sent