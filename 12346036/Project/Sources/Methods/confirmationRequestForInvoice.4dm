//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/24/20, 19:38:35
// ----------------------------------------------------
// Method: confirmationRequestForInvoice
// Description
// 
//    called within a "new" invoice
// generate PDF of invoice and get a list of linkedDocs
// all attachments will be passed to the confirmation process

// Parameters
// ----------------------------------------------------

//,.TODO RETURE AN OBJECT WITH STATUS AND ERROR COLLECTION

//C_TEXT($1;$tSubject)
C_OBJECT:C1216($1; $oInput)

C_OBJECT:C1216($0; $oResult)

//C_LONGINT($0;$iError;$iFound)

C_BOOLEAN:C305($bIsManager)
C_BOOLEAN:C305($bEmail; $bHola; $bSMS)
C_TEXT:C284($tID)
C_LONGINT:C283($i; $iError; $iStatus)
C_TEXT:C284($tStoragePath; $tSubject; $tPath; $tTemp)

ARRAY TEXT:C222($atAttachments; 0)

$oInput:=New object:C1471

If (Count parameters:C259>=1)
	$oInput:=$1
	//$tSubject:=$1
	//Else 
	//$tSubject:="[ALERT] Invoice Confirmation Needed"
End if 

If ($oInput.subject=Null:C1517)
	$tSubject:="[ALERT] Invoice Confirmation Needed"
Else 
	$tSubject:=$oInput.subject
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



$tID:=""
$iError:=0
$oResult:=New object:C1471

READ ONLY:C145([LinkedDocs:4])

C_LONGINT:C283($iFound)  // #TB 

If (getApplicationUser="designer")  //this way we can test in dev
	$iFound:=ds:C1482.Users.query("isManager = True AND UserName = :1"; getSystemUserName).length
	$bIsManager:=$iFound=1
Else 
	//$iFound:=ds.Users.query("isManager = True AND UserName = :1";getApplicationUser ).length
	$bIsManager:=isUserManager
End if 

If ($bIsManager)  //is current user a manager? if so no need for confirmation
	//no confimrmation needed
	If (Current user:C182="designer")
		ALERT:C41("You are a manager. You don't need a confirmation. [Testing ONLY Alert]")
	End if 
Else 
	$tTemp:=vInvoiceNumber  //this is gettign reset to "" by the print to pdf
	$tPath:=printThisInvoiceAsPDF
	
	If (vInvoiceNumber="")
		vInvoiceNumber:=$tTemp  //restore the value
	End if 
	
	If (Test path name:C476($tPath)=Is a document:K24:1)
		$tStoragePath:=iH_documentPutPath($tPath)
		If ($tStoragePath="")
		Else 
			APPEND TO ARRAY:C911($atAttachments; $tStoragePath)
		End if 
	End if 
	
	QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252(->[Invoices:5]); *)
	QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=vInvoiceNumber)  //[Invoices]InvoiceID)
	
	
	For ($i; 1; Records in selection:C76([LinkedDocs:4]))
		
		If (Picture size:C356([LinkedDocs:4]ScannedImage:2)>0)
			
			Case of 
				: ([LinkedDocs:4]DocReference:6#"")
					$tPath:=Temporary folder:C486+strCleanFilename([LinkedDocs:4]DocReference:6)+".jpg"
					
				: ([LinkedDocs:4]TypeOfDoc:5#"")
					$tPath:=Temporary folder:C486+strCleanFilename([LinkedDocs:4]TypeOfDoc:5)+".jpg"
					
				Else 
					$tPath:=Temporary folder:C486+DATE_getCurrentDTS+".jpg"
			End case 
			
			
			WRITE PICTURE FILE:C680($tPath; [LinkedDocs:4]ScannedImage:2; ".jpg")
			
			If (Test path name:C476($tPath)=Is a document:K24:1)
				$tStoragePath:=iH_documentPutPath($tPath)
				If ($tStoragePath="")
				Else 
					APPEND TO ARRAY:C911($atAttachments; $tStoragePath)
				End if 
			End if 
			
		End if 
		
		NEXT RECORD:C51([LinkedDocs:4])
	End for 
	
	
	//now we have an array with all the attachments file paths relative to where the hola/emails will send from
	//holaFileStore
	
	C_OBJECT:C1216($o)
	$o:=New object:C1471
	$o.type:=1
	$o.subject:=$tSubject
	$o.message:=makeEmailBodyFromInvoice
	$o.relatedTable:=Table:C252(->[Invoices:5])
	$o.relatedID:=vInvoiceNumber  //[Invoices]InvoiceID
	OB SET ARRAY:C1227($o; "attachments"; $atAttachments)
	
	$tID:=confirmationCreate_($o)
	
	If ($tID="")
		$iError:=-1
	Else 
		
		If (False:C215)  //for testing
			$iError:=confirmationSendHola($tID; "barclay")
			$iError:=confirmationSendEmail($tID; "tiran@clearviewsys.com")
		End if 
		
		$oInput.id:=$tID
		$iError:=confirmationSendBroadcastMgr($oInput)  // ($tID)
		
	End if 
	
	If ($iError=0)
		If ($tID#"")
			
			$iStatus:=confirmationWaitForResult($tID)  //allow user to stop this process and if skip then not approved
			
			If ([Confirmations:153]confirmationID:2=$tID)  //we have the correct record
			Else 
				READ ONLY:C145([Confirmations:153])
				QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
			End if 
			
			$oResult.status:=$iStatus
			$oResult.confirmedUser:=[Confirmations:153]confirmedUser:10
			$oResult.confirmedDate:=[Confirmations:153]confirmedDate:8
			$oResult.confirmedTime:=[Confirmations:153]confirmedTime:9
			
			//$tAlert:="The status is:"+confirmationGetStatusText ($iStatus)+Char(Carriage return)+Char(Carriage return)
			//$tAlert:=$tAlert+"Confirmed by: "+[Confirmations]confirmedUser+" at "+String([Confirmations]confirmedTime)
			//myAlert ($tAlert)
		Else 
			$oResult.status:=confirmationNotFound
			//myAlert ("Error broadcasting the confirmation request - no [Confirmations] record found.")
		End if 
	Else   //set confirmation to a failed status and save
		//myAlert ("Error sending request. Error ["+String($iError)+"]")
		$iError:=confirmationSetStatus($tID; $iError; "ERROR")
		//myAlert ("Error broadcasting the confirmation request - no messages sent. Error: "+String($iError))
		$oResult.status:=confirmationUnknown
		$oResult.error:=$iError
	End if 
	
End if 

//$0:=$iError
$0:=$oResult