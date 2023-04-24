//%attributes = {}
// creates definitions of properties we need to pass to MoneyGram during receiving process
// returns collectin of objects
//
// name - property name
// type - type of the property (string, real, datetime, ...)
// required - is property required to be present in request
// minmaxlen - length of the data in property
// mask - regex mask describing allowed characters in property value
// description - detail description of the property
// ownField - field name as defined in 4D structure?
// value - default value of property

C_COLLECTION:C1488($0; $properties)
C_OBJECT:C1216($oneProperty)

$properties:=New collection:C1472

$oneProperty:=New object:C1471("name"; "transactionType"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Receive"; "description"; "transactionType from 4d receive"; "ownField"; ""; "value"; "Receive")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "sessionID"; "type"; "string"; "required"; "yes"; "minmaxlen"; "30"; "mask"; ""; "description"; "sessionID from 4d receive"; "ownField"; ""; "value"; "MGR_"+STR_getRandomString(10; 20))
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "referenceNumber"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; ".{8}"; "description"; "MG Reference number"; "ownField"; "referenceNumber")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Receiver country"; "ownField"; "receiverCountry")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverZipCode"; "type"; "real"; "required"; "yes"; "minmaxlen"; "10"; "mask"; "[0-9a-zA-Z -]*"; "description"; "Receiver ZIP code"; "ownField"; "receiverZipCode")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverCity"; "type"; "string"; "required"; "yes"; "minmaxlen"; "40"; "mask"; "([a-zA-Z \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "City address"; "ownField"; "receiverCity")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverAddress"; "type"; "real"; "required"; "yes"; "minmaxlen"; "30"; "mask"; "([a-zA-Z0-9 \\#\\/\\.\\\"\\'\\,\\(\\)\\-])*"; "description"; "Receiver Address street, building, etc"; "ownField"; "receiverAddress")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhone"; "type"; "real"; "required"; "yes"; "minmaxlen"; "14/5"; "mask"; "\\d{5,14}"; "description"; "Receiver phone number"; "ownField"; "receiverPhone")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhoneCountryCode"; "type"; "string"; "required"; "yes"; "minmaxlen"; "3"; "mask"; ""; "description"; "Receive currency"; "ownField"; "receiverPhoneCountryCode")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhotoIdType"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "ALN|DRV|GOV|PAS|STA"; "description"; "Type of ID"; "ownField"; "receiverPhotoIdType")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhotoIdNumber"; "type"; "string"; "required"; "yes"; "minmaxlen"; "25"; "mask"; ""; "description"; "ID number"; "ownField"; "receiverPhotoIdNumber"; "value"; "")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhotoIdIssueDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID issue"; "ownField"; "receiverPhotoIdIssueDate"; "value"; "")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhotoIdCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Country of ID issue"; "ownField"; "receiverPhotoIdCountry"; "value"; "")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverPhotoIdExpDate"; "type"; "date"; "required"; "no"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of ID expiry"; "ownField"; "receiverPhotoIdExpDate"; "value"; "")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverDOB"; "type"; "date"; "required"; "yes"; "minmaxlen"; ""; "mask"; ""; "description"; "Date of birth"; "ownField"; "receiverDOB"; "value"; "")
$properties.push($oneProperty)

$oneProperty:=New object:C1471("name"; "receiverBirthCountry"; "type"; "string"; "required"; "yes"; "minmaxlen"; ""; "mask"; "Country code"; "description"; "Sender country"; "ownField"; "receiverBirthCountry")
$properties.push($oneProperty)

$0:=$properties
