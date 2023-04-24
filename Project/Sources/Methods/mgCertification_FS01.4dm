//%attributes = {}
//C_OBJECT($quotes; $0; $deliveryOption; $parameters; $transaction; $1; $client; $methodInfo; $result; $transfer)
//C_TEXT($deliveryOptionCode; $sendCurrencyCode; $sendToCountryCode)
//C_REAL($amount)

//C_BOOLEAN($logmgSOAP)

//$logmgSOAP:=mgLOG_isLoggingEnabled

//$client:=$1

//$deliveryOption:=New object

//$amount:=900
//$sendCurrencyCode:="AUD"
//$sendCurrencyCode:="NZD"

//$sendToCountryCode:="GEO"
//$deliveryOptionCode:="WILL_CALL"

//$deliveryOption.DeliveryOptionCode:=$deliveryOptionCode

//$deliveryOption.Country:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$deliveryOption.TransferSendCurrency:=String(mgCurrencyCode2CurrencyID($sendCurrencyCode); "000")
//$deliveryOption.TransferCurrency:="978"  // EUR
//$deliveryOption.TransferCurrency:="840"  // USD
//$deliveryOption.TransferSendAmount:="900.00"

//$transaction:=mgNewTransactionByCustomer("Send"; $client)

//If ($transaction#Null)

//$transaction.object.receiverFirstName:="James"
//$transaction.object.receiverLastName:="Bond"

//$methodInfo:=mgGetSendRequestMethodInfo($deliveryOption)

//If ($methodInfo.success)

//$parameters:=mgBuildSendRequestTransaction($transaction.object; $deliveryOption; $methodInfo)

//$parameters.FormFreeStaging:="True"

//$parameters.TransferSourceOfFunds:="SALARY_EMPLOY"
//$parameters.SenderZipCode:=$client.PostalCode
//$parameters.SenderState:=$client.Province
//$parameters.SenderOccupation:="ENGINEER"
//$parameters.ReceiverAddress:="Some street 5"
//$parameters.ReceiverCity:="Tbilisi"
//$parameters.ReceiverCountry:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$parameters.TransferSendPurpose:="BILLS"
//$parameters.SenderRelationship:="EMPLOY_EMPLOYER"
//$parameters.ReceiverZipCode:="0101"
//$parameters.ReceiverPhoneNumber:="1212762456"

//$parameters:=mgFilterSendRequestByMethodInfo($parameters; $methodInfo)

//$result:=mgSendRequest($parameters)

//If ($result.success)

//$transfer:=mgGetTransferByFormFreeStageNum($result.result.ConfirmationNumber; $deliveryOption.TransferSendAmount)

//If ($transfer.success)
//If ($transfer.result#Null)
//If ($transfer.result.length>0)
//// confirm send transfer
//$0:=mgSendConfirm($transfer.result[0].TransferSysId)
//If ($0.success)
//ALERT("FS01 certification test passed")
//End if 
//End if 
//End if 
//Else 
//If ($logmgSOAP)
//// mgLOG transfer find fail
//mgLOG("Transfer search failed "+JSON Stringify($transfer; *))
//End if 
//End if 

//Else 

//If ($logmgSOAP)
//mgLOG("SendRequest failed "+JSON Stringify($result; *))
//End if 
//End if 

//End if 

//End if 
