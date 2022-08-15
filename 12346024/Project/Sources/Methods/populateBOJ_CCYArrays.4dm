//%attributes = {}
// this method populates two parallel arrays

C_POINTER:C301($arrKeysPtr; $arrValuesPtr; $1; $2)
Case of 
	: (Count parameters:C259=2)
		$arrKeysPtr:=$1
		$arrValuesPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "JMD"; "000"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "USD"; "001"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "CAD"; "002"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "DEM"; "003"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "FRF"; "004"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "CHF"; "005"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "ITL"; "006"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "ITL"; "007"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "VEF"; "008"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "VEB"; "008"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "KYD"; "009"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "AUS"; "010"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BZD"; "011"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "SEK"; "012"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BEF"; "013"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BEC"; "013"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NLG"; "014"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NOK"; "015"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "IEP"; "016"; False:C215)  // Ireland"
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "GBP"; "017"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "XCD"; "018"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BBD"; "019"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "TTD"; "020"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "DKK"; "021"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "JPY"; "022"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "AUD"; "023"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "XOF"; "024"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "XAF"; "024"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "CNY"; "025"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "RMB"; "025"; False:C215)

appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "GYD"; "026"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "XDR"; "027"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "INR"; "028"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BSD"; "029"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "EUR"; "030"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "HKD"; "031"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "BMD"; "032"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "GIP"; "033"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "IEP"; "034"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "DOP"; "035"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "NZD"; "036"; False:C215)
appendKeyValueToArrays($arrKeysPtr; $arrValuesPtr; "VEF"; "037"; False:C215)
