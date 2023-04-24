//%attributes = {}
// _______test
C_TEXT:C284($IBAN; $errCode; $bankName; $countryCode; $city; $address; $swift; $validCheckSum)
//$IBAN:="FR 86300040032 00001019471670A"  // Incorrect
//$IBAN:="FR 86300040032 00001019471670"  // Correct
$IBAN:="FR 7630006000011234567890189"
//validateIBAN($IBAN;->$errCode;->bankName;->countryCode;->city;->address;->swift;->validCheckSum)
validateIBAN_NewXML($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$swift; ->$validCheckSum)
ALERT:C41("errorCode: "+String:C10($errCode)+" / Bank Name: "+$bankName)
ALERT:C41(": "+$bankName+" - "+$city+" - "+$swift+" ")


validateIBAN($IBAN; ->$errCode; ->$bankName; ->$countryCode; ->$city; ->$address; ->$swift; ->$validCheckSum)
ALERT:C41("errorCode: "+String:C10($errCode)+" / Bank Name: "+$bankName)
ALERT:C41(": "+$bankName+" - "+$city+" - "+$swift+" ")