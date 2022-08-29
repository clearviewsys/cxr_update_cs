//%attributes = {}
// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/05/21, 22:19:24
// ----------------------------------------------------
// Method: checkAllEmailsProcess
// Description
// This Process started workers to make an API call for emails to be validated
// then saves the results for the entity
// Parameters
var $settingsObj; $1 : Object
//  $settingsObj:= {
//                    "criteria" : collection
//                    "countEmails" : integer
//                    "entitySelection" : Entity Selection
//                    "tablename" : String
//                    "fieldNames" : {                     // *Field names NOT values
//                                      "email": String
//                                      "isValid": String
//                                   }
//                 }
// ----------------------------------------------------
//Variables
var $validCriteria; $emailColl : Collection
var $sharedObj; $entity; $status : Object
var $hasError : Boolean
var $currentRecordNum; $progressBarID; $isEmailValid; $repeatCount : Integer
var $item; $errorString; $email_Feild; $isValidEmail_Field; $validString; $invalidString; $unknownString; $IDfieldName; $alertSubject; $tableName; $invalidString; $errorString : Text
var $countEmailsVerfied : Integer

// Declare
$validCriteria:=New collection:C1472()
$emailColl:=New collection:C1472()
$sharedObj:=New shared object:C1526()
$hasError:=False:C215
$errorString:="There was a has been an error, we couldn't verify the following Emails, their validity status has not been changed. Please try again later:"
$validString:="\n\n[VALID] The status of the following emails was set to valid:"
$invalidString:="\n\n[INVALID] The status of the following emails was set to invalid:"
$unknownString:="\n\n[UNKNOWN] The status of the following emails could not be determined and was set to unknown:"
$countEmailsVerfied:=0
$alertSubject:="Email Validation Results"

Case of 
	: (Count parameters:C259=1)
		$settingsObj:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$validCriteria:=$settingsObj.validCriteria
$email_Feild:=$settingsObj.fieldNames.email
$isValidEmail_Field:=$settingsObj.fieldNames.isValid

$currentRecordNum:=0
$progressBarID:=Progress New
Progress SET MESSAGE($progressBarID; "Checking "+String:C10($settingsObj.countEmails)+" emails...")

For each ($entity; $settingsObj.entitySelection)
	$emailColl.push($entity[$email_Feild])
	CALL WORKER:C1389($entity[$email_Feild]; "validateEmailWorker"; $entity[$email_Feild]; $sharedObj)
	$currentRecordNum:=$currentRecordNum+1
	Progress SET PROGRESS($progressBarID; $currentRecordNum/($settingsObj.countEmails*2))
End for each 

Repeat 
	For each ($item; $emailColl)
		If (OB Is defined:C1231($sharedObj; $item))
			$emailColl.remove($emailColl.indexOf($item))
		End if 
	End for each 
Until ($emailColl.length=0)

Progress SET MESSAGE($progressBarID; "Saving to database")

$tableName:=$settingsObj.tableName
If (Substring:C12($tableName; Length:C16($tableName); 1)="s")  //ends with s
	$IDfieldName:=Substring:C12($tableName; 1; Length:C16($tableName)-1)+"ID"
Else 
	$IDfieldName:=$tableName+"ID"
End if 

For each ($entity; $settingsObj.entitySelection)
	If ($sharedObj[$entity[$email_Feild]]#"error")
		Case of 
			: ($sharedObj[$entity[$email_Feild]]="unknown")
				$isEmailValid:=0
				$unknownString:=$unknownString+"\n- ["+$entity[$IDfieldName]+"] "+$entity[$email_Feild]
				$countEmailsVerfied:=$countEmailsVerfied+1
			: ($validCriteria.indexOf($sharedObj[$entity[$email_Feild]])#-1)
				$isEmailValid:=1
				$validString:=$validString+"\n- ["+$entity[$IDfieldName]+"] "+$entity[$email_Feild]
				$countEmailsVerfied:=$countEmailsVerfied+1
			Else 
				$isEmailValid:=2
				$invalidString:=$invalidString+"\n- ["+$entity[$IDfieldName]+"] "+$entity[$email_Feild]
				$countEmailsVerfied:=$countEmailsVerfied+1
		End case 
	Else 
		$hasError:=True:C214
	End if 
	
	$entity[$isValidEmail_Field]:=$isEmailValid
	$repeatCount:=0
	Repeat 
		$status:=$entity.save()
		$repeatCount:=$repeatCount+1
		$entity.reload()
	Until (($status.success=True:C214) | ($repeatCount=3))
	If ($repeatCount=3)
		$hasError:=True:C214
	End if 
	
	If ($hasError=True:C214)
		$errorString:=$errorString+"\n"+String:C10($entity[$IDfieldName])+" - "+$entity[$email_Feild]
	End if 
	$currentRecordNum:=$currentRecordNum+1
	Progress SET PROGRESS($progressBarID; $currentRecordNum/($settingsObj.countEmails*2))
End for each 

Progress QUIT($progressBarID)

If ($hasError=True:C214)
	If ($countEmailsVerfied>0)
		myAlert($errorString+"\n\nEmails validity of the following emails has been updated.\nCount: "+String:C10($countEmailsVerfied)+$validString+$invalidString+$unknownString; $alertSubject)
	Else 
		myAlert($errorString)
	End if 
Else 
	myAlert("Emails validity of the following emails has been updated.\nCount: "+String:C10($countEmailsVerfied)+$validString+$invalidString+$unknownString; $alertSubject)
End if 







//$finalObj:=New shared object()
//Use ($finalObj)
//$finalObj.entitySelection:=$settingsObj.entitySelection.copy(ck shared)
//End use 
//$i:=0
//For each ($e; $finalObj.entitySelection)
//CALL WORKER($entity.Email+"db"; "saveValidatedEmailWorker"; $i; $e.Email; $finalObj; $sharedObj)
//$i:=$i+1
//End for each 

//For each ($entity; )
//$emailColl.push($entity.Email)
//Use ($finalObj)
//$finalObj[$entity.Email]:=$entity.copy(ck shared)
//End use 
//$emailStatus:=$sharedObj[$entity.Email]

//CALL WORKER($entity.Email+"db"; "saveValidatedEmailWorker"; $entity.Email; $emailStatus; $validCriteria; $finalObj)
//End for each 






//$finalObj:=New shared object()
//Use ($finalObj)
//$finalObj.errorString:="There was an error validating the following emails:"
//$finalObj.count:=0
//End use 

//For each ($entity; $settingsObj.entitySelection)
//$emailColl.push($entity.Email)
//Use ($finalObj)
//$finalObj[$entity.Email]:=$entity
//End use 
//$emailStatus:=$sharedObj[$entity.Email]
//CALL WORKER($entity.Email+"db"; "saveValidatedEmailWorker"; $entity.Email; $emailStatus; $validCriteria; $finalObj)
//End for each 

//Repeat 
//Until ($finalObj.count=$settingsObj.countEmails)







//$customers:=$settingsObj.entitySelection
//$countEmails:=$customers.length
////If (OK=1)
//$currentRecordNum:=0
//$progressBarID:=Progress New
//Progress SET MESSAGE($progressBarID; "Checking "+String($countEmails)+" emails...")


////$customers:=Create entity selection([Customers])
//$hasError:=False
//$errorString:="There was an error validating emails for the following customers:"

//For each ($cus; $customers)
//Progress SET PROGRESS($progressBarID; $currentRecordNum/$setSize)
//$res:=cvsCloud3_validateEmail($cus.Email)
//If (OB Is defined($res.response; "status"))

//Case of 
//: ($res.response.status="unknown")
//$isEmailValid:=0
//: ($validCriteria.indexOf($res.response.status)#-1)
//$isEmailValid:=1
//Else 
//$isEmailValid:=2
//End case 

////If ($res.response.status#"invalid")
////$isEmailValid:=1
////Else 
////$isEmailValid:=2
////End if 
//Else 
//$isEmailValid:=0
//$hasError:=True
//End if 

//$cus.isValidEmail:=$isEmailValid
//$repeatCount:=0
//Repeat 
//$status:=$cus.save()
//$repeatCount:=$repeatCount+1
//$cus.reload()
//Until (($status.success=True) | ($repeatCount=3))
//If ($repeatCount=3)
//$hasError:=True
//End if 

//If ($hasError=True)
//$errorString:=$errorString+"\n"+String($cus.CustomerID)+" - "+$cus.Email
//End if 
//$currentRecordNum:=$currentRecordNum+1
//End for each 
//Progress SET PROGRESS($progressBarID; 1)
//Progress QUIT($progressBarID)
//If ($hasError=True)
//myAlert($errorString)
//Else 
//myAlert("Emails have been verified")
//End if 
//End if 
