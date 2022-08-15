//%attributes = {}
C_POINTER:C301($arrKeysPtr; $arrValuesPtr; $1; $2)
$arrKeysPtr:=$1
$arrValuesPtr:=$2


appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "ON"; "Ontario"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "QC"; "Quebec"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NS"; "Nova Scotia"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NB"; "New Brunswick"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "MB"; "Manitoba"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BC"; "British Columbia"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "PE"; "Prince Edward Island"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "SK"; "Saskatchewan"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "AB"; "Alberta"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NL"; "Newfoundland and Labrador"; True:C214)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NT"; "Northwest"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "YT"; "Yukon"; True:C214)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NU"; "Nunavut"; True:C214)