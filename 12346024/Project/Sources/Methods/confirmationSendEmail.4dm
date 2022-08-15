//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/17/20, 18:34:17
// ----------------------------------------------------
// Method: confirmationSendEmail
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tID)
C_TEXT:C284($2; $tTo)
//C_COLLECTION($3;$colAttachments)

C_LONGINT:C283($0; $iError)


C_TEXT:C284(_CONFIRM_APPROVE_URL; _CONFIRM_DENY_URL; _CONFIRM_USER_EMAIL; _CONFIRM_APPROVE_CODE)  //process vars for use in PROCESS 4D TAGS
C_TEXT:C284(_CONFIRM_REQUEST_USER)

C_BOOLEAN:C305($useNotifications)
C_TEXT:C284($tHost; $tHTML; $tHTTPSPort; $tPort; $tSSLEnabled; $tSubject; $tTemplate; $tURL)
C_LONGINT:C283($i)
C_OBJECT:C1216($options)



If (Count parameters:C259>=1)
	$tID:=$1
Else 
	$tID:=""
End if 

If (Count parameters:C259>=2)
	$tTo:=$2
Else 
	$tTo:="barclay@clearviewsys.com"
End if 

$useNotifications:=False:C215

If ([Confirmations:153]confirmationID:2=$tID)  //we have the correct record
Else 
	READ ONLY:C145([Confirmations:153])
	QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
End if 

C_TEXT:C284($tTemplate; $tHost; $tPort; $tSSLEnabled; $tHTTPSPort; $tURL; $tHTML)
If ([Confirmations:153]confirmationID:2=$tID)  //(Records in selection([Confirmations])=1)
	
	Case of 
		: (UTIL_isWebServerRunning)
			
			$tTemplate:=Get 4D folder:C485(Current resources folder:K5:16; *)+"email-templates"+Folder separator:K24:12+"confirm-email.html"
			
			$tHost:=getKeyValue("confirmation.server.hostname"; "")
			$tPort:=getKeyValue("confirmation.server.portid"; "")
			$tSSLEnabled:=getKeyValue("confirmation.server.httpsenabled")
			$tHTTPSPort:=getKeyValue("confirmation.server.httpsportid")
			
			If ($tSSLEnabled="true")
				If ($tHTTPSPort="443")
					$tURL:="https://"+$tHost
				Else 
					$tURL:="https://"+$tHost+":"+$tHTTPSPort
				End if 
			Else 
				If ($tPort="80")
					$tURL:="http://"+$tHost
				Else 
					$tURL:="http://"+$tHost+":"+$tPort
				End if 
			End if 
			
			
			If (Test path name:C476($tTemplate)=Is a document:K24:1)
				_CONFIRM_APPROVE_URL:=$tURL+"/confirm.jsp?mode=accept&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo
				_CONFIRM_DENY_URL:=$tURL+"/confirm.jsp?mode=deny&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo
				_CONFIRM_USER_EMAIL:=$tTo
				_CONFIRM_APPROVE_CODE:=[Confirmations:153]confirmCode:17
				
				$tHTML:=Document to text:C1236($tTemplate)
				PROCESS 4D TAGS:C816($tHTML; $tHTML)
				
				//SET TEXT TO PASTEBOARD($tHTML)
			Else 
				
				If (False:C215)
					$tHTML:="Please accept of deny this request"+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
					$tHTML:=$tHTML+"ACCEPT: "+"http://127.0.0.1:8080/executeMethod/confirm?mode=accept&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
					$tHTML:=$tHTML+"DENY: "+"http://127.0.0.1:8080/executeMethod/confirm?mode=deny&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo
				Else 
					$tHTML:="<html><head> </head>"
					$tHTML:=$tHTML+"<body> <h3>Please accept or deny this request.</h3>"
					
					$tHTML:=$tHTML+"<div><p>"
					$tHTML:=$tHTML+[Confirmations:153]confirmationMessage:6
					$tHTML:=$tHTML+"</p></div>"
					
					$tHTML:=$tHTML+"<div style='border-style: solid; border-color: green; width: 100px; margin: auto;'>"
					$tHTML:=$tHTML+"<a href=\"http://127.0.0.1:8081/executeMethod/confirm?mode=accept&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo+"\">APPROVE</a>"
					$tHTML:=$tHTML+"</div>"
					$tHTML:=$tHTML+"<div style='border-style: solid; border-color: red; width: 100px; margin: auto;'>"
					$tHTML:=$tHTML+"<a href=\"http://127.0.0.1:8081/executeMethod/confirm?mode=deny&id="+[Confirmations:153]confirmationID:2+"&token="+[Confirmations:153]UUID:1+"&auth="+$tTo+"\">DENY</a>"
					$tHTML:=$tHTML+"</div>"
					$tHTML:=$tHTML+"</body></html>"
					
					//$tHTML:=cURL_Escape($tHTML)
				End if 
				
			End if 
			
		Else   //now web server so use the confimration code
			
			$tTemplate:=Get 4D folder:C485(Current resources folder:K5:16; *)+"email-templates"+Folder separator:K24:12+"confirm-code-email.html"
			
			If (Test path name:C476($tTemplate)=Is a document:K24:1)
				_CONFIRM_USER_EMAIL:=$tTo
				_CONFIRM_APPROVE_CODE:=[Confirmations:153]confirmCode:17
				_CONFIRM_REQUEST_USER:=[Confirmations:153]requestUser:7
				
				$tHTML:=Document to text:C1236($tTemplate)
				PROCESS 4D TAGS:C816($tHTML; $tHTML)
				
			Else 
				$tHTML:="<html><head> </head>"
				$tHTML:=$tHTML+"<body> <h3>Please accept or deny this request.</h3>"
				
				$tHTML:=$tHTML+"<div><p>"
				$tHTML:=$tHTML+[Confirmations:153]confirmationMessage:6
				$tHTML:=$tHTML+"</p></div>"
				$tHTML:=$tHTML+"<div>"
				$tHTML:=$tHTML+"<p>Contact "+[Confirmations:153]requestUser:7+" and provide the following code to approve:</p>"
				$tHTML:=$tHTML+"<p style='color:green;font-size:24px;'>Confirmation Code: "+[Confirmations:153]confirmCode:17+"</p>"
				$tHTML:=$tHTML+"</div>"
				$tHTML:=$tHTML+"</body></html>"
			End if 
			
	End case 
	
	$tSubject:=[Confirmations:153]confirmationSubject:16
	
	If ([Confirmations:153]confirmObject:15=Null:C1517)
		If ($useNotifications)  // create a notification table
			sendNotificationByEmail($tTo; $tSubject; $tHTML)
		Else   //let the notification process table do the emailing
			$iError:=sendEmail($tTo; $tSubject; $tHTML)
		End if 
	Else 
		If ([Confirmations:153]confirmObject:15.attachments=Null:C1517)  //no attachments
			If ($useNotifications)  // create a notification table
				sendNotificationByEmail($tTo; $tSubject; $tHTML)
			Else   //let the notification process table do the emailing
				$iError:=sendEmail($tTo; $tSubject; $tHTML)
			End if 
		Else 
			C_COLLECTION:C1488($colAttachments)
			$colAttachments:=New collection:C1472
			ARRAY TEXT:C222($atPaths; 0)
			OB GET ARRAY:C1229([Confirmations:153]confirmObject:15; "attachments"; $atPaths)
			
			//<>TODO need to make sure the $colAttachemnts paths are local to method
			//if not retrieve from server so we can send from this process
			For ($i; 1; Size of array:C274($atPaths))
				If (Test path name:C476($atPaths{$i})=Is a document:K24:1)  //all good
				Else 
					$atPaths{$i}:=iH_documentGetPath($atPaths{$i}; Temporary folder:C486)  //retreive from server
				End if 
			End for 
			
			ARRAY TO COLLECTION:C1563($colAttachments; $atPaths)
			
			If ($colAttachments.length=0)
				
				If ($useNotifications)  // create a notification table
					sendNotificationByEmail($tTo; $tSubject; $tHTML)
				Else 
					$iError:=sendEmail($tTo; $tSubject; $tHTML)
				End if 
			Else 
				
				If ($useNotifications)  // create a notification table
					sendNotificationByEmail($tTo; $tSubject; $tHTML; $colAttachments)
				Else 
					$options:=New object:C1471
					$options.URL:="smtp://"+<>SMTPSERVER
					$options.PORT:=<>SMTPPORTNO
					$options.USERNAME:=<>SMTPUSERNAME
					$options.PASSWORD:=<>SMTPPASSWORD
					$options.MAIL_FROM:=<>SMTPFROMEMAIL
					$options.MAIL_RCPT:=$tTo
					$options.BODY:=$tHTML
					$options.SUBJECT:=$tSubject
					$iError:=sendEmailviacURL($options; $colAttachments)
				End if 
				
			End if 
			
		End if 
	End if 
	
	//If ([Confirmations]confirmObject.attachments=Null)
	//Else 
	//C_COLLECTION($colAttachments)
	//$colAttachments:=New collection
	//ARRAY TEXT($atPaths;0)
	//OB GET ARRAY([Confirmations]confirmObject;"attachments";$atPaths)
	//ARRAY TO COLLECTION($colAttachments;$atPaths)
	//End if 
	
	
	
	//If ($colAttachments.length=0)
	//$iError:=sendEmail ($tTo;$tSubject;$tHTML)
	//Else 
	
	//$options:=New object
	
	//$options.URL:="smtp://"+<>SMTPSERVER
	//$options.PORT:=<>SMTPPORTNO
	//$options.USERNAME:=<>SMTPUSERNAME
	//$options.PASSWORD:=<>SMTPPASSWORD
	//$options.MAIL_FROM:=<>SMTPFROMEMAIL
	//$options.MAIL_RCPT:=$tTo
	//$options.BODY:=$tHTML
	//$options.SUBJECT:=$tSubject
	
	
	//$iError:=sendEmailviacURL ($options;$colAttachments)
	
	
	//End if 
	
	
	
Else 
	$iError:=confirmationNotFound  //confirmation not found
End if 


$0:=$iError

