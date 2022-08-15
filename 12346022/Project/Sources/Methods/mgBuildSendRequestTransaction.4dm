//%attributes = {}
// combines selected delivery option and MOneyGram send transactionobject prepared for Profix Web app
// into object suittable to pass to SendRequest SOAP API call

C_OBJECT:C1216($1; $transaction)
C_OBJECT:C1216($2; $deliveryOption)
C_OBJECT:C1216($0; $result)
C_TIME:C306($now)

$transaction:=$1  // entity
$deliveryOption:=$2  // object

$now:=Current time:C178

$result:=New object:C1471

$result.DeliveryOptionCode:=$deliveryOption.DeliveryOptionCode  // mandatory
$result.TransferToCountry:=$deliveryOption.Country  // mandatory
$result.TransferSendAmount:=$deliveryOption.TransferSendAmount  // mandatory
$result.TransferSendCurrency:=$deliveryOption.TransferSendCurrency  // non-mandatory
$result.TransferCurrency:=$deliveryOption.TransferCurrency  // mandatory
$result.SenderResidence:="true"  // mandatory

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

//$result.ReceiverProvince:=$transaction.receiverProvince
$result.ReceiverZipCode:=$transaction.receiverZipCode
$result.ReceiverCountryCode:=$transaction.receiverCountryCode

$result.ReceiverPhone:=$transaction.receiverPhone
$result.ReceiverPhoneCountryCode:=$transaction.receiverPhoneCountryCode
$result.ReceiverSurName:=$transaction.receiverMiddleName


$result.SenderAddress:=$transaction.senderAddress
$result.SenderBirthCountry:=mgCountryCode2CountryID($transaction.senderBirthCountry)
$result.SenderBirthDate:=mgGetProfixDate($transaction.senderDOB; 0)
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

$result.SenderDocExpireDate:=mgGetProfixDate($transaction.senderPhotoIdExpDate; 0)
$result.SenderDocNumber:=$transaction.senderPhotoIdNumber
$result.SenderDocIssueCountry:=mgCountryCode2CountryID($transaction.senderPhotoIdCountry)
$result.SenderDocIssueDate:=mgGetProfixDate($transaction.senderPhotoIdIssueDate; 0)
$result.SenderDocTypeID:=$transaction.senderPhotoIdType  // doesnt' seem to match MG's list
//MGCodes: DRV=Driver's License Number, PAS=Passport, GOV=Government ID, ALN=Alien ID
$result.SenderOccupation:=$transaction.senderOccupation
$result.SenderRelationship:=$transaction.senderRelationship  // need to map to MG
//MG Codes: AQUAINTANCE= , BUSINESS_PARTNER= , CLIENT= , EMPLOY_EMPLOYER=employee, FAMILY= , FRIENT= , CONTRACTOR= 
//     EMPLOYER= , MYSELF= , ONLINE_FRIEND= , THIRD_PARTY= , VENDOR= 

$0:=$result
