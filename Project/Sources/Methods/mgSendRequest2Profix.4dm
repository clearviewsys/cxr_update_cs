//%attributes = {}
C_OBJECT:C1216($1; $parameters)  // what we passed to a call to SendRequest SOAP API method
C_OBJECT:C1216($0; $profixObj)

$parameters:=$1

$profixObj:=New object:C1471

$profixObj.transactionType:="Send"
$profixObj.mgiRewardsNumber:=$parameters.RewardsNumber
If ($parameters.ReceiverCountry#Null:C1517)
	$profixObj.receiverCountry:=mgCountryID2CountryCode(Num:C11($parameters.ReceiverCountry))
End if 
$profixObj.receiverLastName:=$parameters.ReceiverLastName
$profixObj.receiverLastName2:=$parameters.ReceiverLastName2
$profixObj.receiverFirstName:=$parameters.ReceiverName
$profixObj.receiverPhone:=$parameters.ReceiverPhone
$profixObj.receiverPhoneCountryCode:=$parameters.ReceiverPhoneCountryCode
$profixObj.receiverMiddleName:=$parameters.ReceiverSurName
$profixObj.senderAddress:=$parameters.SenderAddress
$profixObj.senderBirthCountry:=$parameters.SenderBirthCountry
// $profixObj.senderCountry:=mgCountryID2CountryCode (Num($parameters.SenderCountry))
$profixObj.senderCountry:=$parameters.SenderCountry
$profixObj.senderCity:=$parameters.SenderCity
$profixObj.senderPhotoIdNumber:=$parameters.SenderDocNumber
$profixObj.senderPhotoIdCountry:=$parameters.SenderDocIssueCountry
$profixObj.senderPhotoIdType:=$parameters.SenderDocTypeID
$profixObj.senderEmailAddress:=$parameters.SenderEmail
$profixObj.senderLastName:=$parameters.SenderLastName
$profixObj.senderLastName2:=$parameters.SenderLastName2
$profixObj.senderFirstName:=$parameters.SenderName
$profixObj.senderPhone:=$parameters.SenderPhone
$profixObj.senderPhoneCountryCode:=$parameters.SenderPhoneCountryCode
$profixObj.senderMiddleName:=$parameters.SenderSurName
$profixObj.senderZipCode:=$parameters.SenderZipCode
$profixObj.senderDOB:=Substring:C12($parameters.SenderBirthDate; 1; 10)
$profixObj.senderPhotoIdExpDate:=Substring:C12($parameters.SenderDocExpireDate; 1; 10)
$profixObj.senderPhotoIdIssueDate:=Substring:C12($parameters.SenderDocIssueDate; 1; 10)
$profixObj.destinationCountry:=mgCountryID2CountryCode(Num:C11($parameters.TransferToCountry))
$profixObj.sendAmount:=$parameters.TransferSendAmount
$profixObj.sendCurrency:=mgCurrencyID2CurrencyCode(Num:C11($parameters.TransferSendCurrency))


$0:=$profixObj
