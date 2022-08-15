//%attributes = {}

C_LONGINT:C283($iCorrectCount)
C_OBJECT:C1216($entity)
C_TEXT:C284($webErrorMessage; $onHoldMessage; $confirmedMessage; $noAccountMessage; $unableConfirmMessage)
C_TEXT:C284($tCity; $tContext; $tDOB; $tEmail; $tSecret; $tSIN; $log; $yesCity; $yesDOB)
C_DATE:C307($dDOB)
C_LONGINT:C283($webMessageType)


$iCorrectCount:=0
$webErrorMessage:=""

$tEmail:=WAPI_getInputValue(->[WebUsers:14]Email:3)

$entity:=ds:C1482.WebUsers.query("Email IS :1"; $tEmail)
//QUERY([WebUsers];[WebUsers]Email=$tEmail)

If ($entity.length=1)  //(Records in selection([WebUsers])=1)
	
	READ WRITE:C146([WebUsers:14])
	USE ENTITY SELECTION:C1513($entity)
	LOAD RECORD:C52([WebUsers:14])
	
	If (True:C214)
		
	End if 
	
	$confirmedMessage:=getKeyValue("web.customers.profile.confirmed.alert")
	If ($confirmedMessage="")
		$confirmedMessage:="<b>SUCCESS.</b>. Your account is now confirmed. Please log in to begin using CXR online."
	End if 
	
	$onHoldMessage:=getKeyValue("web.customers.profile.onhold.alert")
	If ($onHoldMessage="")
		$onHoldMessage:="<b>Your account is on hold</b>. You cannot confirm an email. Contact support."
	End if 
	
	$noAccountMessage:=getKeyValue("web.customers.profile.usernotfound.alert")
	If ($noAccountMessage="")
		$noAccountMessage:="<b>Error locating your account.</b>. Please contact support."  // [-9997]."
	End if 
	
	$unableConfirmMessage:=getKeyValue("web.customers.profile.unabletoconfirm.alert")
	If ($unableConfirmMessage="")
		$unableConfirmMessage:="<b>We were unable to confirm your security questions.</b>. Please contact support if you need additional assistance."  // [-9995]."
	End if 
	
	
	If ([WebUsers:14]isLocked:10)
		$webErrorMessage:=$onHoldMessage+" [-9994]"  //"<b>Your account is on hold</b>. You cannot confirm an email. Contact support."
		$webMessageType:=4
	Else 
		
		$tContext:=WAPI_getSession("context")
		
		Case of 
			: ($tContext="customers")  //compare and update to link to customer record
				
				$entity:=ds:C1482.Customers.query("Email IS :1"; [WebUsers:14]Email:3)
				
				If ($entity.length=1)
					C_OBJECT:C1216($customer)
					$customer:=$entity.first()
					
					$tDOB:=WAPI_getInputValue(->[Customers:3]DOB:5)  //+"T00:00:00"
					$tCity:=strRemoveSpaces(WAPI_getInputValue(->[Customers:3]City:8))
					$tSIN:=strRemoveSpaces(WAPI_getInputValue(->[Customers:3]SIN_No:14))
					$tSecret:=strRemoveSpaces(WAPI_getInputValue(->[Customers:3]SecretQuestion:83))
					
					
					
					If ($tCity=strRemoveSpaces($customer.City)) & ($customer.City#"")
						$iCorrectCount:=$iCorrectCount+1
						$yesCity:="Match"
					End if 
					
					$dDOB:=Date:C102($tDOB)
					If ($dDOB>!1900-01-01!)
						If ($dDOB=$customer.DOB)
							$iCorrectCount:=$iCorrectCount+1
							$yesDOB:="Match"
						Else 
							$yesDOB:="No Match"
						End if 
					Else 
						$tDOB:=""
						$yesDOB:="Bad Date"
					End if 
					
					If ($tSIN=strRemoveSpaces($customer.SIN_No)) & ($customer.SIN_No#"")
						$iCorrectCount:=$iCorrectCount+1
					Else 
						If ($tSIN=strRemoveSpaces($customer.PictureID_Number)) & ($customer.PictureID_Number#"")
							$iCorrectCount:=$iCorrectCount+1
						End if 
					End if 
					
					If ($tSecret=strRemoveSpaces($customer.SecretQuestion)) & ($customer.SecretQuestion#"")
						$iCorrectCount:=$iCorrectCount+1
					End if 
					
					If ($iCorrectCount>=2)
						[WebUsers:14]recordID:9:=$customer.CustomerID  //establish the link
						SAVE RECORD:C53([WebUsers:14])
						
						Case of 
							: ([WebUsers:14]phoneType:20="Cell") & ($customer.CellPhone="")
								$customer.CellPhone:=[WebUsers:14]phone:19
							: ([WebUsers:14]phoneType:20="Home") & ($customer.HomeTel="")
								$customer.HomeTel:=[WebUsers:14]phone:19
							: ([WebUsers:14]phoneType:20="Work") & ($customer.WorkTel="")
								$customer.WorkTel:=[WebUsers:14]phone:19
						End case 
						
						If ($customer.touched())
							C_OBJECT:C1216($result)
							$result:=$customer.save(dk auto merge:K85:24)
							If ($result.success)
							Else 
								//error updating customer
							End if 
						End if 
						
						
						
						$webErrorMessage:=$confirmedMessage  //"<b>SUCCESS.</b>. Your account is now confirmed. Please log in to begin using CXR online."
						$webMessageType:=1
						
					Else 
						$webErrorMessage:=$unableConfirmMessage+" [-9995]"
						If (True:C214)
							$log:=$log+"<br>Correct Count: "+String:C10($iCorrectCount)+"<br>"
							$log:=$log+"<br>"+"<b>Validation provided: </b>.<br>"
							$log:=$log+"  Date of Birth: "+String:C10($dDOB)+"-"+String:C10($customer.DOB)+"-"+$yesDOB+"<br>"
							$log:=$log+"  City: "+$tCity+"-"+$customer.City+"-"+$yesCity+"<br>"
							$log:=$log+"  ID: "+$tSIN+"<br>"
							$log:=$log+"  Secret: "+$tSecret+"<br>"
							
							WAPI_Log(Current method name:C684; $log)
						End if 
						
						$webMessageType:=4
					End if 
					
				Else 
					$webErrorMessage:=$noAccountMessage+" [-9997]"  //"<b>Error locating your account.
					$webMessageType:=4
				End if 
				
			Else 
				$webErrorMessage:="<b>Unsupported Context.</b>[."+$tContext+"] Please contact support."
				$webMessageType:=4
		End case 
		
		
	End if 
	
Else 
	$webErrorMessage:=$noAccountMessage+" [-9996]"  //"<b>Error locating your account.</b>. 
	$webMessageType:=4
End if 

UNLOAD RECORD:C212([WebUsers:14])
READ ONLY:C145([WebUsers:14])
REDUCE SELECTION:C351([WebUsers:14]; 0)

If ($webErrorMessage="")
Else 
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
End if 

webSendLoginPage
