//%attributes = {}
// creates definitions of properties we need to pass to MoneyGram during sending process
// returns collection of objects
//
// name - property name
// type - type of the property (string, real, datetime, ...)
// required - is property required to be present in request
// minmaxlen - length of the data in property
// mask - regex mask describing allowed characters in property value
// description - detail description of the property
// ownField - field name as definedd in MoneyGram - not affecting the code at all
// value - default value of property


C_BOOLEAN:C305($1; $isSoapTransaction)

C_COLLECTION:C1488($0; $properties)
C_OBJECT:C1216($oneProperty)

If (Count parameters:C259>=1)
	$isSoapTransaction:=$1
Else 
	$isSoapTransaction:=False:C215
End if 

$properties:=New collection:C1472

If ($isSoapTransaction)
	$oneProperty:=New object:C1471("name"; "TransactionType"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Send"; "description"; "TransactionType"; "ownField"; ""; "value"; "Send")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SessionID"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; ""; "description"; "sessionID from 4d send"; "ownField"; ""; "value"; "MGS_"+STR_getRandomString(10; 20))
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "TransferToCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country ID"; "description"; "Destination country"; "ownField"; "receiveCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "TransferSendAmount"; "type"; "real"; "required"; "yes"; "minmaxlen"; ""; "mask"; ""; "description"; "Send amount"; "ownField"; "amount"; "value"; "0")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "TransferSendCurrency"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Currency ID"; "description"; "Send currency"; "ownField"; "TransferSendCurrency"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "First name"; "ownField"; "SenderName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderLastName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Last name"; "ownField"; "SenderLastName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderSurName"; "type"; "string"; "required"; "no"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Middle name"; "ownField"; "SenderSurName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderLastName2"; "type"; "string"; "required"; "no"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "2nd Last name"; "ownField"; "SenderLastName2"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; ""; "description"; "Sender country"; "ownField"; "SenderCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderZipCode"; "type"; "string"; "required"; "yes"; "minmaxlen"; "10"; "mask"; "[0-9a-zA-Z -]*"; "description"; "Postal code"; "ownField"; "SenderZipCode"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderCity"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "City"; "ownField"; "SenderCity")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderAddress"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z0-9 \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "street, building, etc"; "ownField"; "SenderAddress")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderPhone"; "type"; "string"; "required"; "yes"; "minmaxlen"; "14/5"; "mask"; "\\d{5,14}"; "description"; "Sender telephone number - with NO country code"; "ownField"; "SenderHomePhone"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderPhoneCountryCode"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; ""; "description"; "Sender phone country code"; "ownField"; "SenderPhoneCountryCode"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderDocTypeID"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "ALN|DRV|GOV|PAS|STA"; "description"; "Type of ID"; "ownField"; "SenderDocTypeID"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderDocNumber"; "type"; "string"; "required"; "yes"; "minmaxlen"; "25"; "mask"; ""; "description"; "ID number"; "ownField"; "SenderDocNumber"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderDocIssueDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID issue"; "ownField"; "SenderDocIssueDate")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderDocIssueCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; "Country Code"; "description"; "Country of ID issue"; "ownField"; "SenderDocIssueCountry")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderDocExpireDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID expiry"; "ownField"; "SenderDocExpireDate")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderBirthDate"; "type"; "date"; "required"; "yes"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of birth"; "ownField"; "SenderBirthDate")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "SenderBirthCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; "Country Code"; "description"; "Sender country"; "ownField"; "SenderBirthCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver First name"; "ownField"; "ReceiverName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverLastName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver Last name"; "ownField"; "ReceiverLastName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverSurName"; "type"; "string"; "required"; "no"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver Middle name"; "ownField"; "ReceiverSurName")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverLastName2"; "type"; "string"; "required"; "no"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver second Last name"; "ownField"; "ReceiverLastName2")
	$properties.push($oneProperty)
	
	// added in MoneyGram specification document on January 28th 2021
	
	$oneProperty:=New object:C1471("name"; "SenderEmail"; "type"; "string"; "required"; "no"; "minmaxlen"; "60"; "mask"; ""; "description"; "Sender email address"; "ownField"; "SenderEmail")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "RewardsNumber"; "type"; "string"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "MoneyGram Plus Number"; "ownField"; "RewardsNumber")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "MarketingNotification"; "type"; "string"; "required"; "no"; "minmaxlen"; ""; "mask"; "byEmailAndSms|byEmail|bySms"; "description"; "Customer wants to receive materials for the MoneyGram services and promotions"; "ownField"; "SenderMarketingNotification")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverPhoneCountryCode"; "type"; "string"; "required"; "no"; "minmaxlen"; "3"; "mask"; ""; "description"; "Receiver telephone country code"; "ownField"; "ReceiverPhoneCountryCode")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverPhone"; "type"; "string"; "required"; "no"; "minmaxlen"; "14/5"; "mask"; "\\d{5,14}"; "description"; "Receiver telephone number - with NO country code"; "ownField"; "ReceiverPhone")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "ReceiverCountry"; "type"; "string"; "required"; "no"; "minmaxlen"; "3"; "mask"; "Country ID"; "description"; "Receiver country"; "ownField"; "ReceiverCountry")
	$properties.push($oneProperty)
Else 
	$oneProperty:=New object:C1471("name"; "transactionType"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Send"; "description"; "transactionType"; "ownField"; ""; "value"; "Send")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "sessionID"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; ""; "description"; "sessionID from 4d send"; "ownField"; ""; "value"; "MGS_"+STR_getRandomString(10; 20))
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "destinationCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Destination country"; "ownField"; "receiveCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "sendAmount"; "type"; "real"; "required"; "yes"; "minmaxlen"; ""; "mask"; ""; "description"; "Send amount"; "ownField"; "amount"; "value"; "0")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "sendCurrency"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Currency code"; "description"; "Send currency"; "ownField"; "sendCurrency"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderFirstName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "First name"; "ownField"; "senderFirstName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderLastName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Last name"; "ownField"; "senderLastName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderMiddleName"; "type"; "string"; "required"; "no"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Middle name"; "ownField"; "senderMiddleName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderLastName2"; "type"; "string"; "required"; "no"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "2nd Last name"; "ownField"; "senderLastName2"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Sender country"; "ownField"; "senderCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderZipCode"; "type"; "string"; "required"; "yes"; "minmaxlen"; "10"; "mask"; "[0-9a-zA-Z -]*"; "description"; "Postal code"; "ownField"; "senderZipCode"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderCity"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "City"; "ownField"; "senderCity")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderAddress"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z0-9 \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "street, building, etc"; "ownField"; "senderAddress")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhone"; "type"; "string"; "required"; "yes"; "minmaxlen"; "14/5"; "mask"; "\\d{5,14}"; "description"; "Sender telephone number - with NO country code"; "ownField"; "senderHomePhone"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhoneCountryCode"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; ""; "description"; "Sender phone country code"; "ownField"; "senderPhoneCountryCode"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhotoIdType"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "ALN|DRV|GOV|PAS|STA"; "description"; "Type of ID"; "ownField"; "senderPhotoIdType"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhotoIdNumber"; "type"; "string"; "required"; "yes"; "minmaxlen"; "25"; "mask"; ""; "description"; "ID number"; "ownField"; "senderPhotoIdNumber"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhotoIdIssueDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID issue"; "ownField"; "senderPhotoIdIssueDate")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhotoIdCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Country of ID issue"; "ownField"; "senderPhotoIdCountry")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderPhotoIdExpDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID expiry"; "ownField"; "senderPhotoIdExpDate")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderDOB"; "type"; "date"; "required"; "yes"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of birth"; "ownField"; "senderDOB")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "senderBirthCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Sender country"; "ownField"; "senderBirthCountry"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverFirstName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver First name"; "ownField"; "receiverFirstName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverLastName"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver Last name"; "ownField"; "receiverLastName"; "value"; "")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverMiddleName"; "type"; "string"; "required"; "no"; "minmaxlen"; "20"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver Middle name"; "ownField"; "receiverMiddleName")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverLastName2"; "type"; "string"; "required"; "no"; "minmaxlen"; "30"; "mask"; "([a-zA-Z \\-\\'\\/])*"; "description"; "Receiver second Last name"; "ownField"; "receiverLastName2")
	$properties.push($oneProperty)
	
	// added in MoneyGram specification document on January 28th 2021
	
	$oneProperty:=New object:C1471("name"; "senderEmailAddress"; "type"; "string"; "required"; "no"; "minmaxlen"; "60"; "mask"; ""; "description"; "Sender email address"; "ownField"; "senderEmailAddress")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "mgiRewardsNumber"; "type"; "string"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "MoneyGram Plus Number"; "ownField"; "mgiRewardsNumber")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "marketingNotification"; "type"; "string"; "required"; "no"; "minmaxlen"; ""; "mask"; "byEmailAndSms|byEmail|bySms"; "description"; "Customer wants to receive materials for the MoneyGram services and promotions"; "ownField"; "senderMarketingNotification")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverPhoneCountryCode"; "type"; "string"; "required"; "no"; "minmaxlen"; "3"; "mask"; ""; "description"; "Receiver telephone country code"; "ownField"; "receiverPhoneCountryCode")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverPhone"; "type"; "string"; "required"; "no"; "minmaxlen"; "14/5"; "mask"; "\\d{5,14}"; "description"; "Receiver telephone number - with NO country code"; "ownField"; "receiverPhone")
	$properties.push($oneProperty)
	
	$oneProperty:=New object:C1471("name"; "receiverCountry"; "type"; "string"; "required"; "no"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Receiver country"; "ownField"; "receiverCountry")
	$properties.push($oneProperty)
End if 

$0:=$properties
