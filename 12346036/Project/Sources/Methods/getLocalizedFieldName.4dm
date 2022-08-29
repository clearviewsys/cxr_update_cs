//%attributes = {}
// getLocalizedFieldName (->field) : localizedString
// this will look into the XLIFF file and return the associated translation for the field

C_POINTER:C301($1; $fieldPtr)
C_TEXT:C284($0; $localizedString)

Case of 
	: (Count parameters:C259=0)
		$fieldPtr:=->[Currencies:6]CurrencyCode:1
	: (Count parameters:C259=1)
		$fieldPtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$localizedString:=Get localized string:C991(Field name:C257($fieldPtr))
If ($localizedString="")
	$localizedString:=Field name:C257($fieldPtr)
End if 
$0:=$localizedString