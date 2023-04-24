//%attributes = {}
C_POINTER:C301($arrKeysPtr; $arrValuesPtr; $1; $2)
$arrKeysPtr:=$1
$arrValuesPtr:=$2

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BBB"; "Better Business Bureau Claim")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "Book"; "Customer Needs To Book <> Amount Of A Certain Currency")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "Call"; "Customer Asked To Be Contacted")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BankState"; "Customer Was Asked To Provide Bank Statement")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "PhoneUp"; "Phone Number Updated From: <> To: <>")
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "AddressUp"; "Address Updated From: <> To: <>")