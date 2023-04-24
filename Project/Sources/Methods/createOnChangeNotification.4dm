//%attributes = {}


//sends email to the customer/links email

C_POINTER:C301($1; $ptrTable)


C_TEXT:C284($name; $context; $body; $currErrMethod)
C_LONGINT:C283($state; $time; $unique; $origin)
C_BOOLEAN:C305($mode)
C_POINTER:C301($ptrField)
C_LONGINT:C283($i)


$ptrTable:=$1

initEmailVars($ptrTable)

$email:=""
$sms:=""

If (Sync_IsSyncProcess)
	//don't run if this is a sync record
Else 
	
	C_TEXT:C284($name; $context; $email; $sms)
	C_LONGINT:C283($state; $time; $unique; $origin)
	C_BOOLEAN:C305($mode)
	
	ARRAY TEXT:C222($arrEmail; 0)
	ARRAY TEXT:C222($arrSMS; 0)
	
	$currErrMethod:=Method called on error:C704
	ON ERR CALL:C155("onErrCallIgnore")
	
	
	PROCESS PROPERTIES:C336(Current process:C322; $name; $state; $time; $mode; $unique; $origin)
	
	If ($origin=Web process on 4D remote:K36:17) | ($origin=Web process with no context:K36:8) | ($origin=Web server process:K36:18)
		If (webIsLicensed)
			$context:=WAPI_getSession("context")
			
			Case of 
				: ($context="customers")
					webSelectCustomerRecord
					APPEND TO ARRAY:C911($arrEmail; [Customers:3]Email:17)
					APPEND TO ARRAY:C911($arrSMS; [Customers:3]CellPhone:13)
					
				: ($context="agents")
					webSelectAgentRecord
					APPEND TO ARRAY:C911($arrEmail; [Agents:22]email:8)
					APPEND TO ARRAY:C911($arrSMS; "")
					
				: ($context="users")
					//APPEND TO ARRAY($arrEmail;"")
					//APPEND TO ARRAY($arrSMS;"")
					
				Else 
					//APPEND TO ARRAY($arrEmail;"")
					//APPEND TO ARRAY($arrSMS;"")
			End case 
			
		End if 
		
	Else   //user process - 4d user
		//does the [Customer] need to be notified?
		$context:=""
		
		//does the current table have a CustomerID field? if so get it and the customer record
		$ptrField:=getCustomerIdPtr($ptrTable)
		
		Case of 
			: (Is nil pointer:C315($ptrField))
				
			: ($ptrField=(->[Customers:3]CustomerID:1))  //this is the customer record
				APPEND TO ARRAY:C911($arrEmail; [Customers:3]Email:17)
				APPEND TO ARRAY:C911($arrSMS; [Customers:3]CellPhone:13)
				
			: ($ptrTable=(->[eWires:13]))
				C_OBJECT:C1216($entity)
				$entity:=ds:C1482.Customers.query("CustomerID == :1"; $ptrField->)
				
				If ($entity.length=1)
					APPEND TO ARRAY:C911($arrEmail; $entity.first().Email)
					APPEND TO ARRAY:C911($arrSMS; $entity.first().CellPhone)
				End if 
				
				If (False:C215)  //disabled for now per Pravin
					$entity:=ds:C1482.Links.query("LinkID == :1"; [eWires:13]LinkID:8)
					If ($entity.length=1)
						APPEND TO ARRAY:C911($arrEmail; $entity.first().email)
						APPEND TO ARRAY:C911($arrSMS; $entity.first().MainPhone)
					End if 
				End if 
				
				
			Else 
				C_OBJECT:C1216($entity)
				$entity:=ds:C1482.Customers.query("CustomerID == :1"; $ptrField->)
				
				If ($entity.length=1)
					APPEND TO ARRAY:C911($arrEmail; $entity.first().Email)
					APPEND TO ARRAY:C911($arrSMS; $entity.first().CellPhone)
				End if 
		End case 
		
	End if 
	
	
	If (Size of array:C274($arrEmail)>0)
		
		For ($i; 1; Size of array:C274($arrEmail))
			$email:=$arrEmail{$i}
			$email:=strRemoveSpaces($email)
			
			C_OBJECT:C1216($templateInfo)
			$templateInfo:=getEmailTemplateForTable($ptrTable; $context)
			If ($templateInfo.template="")  //no template so no email
				//iH_Notify ("Alert";"Email not sent to: "+$email+" | No template found.";15)
			Else 
				$body:=getEmailTemplateBody($templateInfo.template; $ptrTable)
				If ($body="")  //no body so don't email -- <>TODO maybe add email alert to config???
					iH_Notify("Alert"; "Email not sent to: "+$email+" | No Body for email found."; 15)
				Else 
					If (True:C214)
						C_OBJECT:C1216($o)
						$o:=New object:C1471
						$o.to:=$email
						$o.subject:=$templateInfo.subject
						$o.message:=$body
						If (OB Is defined:C1231($templateInfo; "sourceTable"))
							$o.sourceTable:=$templateInfo.sourceTable
						End if 
						If (OB Is defined:C1231($templateInfo; "sourceId"))
							$o.sourceId:=$templateInfo.sourceId
						End if 
						If (OB Is defined:C1231($templateInfo; "sourceType"))
							$o.sourceType:=$templateInfo.sourceType
						End if 
						
						sendNotificationObjectByEmail($o)
					Else 
						sendNotificationByEmail($email; $templateInfo.subject; $body)
					End if 
				End if 
				
				
			End if 
			
		End for 
	End if 
	
	If (Size of array:C274($arrSMS)>0)
		//<>TODO
		
	End if 
	
	ON ERR CALL:C155($currErrMethod)
End if 

initEmailVars  //clear