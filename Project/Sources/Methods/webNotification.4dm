//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/19/20, 21:49:48
// ----------------------------------------------------
// Method: webNotification
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($email; $subject; $message; $param)
C_TEXT:C284($emailTemplate)
C_BOOLEAN:C305($isFound)
C_LONGINT:C283($i)
C_POINTER:C301($ptrTable)



$email:=getKeyValue("web.configuration.notification.email")
ARRAY TEXT:C222($atEmail; 0)
STR_SplitToArray($email; ","; ->$atEmail)  //array of email addresses to send to

If (Size of array:C274($atEmail)=0)
	$email:=WAPI_getParameter("email-to")  //should this be added regardless or as a backup?
	If ($email="")
		APPEND TO ARRAY:C911($atEmail; "barclay@clearviewsys.com")
	Else 
		APPEND TO ARRAY:C911($atEmail; $email)
	End if 
End if 


ARRAY TEXT:C222($atParameters; 0)
WAPI_getParameters(->$atParameters)


//get current record for table passed in so we can use data for process 4d tags
$ptrTable:=WAPI_getCurrTablePtr
$isFound:=WAPI_getCurrentRecord  //load record 

If ($isFound) | (Is nil pointer:C315($ptrTable))
	
	If (WAPI_getParameter("profile-existing-input")="on")  //checkbox is checked
		webSelectWebUserRecord(False:C215)  // load in readwrite
		If ([WebUsers:14]requestDate:21=!00-00-00!)
			[WebUsers:14]requestDate:21:=Current date:C33
			SAVE RECORD:C53([WebUsers:14])
		End if 
		UNLOAD RECORD:C212([WebUsers:14])
		READ ONLY:C145([WebUsers:14])
		LOAD RECORD:C52([WebUsers:14])  // keep the selection 3/8/23
	Else 
		webSelectWebUserRecord(True:C214)
	End if 
	
	$emailTemplate:=WAPI_getParameter("email-template")  //template specified in the form
	$subject:=WAPI_getParameter("email-subject")
	$message:=getEmailTemplateBody($emailTemplate)
	
	If ($message="")  //no body so don't email 
		
		$message:=""
		$message:=$message+"NO TEMPLATE FOUND : "+$emailTemplate+Char:C90(Carriage return:K15:38)
		$message:=$message+"----------------------------------------"+Char:C90(Carriage return:K15:38)
		$message:=$message+"WebUser: "+WAPI_getSession("username")+Char:C90(Carriage return:K15:38)
		$message:=$message+"WebUser email: "+WAPI_getSession("email")+Char:C90(Carriage return:K15:38)
		$message:=$message+"Context: "+WAPI_getSession("context")+Char:C90(Carriage return:K15:38)
		$message:=$message+"Template Requested: "+$emailTemplate+Char:C90(Carriage return:K15:38)
		$message:=$message+"Subject: "+$subject+Char:C90(Carriage return:K15:38)
		$message:=$message+"Host: "+WAPI_getHost+Char:C90(Carriage return:K15:38)
		
		For ($i; 1; Size of array:C274($atParameters))
			$message:=$message+$atParameters{$i}+": "+WAPI_getParameter($atParameters{$i})
		End for 
		
		$message:=$message+"----------------------------------------"+Char:C90(Carriage return:K15:38)
		
		For ($i; 1; Size of array:C274($atParameters))
			$param:=$atParameters{$i}
			$message:=$message+$param+": "+WAPI_getParameter($param)+Char:C90(Carriage return:K15:38)
		End for 
		
		If ($subject="")
			$subject:=Current method name:C684
		End if 
		
		For ($i; 1; Size of array:C274($atEmail))
			sendNotificationByEmail($atEmail{$i}; $subject; $message)
		End for 
		
	Else 
		
		For ($i; 1; Size of array:C274($atEmail))
			C_OBJECT:C1216($o)
			$o:=New object:C1471
			$o.to:=$atEmail{$i}
			$o.subject:=$subject
			$o.message:=$message
			
			If (Is nil pointer:C315($ptrTable)=False:C215)
				$o.sourceTable:=Table:C252($ptrTable)
				$o.sourceId:=WAPI_getCurrRecordID
				$o.sourceType:="web"
			End if 
			
			sendNotificationObjectByEmail($o)
		End for 
		
	End if 
	
	
	If (Is nil pointer:C315($ptrTable))
	Else 
		UNLOAD RECORD:C212($ptrTable->)
		READ ONLY:C145($ptrTable->)
		LOAD RECORD:C52($ptrTable->)  // keep the selection 3/8/23
		//REDUCE SELECTION($ptrTable->;0)
	End if 
	
Else 
	C_COLLECTION:C1488($col)
	$col:=New collection:C1472
	ARRAY TO COLLECTION:C1563($col; $atParameters)
	WAPI_Log(Current method name:C684; JSON Stringify:C1217($col))
End if 





//WAPI_sendFile (WAPI_getPageSuccess )