//%attributes = {}
//C_OBJECT($mgCredentials; $result; $parameters; $client; $transaction; $deliveryOption; $methodInfo; $transfer)
//C_OBJECT($fs01result; $fs02result; $fs03result; $fs04result; $fs0401result; $fs08result; $getTransferParams; $quotes)
//C_REAL($amount)
//C_TEXT($sendCurrencyCode; $sendToCountryCode; $deliveryOptionCode; $msg)

//mgLOG_Start

//$mgCredentials:=mgGetCredentials

//If (True)  // we have to use these one for certification tests
//$mgCredentials.agentID:="40359591"
//$mgCredentials.password:="123123"
//$mgCredentials.username:="clerk"
//mgCredentialsStore($mgCredentials)  // so that we use this in following calls
//End if 

//If (True)
//$client:=ds.Customers.query("CustomerID = :1"; "TTCUS1029216").first()  // Tiran
//Else 
//// $client:=ds.Customers.query("CustomerID = :1";"IBCUS1000583").first()  // Barclay
//$client:=ds.Customers.query("CustomerID = :1"; "WEBCUS177107").first()  // Barclay @ NZ test server
//End if 


//If ($client#Null)

//TRACE

//If (True)  // FS01
////------------ FS01 -----------------------
//$deliveryOption:=New object

//$amount:=900
//$sendCurrencyCode:="AUD"
//$sendToCountryCode:="GEO"
//$deliveryOptionCode:="WILL_CALL"
//// $deliveryOptionCode:="DIRECT_TO_ACCT"


//$deliveryOption.DeliveryOptionCode:=$deliveryOptionCode

//$deliveryOption.Country:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$deliveryOption.TransferSendCurrency:=String(mgCurrencyCode2CurrencyID($sendCurrencyCode); "000")
//$deliveryOption.TransferCurrency:="978"  // EUR
//$deliveryOption.TransferCurrency:="840"  // USD
//$deliveryOption.TransferSendAmount:="900.00"

//// $quotes:=mgGetQuote ($amount;$sendCurrencyCode;$sendToCountryCode)
//// $deliveryOption:=$quotes.query("DeliveryOptionCode = :1";$deliveryOptionCode).first()

//$transaction:=mgNewTransactionByCustomer("Send"; $client)

//If ($transaction#Null)

//$transaction.object.receiverFirstName:="James"
//$transaction.object.receiverLastName:="Bond"

//$parameters:=mgBuildSendRequestTransaction($transaction.object; $deliveryOption)
//$parameters.FormFreeStaging:="True"

//$methodInfo:=mgGetSendRequestMethodInfo($deliveryOption)

//If ($methodInfo.success)

//// 5) Additional specify fields TransferSourceOfFunds, SenderZipCode
////SET TEXT TO PASTEBOARD(JSON Stringify($methodInfo;*))

//$parameters.TransferSourceOfFunds:="SALARY_EMPLOY"
//$parameters.SenderZipCode:=$client.PostalCode
//$parameters.SenderState:=$client.Province

//// required properties

//$parameters.SenderOccupation:="ENGINEER"
//$parameters.ReceiverAddress:="Some street 5"
//$parameters.ReceiverCity:="Tbilisi"
//$parameters.ReceiverCountry:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$parameters.TransferSendPurpose:="BILLS"
//$parameters.SenderRelationship:="EMPLOY_EMPLOYER"
//$parameters.ReceiverZipCode:="0101"

//$result:=mgSendRequest($parameters)

//If ($result.success)

//// perform transfer search by ConfirmationNumber

//$transfer:=mgGetTransferByFormFreeStageNum($result.result.ConfirmationNumber; $deliveryOption.TransferSendAmount)

//If ($transfer.success)
//If ($transfer.result#Null)
//If ($transfer.result.length>0)
//// confirm send transfer
//$fs01result:=mgSendConfirm($transfer.result[0].TransferSysId)
//If ($fs01result.success)
//ALERT("FS01 certification test passed")
//End if 
//End if 
//End if 
//End if 

//Else 
//SET TEXT TO PASTEBOARD(JSON Stringify($result; *))
//End if 

//Else 
//SET TEXT TO PASTEBOARD($methodInfo.response)
//End if 

//End if 

////------------ FS01 end-----------------------
//End if 

//If (True)  // FS02
////------------ FS02 -----------------------
//$deliveryOption:=New object
//$methodInfo:=New object
//$transaction:=New object
//$parameters:=New object

//$amount:=600
//$sendCurrencyCode:="AUD"
//$sendToCountryCode:="VNM"
//$deliveryOptionCode:="WILL_CALL"

//$deliveryOption.DeliveryOptionCode:=$deliveryOptionCode

//$deliveryOption.Country:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$deliveryOption.TransferSendCurrency:=String(mgCurrencyCode2CurrencyID($sendCurrencyCode); "000")
//$deliveryOption.TransferCurrency:=String(mgCurrencyCode2CurrencyID("USD"); "000")  // USD
//$deliveryOption.TransferSendAmount:="600.00"

//$transaction:=mgNewTransactionByCustomer("Send"; $client)

//If ($transaction#Null)

//$transaction.object.receiverFirstName:="Luke"
//$transaction.object.receiverLastName:="Skywalker"

//$parameters:=mgBuildSendRequestTransaction($transaction.object; $deliveryOption)
//$parameters.FormFreeStaging:="True"

//$methodInfo:=mgGetSendRequestMethodInfo($deliveryOption)

//If ($methodInfo.success)

//// 5) Additional specify fields TransferSourceOfFunds, SenderZipCode, SenderPhoneNumber

//$parameters.TransferSourceOfFunds:="SALARY_EMPLOY"
//$parameters.SenderZipCode:=$client.PostalCode
//$parameters.SenderState:=$client.Province
//$parameters.SenderPhone:=$client.CellPhone
//// $parameters.SenderPhoneCountryCode:="1"

//// required properties

//$parameters.SenderOccupation:="ENGINEER"
//$parameters.ReceiverAddress:="Some street 5"
//$parameters.ReceiverCity:="Ha Noi"
//$parameters.ReceiverCountry:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$parameters.TransferSendPurpose:="BILLS"
//$parameters.SenderRelationship:="EMPLOY_EMPLOYER"
//$parameters.ReceiverZipCode:="0101"

//$fs02result:=mgSendRequest($parameters)

//If ($fs02result.success)

//// do nothing, this is all for this test
//ALERT("FS02 certification test passed")

//Else 
//SET TEXT TO PASTEBOARD(JSON Stringify($result; *))
//End if 

//Else 
//SET TEXT TO PASTEBOARD($methodInfo.response)
//End if 

//End if 

////------------ FS02 end -----------------------
//End if 

//If (True)  // FS03

//If ($fs02result.success)

//$getTransferParams:=New object("SenderPhone"; $client.CellPhone; "TransferSearchMode"; 3; \
"TransferSendAmount"; "600.00"; "SenderName"; $client.FirstName; "SenderLastName"; $client.LastName; "SynchronizeTransfer"; "TRUE")

//$fs03result:=mgGetTransfer($getTransferParams)

//If ($fs03result.success)
//ALERT("FS03 certification test passed")
//End if 

//End if 

//End if 

//If (True)  // FS04

//If ($fs03result.success)
//If ($fs03result.result#Null)
//If ($fs03result.result.length>0)
//$transfer:=mgGetTransferByFormFreeStageNum($fs03result.result[0].ConfirmationNumber; "600")
//If ($transfer.success)
//If ($transfer.result.length>0)
//// confirm send transfer
//$fs04result:=mgSendConfirm($transfer.result[0].TransferSysId)
////$fs04result:=mgSendConfirm ($fs03result.result[0].FormFreeStaging)
//If ($fs04result.success)
//ALERT("FS04 certification test passed")
//End if 
//End if 
//End if 
//End if 
//End if 
//End if 

//End if 

//If (True)  // FS0401

//$fs0401result:=mgSendConfirm("1234567")

//If ($fs0401result.success)

//Else 
//ALERT("FS0401 certification test passed")  // it is suppose to be not successful
//End if 

//End if 

//If (True)  // FS08

//$amount:=600
//$sendCurrencyCode:="AUD"
//$sendToCountryCode:="IND"
//$deliveryOptionCode:="BANK_DEPOSIT"

//$quotes:=mgGetQuote($amount; $sendCurrencyCode; $sendToCountryCode)

//If ($quotes.success)

////C_COLLECTION($col)

////$col:=$quotes.result.query("DeliveryOptionCode = :1";$deliveryOptionCode)

////If ($col#Null)
////If ($col.length>0)
////$deliveryOption:=$col[0]
////End if 
////End if 

//$deliveryOption:=mgGetDeliveryOptionFromQuotes($quotes.result; New object("DeliveryOptionCode"; $deliveryOptionCode))

//End if 


//If ($deliveryOption#Null)

//$transaction:=mgNewTransactionByCustomer("Send"; $client)

//If ($transaction#Null)

//$transaction.object.receiverFirstName:="Mahatma"
//$transaction.object.receiverLastName:="Gandi"

//$parameters:=mgBuildSendRequestTransaction($transaction.object; $deliveryOption)
//$parameters.FormFreeStaging:="True"

//$methodInfo:=mgGetSendRequestMethodInfo($deliveryOption)

//If ($methodInfo.success)

//// values provided by MoneyGram for this test specifically
//$parameters.RECEIVERBANKIDENTIFIER:="SBIN0005943"
//$parameters.accountNumber:="00218070062"
////-------------------------------------------

//$parameters.TransferSourceOfFunds:="SALARY_EMPLOY"
//$parameters.SenderZipCode:=$client.PostalCode
//$parameters.SenderState:=$client.Province
//$parameters.SenderPhone:=$client.CellPhone
//$parameters.SenderOccupation:="ENGINEER"
//$parameters.ReceiverAddress:="3, Chelmsford Rd"
//$parameters.ReceiverCity:="New Delhi"
//$parameters.ReceiverCountry:=String(mgCountryCode2CountryID($sendToCountryCode); "000")
//$parameters.TransferSendPurpose:="BILLS"
//$parameters.SenderRelationship:="EMPLOY_EMPLOYER"
//$parameters.ReceiverZipCode:="110006"

//$fs08result:=mgSendRequest($parameters)

//If ($fs08result.success)


//End if 

//End if 

//End if 

//End if 


//End if 

//End if 

//mgLOG_Save

//mgLOG_Stop
