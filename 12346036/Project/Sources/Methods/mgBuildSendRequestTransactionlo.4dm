//%attributes = {}
// combines selected delivery option and MOneyGram send transactionobject prepared for Profix Web app
// into object suittable to pass to SendRequest SOAP API call

C_OBJECT:C1216($1; $transaction)
C_OBJECT:C1216($2; $deliveryOption)
C_OBJECT:C1216($0; $result)

$transaction:=$1  // entity
$deliveryOption:=$2  // object

$result:=New object:C1471

$result.DeliveryOptionCode:=$deliveryOption.DeliveryOptionCode  // mandatory
$result.TransferToCountry:=$deliveryOption.Country  // mandatory
$result.TransferSendAmount:=$deliveryOption.TransferSendAmount  // mandatory
$result.TransferSendCurrency:=$deliveryOption.TransferSendCurrency  // non-mandatory
$result.TransferCurrency:=$deliveryOption.TransferCurrency  // mandatory
$result.SenderResidence:="true"  // mandatory

$result.RewardsNumber:=$transaction.mgiRewardsNumber
$result.ReceiverCountry:=$transaction.receiverCountry
$result.ReceiverLastName:=$transaction.receiverLastName
$result.ReceiverLastName2:=$transaction.receiverLastName2
$result.ReceiverName:=$transaction.receiverFirstName
$result.ReceiverPhone:=$transaction.receiverPhone
$result.ReceiverPhoneCountryCode:=$transaction.receiverPhoneCountryCode
$result.ReceiverSurName:=$transaction.receiverMiddleName
$result.SenderAddress:=$transaction.senderAddress
$result.SenderBirthCountry:=$transaction.senderBirthCountry
$result.SenderBirthDate:=mgGetProfixDate($transaction.senderDOB)
$result.SenderCountry:=$transaction.senderCountry
$result.SenderCity:=$transaction.senderCity
$result.SenderDocExpireDate:=mgGetProfixDate($transaction.senderPhotoIdExpDate)
$result.SenderDocNumber:=$transaction.senderPhotoIdNumber
$result.SenderDocIssueCountry:=$transaction.senderPhotoIdCountry
$result.SenderDocIssueDate:=mgGetProfixDate($transaction.senderPhotoIdIssueDate)
$result.SenderDocTypeID:=$transaction.senderPhotoIdType
$result.SenderEmail:=$transaction.senderEmailAddress
$result.SenderLastName:=$transaction.senderLastName
$result.SenderLastName2:=$transaction.senderLastName2
$result.SenderName:=$transaction.senderFirstName
$result.SenderPhone:=$transaction.senderPhone
$result.SenderPhoneCountryCode:=$transaction.senderPhoneCountryCode
$result.SenderSurName:=$transaction.senderMiddleName
$result.SenderZipCode:=$transaction.senderZipCode


$0:=$result
