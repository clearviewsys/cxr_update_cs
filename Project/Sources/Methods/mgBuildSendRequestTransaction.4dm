//%attributes = {}
// combines selected delivery option and MoneyGram send transaction object prepared for Profix Web app
// into object suitable to pass to SendRequest SOAP API call
// if methodInfo passed, removes properties from transaction not present in methodInfo

C_OBJECT:C1216($1; $transaction)
C_OBJECT:C1216($2; $deliveryOption)
C_OBJECT:C1216($3; $methodInfo)
C_OBJECT:C1216($0; $result)

$transaction:=$1  // entity
$deliveryOption:=$2  // object

If (Count parameters:C259>2)
	$methodInfo:=$3
End if 

$result:=New object:C1471

$result.DeliveryOptionCode:=$deliveryOption.DeliveryOptionCode  // mandatory
$result.TransferToCountry:=$deliveryOption.Country  // mandatory
$result.TransferSendAmount:=$deliveryOption.TransferSendAmount  // mandatory
$result.TransferSendCurrency:=$deliveryOption.TransferSendCurrency  // non-mandatory
$result.TransferCurrency:=$deliveryOption.TransferCurrency  // mandatory
$result.SenderResidence:="true"  // mandatory

// $result.TransferToPointShortName:=$deliveryOption.TransferToPointShortName
$result.TransferToPointId:=$deliveryOption.TransferToPointId

If ($transaction.mgiRewardsNumber#"")
	$result.RewardsNumber:=$transaction.mgiRewardsNumber
End if 

$result.ReceiverCountry:=$transaction.receiverCountry
$result.ReceiverLastName:=$transaction.receiverLastName
$result.ReceiverLastName2:=$transaction.receiverLastName2
$result.ReceiverName:=$transaction.receiverFirstName
$result.ReceiverAddress:=$transaction.receiverAddress
$result.ReceiverCity:=$transaction.receiverCity
$result.ReceiverState:=$transaction.receiverState
$result.ReceiverProvince:=$transaction.receiverProvince
$result.ReceiverZipCode:=$transaction.receiverZipCode
$result.ReceiverCountryCode:=$transaction.receiverCountryCode
$result.ReceiverPhone:=$transaction.receiverPhone
$result.ReceiverPhoneCountryCode:=$transaction.receiverPhoneCountryCode
$result.ReceiverSurName:=$transaction.receiverMiddleName
$result.SenderAddress:=$transaction.senderAddress

// if we don't pass country iD we are not passing certification test, that is why countryID is required here @milan 02/04/22
$result.SenderBirthCountry:=mgCountryCode2CountryID($transaction.senderBirthCountry)

$result.SenderBirthDate:=mgGetProfixDate($transaction.senderDOB; 0)  // time must be zero to pass certification tests

$result.SenderCountry:=mgCountryCode2CountryID($transaction.senderCountry)
$result.SenderCity:=$transaction.senderCity
$result.SenderEmail:=$transaction.senderEmailAddress
$result.SenderLastName:=$transaction.senderLastName
$result.SenderLastName2:=$transaction.senderLastName2
$result.SenderName:=$transaction.senderFirstName
$result.SenderPhone:=$transaction.senderPhone
$result.SenderPhoneCountryCode:=$transaction.senderPhoneCountryCode
$result.SenderSurName:=$transaction.senderMiddleName
$result.SenderZipCode:=$transaction.senderZipCode

$result.SenderDocExpireDate:=mgGetProfixDate($transaction.senderPhotoIdExpDate; 0)  // time must be zero to pass certificatin tests

$result.SenderDocNumber:=$transaction.senderPhotoIdNumber

// if we don't pass country iD we are not passing certification test, that is why countryID is required here @milan 02/04/22
$result.SenderDocIssueCountry:=mgCountryCode2CountryID($transaction.senderPhotoIdCountry)

$result.SenderDocIssueDate:=mgGetProfixDate($transaction.senderPhotoIdIssueDate; 0)  // time must be zero to pass certification tests

$result.SenderDocTypeID:=$transaction.senderPhotoIdType  // doesnt' seem to match MG's list
//MGCodes: DRV=Driver's License Number, PAS=Passport, GOV=Government ID, ALN=Alien ID
$result.SenderOccupation:=$transaction.senderOccupation
$result.SenderRelationship:=$transaction.senderRelationship  // need to map to MG
//MG Codes: AQUAINTANCE= , BUSINESS_PARTNER= , CLIENT= , EMPLOY_EMPLOYER=employee, FAMILY= , FRIENT= , CONTRACTOR= 
//     EMPLOYER= , MYSELF= , ONLINE_FRIEND= , THIRD_PARTY= , VENDOR= 

If ($methodInfo#Null:C1517)
	$result:=mgFilterSendRequestByMethodInfo($result; $methodInfo)
End if 


$0:=$result
