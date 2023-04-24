//%attributes = {}
ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrPictureIDTypes; 0)

ALL RECORDS:C47([PictureIDTypes:92])
SELECTION TO ARRAY:C260([PictureIDTypes:92]GovernmentCode:15; $arrCodes; [PictureIDTypes:92]Description:14; $arrPictureIDTypes)

C_POINTER:C301($arrKeysPtr; $arrValuesPtr)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "1"; "Birth certificate")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "2"; "Client code")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "A"; "Driver's licence")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "B"; "Government ID (example: Military ID, Police ID)")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "C"; "Identification card")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "D"; "Identification issued by Reporting Entity (example: bank card)")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "E"; "Other")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "F"; "Passport")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "G"; "Proof of address (utility bills, etc.)")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "K"; "RealMe")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "H"; "Suspected fraudulent")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "I"; "Tax identification card/number (social security card, IRD card, etc.)")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "-"; "unknown")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "J"; "Voter information/registrations")

populateCurrencyArrays(->$arrCodes; ->$arrPictureIDTypes)

ARRAY TO SELECTION:C261($arrCodes; [PictureIDTypes:92]GovernmentCode:15; $arrPictureIDTypes; [PictureIDTypes:92]Description:14)
UNLOAD RECORD:C212([PictureIDTypes:92])

READ ONLY:C145([PictureIDTypes:92])

allRecordsPictureIDTypes