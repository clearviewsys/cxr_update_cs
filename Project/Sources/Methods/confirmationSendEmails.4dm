//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/11/20, 16:03:03
// ----------------------------------------------------
// Method: confirmationSendEmails
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tID)
C_OBJECT:C1216($2; $oEmails)  //object with an array of email addresses
C_LONGINT:C283($3; $iMode)  //DO NOT USE - only this method will send in $3 - DO NOT SEND IN $3 - used to create new processes
C_TEXT:C284($4; $tUser)  // DO NOT USE - only this method will send in $4 when creating a new process

C_LONGINT:C283($0; $iError)

C_LONGINT:C283($i; $iCount; $iProcess)

If (Count parameters:C259>=2)
	$tID:=$1
	$oEmails:=$2
End if 

If (Count parameters:C259>=3)  //only used to create new process
	$iMode:=$3
Else 
	$iMode:=Num:C11(getKeyValue("confirmation.email.notification.mode"; "3"))  //default to server sending 6/22/20
End if 

If (Count parameters:C259>=4)
	$tUser:=$4
Else 
	$tUser:=""
End if 

If (Count parameters:C259>4) | (Count parameters:C259=0)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

ARRAY TEXT:C222($atEmails; 0)
OB GET ARRAY:C1229($oEmails; "emails"; $atEmails)

$iCount:=0

Case of 
	: (Count parameters:C259>=3) | ($iMode=0)  //new process on client or server or mode=local synchronous
		//$iMode = 0 or $iMode = 2 via a worker process
		If ($iMode=0)
			//TRACE
		End if 
		
		For ($i; 1; Size of array:C274($atEmails))
			$iError:=confirmationSendEmail($tID; $atEmails{$i})  //returns smtp error number
			
			If ($iError=0)
				$iCount:=$iCount+1
			Else   //error sending email
				If ($tUser="")
				Else 
					iH_Notify_Client($tUser; "Email FAILED"; "Unable to send to: "+$atEmails{$i}+" Error: "+String:C10($iError); 10)
				End if 
			End if 
		End for 
		
	: ($iMode=1)  //calendar event stored procedure <>TODO change to use [Notifications] table
		For ($i; 1; Size of array:C274($atEmails))
			$tID:=createCalendarStoredProc(Current method name:C684; "<!--#4DEVAL confirmationSendEMail(\""+$tID+"\";\""+$atEmails{$i}+"\")")
			
			If ($tID="")  //not created
			Else 
				$iCount:=$iCount+1  //we've attempted to send emails
			End if 
			
		End for 
		
	: ($iMode=2) | (Application type:C494=4D Local mode:K5:1)  //new process on client
		If (False:C215)
			$iProcess:=New process:C317(Current method name:C684; 0; Current method name:C684; $tID; $oEmails; $iMode; getSystemUserName)
			If ($iProcess=0)
			Else 
				$iCount:=Size of array:C274($atEmails)  //assume all emails will send
			End if 
			
		Else 
			//can i use call worker here?
			CALL WORKER:C1389(1; Current method name:C684; $tID; $oEmails; $iMode; getSystemUserName)
			$iCount:=Size of array:C274($atEmails)  //assume all emails will send
		End if 
		
	: ($iMode=3)  //new process on server
		$iProcess:=Execute on server:C373(Current method name:C684; 0; Current method name:C684; $tID; $oEmails; $iMode; getSystemUserName)
		
		If ($iProcess=0)
		Else 
			$iCount:=Size of array:C274($atEmails)  //assume all emails will send
		End if 
		
	: ($iMode=4)  //add record to [Notificatons] table <>TODO
		
		
	Else   //error shouldn't happen
		
		$iCount:=-9998  //error - configuration error - keyvalues
		
End case 

If ($iCount=Size of array:C274($atEmails))
	$0:=0
Else 
	$0:=Size of array:C274($atEmails)-$iCount  //number of emails not sent
End if 