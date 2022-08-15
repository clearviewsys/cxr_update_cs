//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/26/20, 13:02:06
// ----------------------------------------------------
// Method: confirmationSendBroadcastMgr
// Description
// 
//
// Parameters
// ----------------------------------------------------


//CREATE BROADCAST METHOD - USER TABLE - IS USER MANAGER - AND BROADCAST/EMAIL - USE ORDA - QUERY -LOOP ENTITY SELECTION

// do i use isUserManager or should we use Groups ?? Tiran?

//C_TEXT($1;$tID)
C_OBJECT:C1216($1; $oInput)

C_LONGINT:C283($0; $iError)

C_TEXT:C284($tID; $tEmail; $tUser)
C_BOOLEAN:C305($bEmail; $bHola; $bSMS)
C_LONGINT:C283($iCount)
C_OBJECT:C1216($user; $users)

$oInput:=New object:C1471
$oInput:=$1
//$tID:=$1

If ($oInput.id=Null:C1517)
	$tID:=""
Else 
	$tID:=$oInput.id
End if 

If ($oInput.sendEmail=Null:C1517)
	$bEmail:=True:C214
Else 
	$bEmail:=$oInput.sendEmail
End if 

If ($oInput.sendHola=Null:C1517)
	$bHola:=True:C214
Else 
	$bHola:=$oInput.sendHola
End if 

If ($oInput.sendSMS=Null:C1517)  //not implemented yet
	$bSMS:=False:C215
Else 
	$bSMS:=$oInput.sendSMS
End if 

$iError:=0
$iCount:=0

READ ONLY:C145([Confirmations:153])
QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)

If (Records in selection:C76([Confirmations:153])=1)
	$users:=ds:C1482.Users.query("isInactive= False AND isManager = True")  // AND UserName # :1";getApplicationUser ) ` already confirmed currrent user is not Mgr
	
	If ($users.length>0)
		
		ARRAY TEXT:C222($atEmail; 0)
		
		ARRAY TEXT:C222($atClients; 0)
		ARRAY LONGINT:C221($aiMethods; 0)
		GET REGISTERED CLIENTS:C650($atClients; $aiMethods)
		
		For each ($user; $users)
			
			$tUser:=$user.UserName
			
			If ($bHola)
				If (Find in array:C230($atClients; $tUser)>0)  //make sure the user is currently registered
					$iError:=confirmationSendHola($tID; $tUser)
					
					If ($iError=0)
						$iCount:=$iCount+1
					End if 
					
				End if 
			End if 
			
			If ($bEmail)
				$tEmail:=$user.email
				If (UTIL_isValidEmail($tEmail))
					APPEND TO ARRAY:C911($atEmail; $tEmail)
				End if 
			End if 
			
			If ($bSMS)  //<>TODO
				
			End if 
			
		End for each 
		
		If (Size of array:C274($atEmail)>0)
			
			C_OBJECT:C1216($oEmails)
			OB SET ARRAY:C1227($oEmails; "emails"; $atEmail)
			
			$iError:=confirmationSendEmails($tID; $oEmails)
			
			If ($iError=0)  //all emails sent
				$iCount:=$iCount+Size of array:C274($atEmail)
			Else 
				$iCount:=$iCount+$iError  //error will be the number actually sent
			End if 
			
		End if 
		
		If ($iCount=0)
			$iError:=-4  //confirmationBroadcastFailed `broadcast failure
		Else 
			$iError:=0  //as long as at least one was sent assume good
		End if 
		
	Else 
		$iError:=-2  //confirmationNoUsersFound `no users config'd as managers
	End if 
	
Else 
	$iError:=confirmationNotFound
End if 

$0:=$iError  //send back an error if nothing has been sent