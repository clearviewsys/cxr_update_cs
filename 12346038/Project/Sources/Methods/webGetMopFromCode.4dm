//%attributes = {"publishedWeb":true,"shared":true}

C_TEXT:C284($1; $fieldTxt)
C_TEXT:C284($0; $description)
C_POINTER:C301($ptrField)
C_TEXT:C284($key)


$fieldTxt:=$1

If ($fieldTxt="/@")
	$fieldTxt:=Substring:C12($fieldTxt; 2)
End if 

$ptrField:=WAPI_txt2Field($fieldTxt; ->$key)

$0:=getPaymentTypeFromCode(WAPI_fieldValueToString($ptrField; $key))