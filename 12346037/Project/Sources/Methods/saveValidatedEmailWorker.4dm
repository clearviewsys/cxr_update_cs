//%attributes = {}
//// ----------------------------------------------------
//// User name (OS): viktor
//// Date and time: 06/06/21, 00:31:59
//// ----------------------------------------------------
//// Method: saveValidatedEmailWorker
//// Description
//// 
////
//// Parameters
//var $entityEmail; $1 : Text
//var $emailStatus; $2 : Text
//var $validCriteria; $3 : Collection
//var $finalObj; $4 : Object
//// ----------------------------------------------------
//var 

C_LONGINT:C283($i; $1)
C_OBJECT:C1216($3; $entity; $4; $sharedObj)
C_TEXT:C284($2; $email)

//Case of 
//: (Count parameters=4)
$i:=$1
$email:=$2
$entity:=$3.entitySelection.copy()
//$edit:=$entityEmail.copy()
//$edit.Email:="something@example.com"
//$edit.save()
//$emailStatus:=$2
//$validCriteria:=$3
$sharedObj:=$4

$entity[0].Email:="viktor@example.com"
$entity[0].save()
//Use ($sharedObj)
//$result:=
//end use
//$edit:=$finalObj[$entityEmail]
//$edit2:=$edit.copy()
//$edit2.Email:="something@example.com"
//$edit2.save()
//Else 
//assertInvalidNumberOfParams(Current method name; Count parameters)
//End case 
//Use ($finalObj)
//$entity:=$finalObj[$entityEmail]
//End use 
//$hasError:=False

//If ($emailStatus#"error")
//Case of 
//: ($emailStatus="unknown")
//$isEmailValid:=0
//: ($validCriteria.indexOf($emailStatus)#-1)
//$isEmailValid:=1
//Else 
//$isEmailValid:=2
//End case 
//Else 
//$isEmailValid:=0
//$hasError:=True
//End if 

//$entity.isValidEmail:=$isEmailValid
//$repeatCount:=0
//Repeat 
//$status:=$entity.save()
//$repeatCount:=$repeatCount+1
//$entity.reload()
//Until (($status.success=True) | ($repeatCount=3))
//If ($repeatCount=3)
//$hasError:=True
//End if 

//If ($hasError=True)
//Use ($finalObj)
//$finalObj.errorString:=$finalObj.errorString+"\n"+String($entity.CustomerID)+" - "+$entity.Email
//End use 
//End if 

//Use ($finalObj)
//$finalObj.count:=$finalObj.count+1
//End use 

KILL WORKER:C1390